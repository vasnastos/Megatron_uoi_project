import time
import queue
from struct import *

from multiprocessing.connection import Client
from serial_port import CMDHandler

class Dataport:
    singleton_instance=None

    # commands
    CMD_GET_TIME = 150
    CMD_GET_DATE = 151
    CMD_GET_SETTINGS = 152
    CMD_GET_DATA = 153
    CMD_GET_FEEDBACK = 154
    CMD_SET_VALUE = 155
    CMD_CANCEL_ACTION = 156
    DATA_LOGGING_PERIOD_MSEC=20

    @staticmethod
    def get_instance():
        if Dataport.singleton_instance==None:
            Dataport.singleton_instance=Dataport()
        
        return Dataport.singleton_instance

    def __init__(self):
        self.queue_pipe=queue.Queue()
        self.fh_a=0
        self.datalog_cmd_good=0
        self.datalog_cmd_total=1
        self.next_datalog_time=0
    
    def add_cmd(self,f):    
        self.queue_pipe.put(f)
    
    def run_serial_cmd(self):
        if not self.queue_pipe.empty():
            f=self.queue_pipe.get()
            func=f[0]
            arguments=f[1]
            func(arguments)
            self.queue_pipe.task_done()
    
    def run_datalog(self):
        time_now = time.time()*1000
        if CMDHandler.bdata_logging and time_now>self.next_datalog_time:
            self.next_datalog_time=time_now+Dataport.DATA_LOGGING_PERIOD_MSEC
            self.add_cmd([self.get_datalog,[None]])
    
    def get_datalog(self,args):
        cmd_handler=CMDHandler.get_instance()
        success,data=cmd_handler.send_cmd(Dataport.CMD_GET_DATA,0,54,0)
        self.datalog_cmd_total+=1

        if success:
            self.datalog_cmd_good+=1
            str_data=""
            for i in range(27):
                str_data+=str(int(data[2*i]*256 + data[2*i+1])) + ","
            str_data+="\n"
            self.fh_a.write(str_data)
    
    def get_time(self,args):
        cmd_handler=CMDHandler.get_instance()
        success,data=cmd_handler.send_cmd(Dataport.CMD_GET_TIME,0,4,0)
        if success:
            cmd_handler.console.print(f'[bold green]{data[0]}:{data[1]}:{data[2]}')
    
    def get_date(self,args):
        cmd_handler=CMDHandler.get_instance()
        success,data=cmd_handler.send_cmd(Dataport.CMD_GET_DATE,0,4,0)
        if success:
            cmd_handler.console.print(f'[bold green]{data[0]}:{data[1]}:{data[2]}')
    
    def get_settings(self,args):
        cmd_handler=CMDHandler.get_instance()
        success,data=cmd_handler.send_cmd(Dataport.CMD_GET_SETTINGS,0,44,0)
        strStandModes = ["Manual Lean","Auto Lean"]
        strSitModes = ["Min Lean","Normal Lean"]
        strWalkModes = ["First Step","ActiveStep","ProStep","ProStep+"]
        strTargetSounds = ["Off","Forward","Lateral","Both"]
        strLeanAllowance = ["Min","Max","Off"]
        strInjuryMode = ["Bilateral","Right Affected","Left Affected","2Free"]
        strSwingAssist = ["Adapt","Max","High Resist","Low Resist","Neutral","Low Assist","High Assist"]
        strStanceSupport = ["Low","Medium","High","Very High","Flex","Full"]
        strSwingComplete = ["2.5","2.0","1.5","1.0","0.5","0.3","0.1"]

        if success:
            for i in range(22):
                r = unpack('>H',data[2*i:2*(i+1)])
                fVal = float(r[0])

                if i == 0:
                    cmd_handler.console.print("Upper Leg Length: "+str(fVal/100))
                elif i == 1:
                    cmd_handler.console.print ("Lower Leg Length: "+str(fVal/100))
                elif i == 2:
                    cmd_handler.console.print ("Step Length: "+str(fVal/100))
                elif i == 3:
                    cmd_handler.console.print ("Step Height: "+str(fVal/100))
                elif i == 4:
                    cmd_handler.console.print ("Swing Time: "+str(fVal/100))
                elif i == 5:
                    cmd_handler.console.print ("Stand Time: "+str(fVal/100))
                elif i == 6:
                    cmd_handler.console.print ("Knee Flex: "+str(fVal/100))
                elif i == 7:
                    cmd_handler.console.print ("Hip Flex: "+str(fVal/100))
                elif i == 8:
                    iVal = int(fVal)
                    if iVal > 32767:
                        iVal = iVal - 65535
                    cmd_handler.console.print ("Forward Shift: "+str(int(round(iVal/100,0))))
                elif i == 9:
                    iVal = int(fVal)
                    if iVal > 32767:
                        iVal = iVal - 65535
                    cmd_handler.console.print ("Lateral Shift: "+str(int(round(iVal/100,0))))
                elif i == 10:
                    cmd_handler.console.print ("Walk Mode: "+strWalkModes[int(fVal)])
                elif i == 11:
                    cmd_handler.console.print ("Stand Mode: "+strStandModes[int(fVal)])
                elif i == 12:
                    cmd_handler.console.print ("Target Sounds: "+strTargetSounds[int(fVal)])
                elif i == 13:
                    cmd_handler.console.print ("Injury Mode: "+strInjuryMode[int(fVal)])
                elif i == 14:
                    strOut = "Left Swing Assist: "
                    val = int(fVal)
                    if val <= 20:
                        strOut = strOut + str(val*5)
                    else:
                        strOut = strOut + strSwingAssist[val-21]
                    cmd_handler.console.print (strOut)
                elif i == 15:
                    strOut = "Right Swing Assist: "
                    val = int(fVal)
                    if val <= 20:
                        strOut = strOut + str(val*5)
                    else:
                        strOut = strOut + strSwingAssist[val-21]
                    cmd_handler.console.print (strOut)
                elif i == 16:
                    cmd_handler.console.print ("Left Stance Support: "+strStanceSupport[int(fVal)])
                elif i == 17:
                    cmd_handler.console.print ("Right Stance Support: "+strStanceSupport[int(fVal)])
                elif i == 18:
                    cmd_handler.console.print ("Swing Complete: "+strSwingComplete[int(fVal)])
                elif i == 19:
                    cmd_handler.console.print ("PilotID: "+str(int(fVal)))
                elif i == 20:
                    cmd_handler.console.print ("Sit Mode: "+strSitModes[int(fVal)])
                elif i == 21:
                    cmd_handler.console.print ("Lean Allowance: "+strLeanAllowance[int(fVal)]) 

    def get_feedback(self):
        cmd_handler=CMDHandler.get_instance()
        success,data=cmd_handler.send_cmd(Dataport.CMD_GET_FEEDBACK,0,34,0)    

        if success:
            for i in range(15):
                r = unpack('>H',data[2*i:2*(i+1)])
                fVal = float(r[0])
                if fVal > 32767:
                    fVal -= 65536
                if i == 0:
                    cmd_handler.console.print ("Steps: " + str(int(fVal)))
                elif i == 1:
                    cmd_handler.console.print ("Upright Time(sec): " + str(int(fVal)))
                elif i == 2:
                    cmd_handler.console.print ("Walk Time(sec): " + str(int(fVal)))
                elif i == 3:
                    cmd_handler.console.print ("MinGain, Left: " + str(fVal/10))
                elif i == 4:
                    cmd_handler.console.print ("FwdGain, Left: " + str(fVal/10))
                elif i == 5:
                    cmd_handler.console.print ("MinGain, Right: " + str(fVal/10))
                elif i == 6:
                    cmd_handler.console.print ("FwdGain, Right: " + str(fVal/10))
                elif i == 7:
                    cmd_handler.console.print ("Hip Stance Support, Left: " + str(fVal/10))
                elif i == 8:
                    cmd_handler.console.print ("Knee Stance Support, Left: " + str(fVal/10))
                elif i == 9:
                    cmd_handler.console.print ("Hip Stance Support, Right: " + str(fVal/10))
                elif i == 10:
                    cmd_handler.console.print ("Knee Stance Support, Right: " + str(fVal/10))
                elif i == 11:
                    cmd_handler.console.print ("Step Length, Left: " + str(fVal/10))
                elif i == 12:
                    cmd_handler.console.print ("Step Length, Right: " + str(fVal/10))
                elif i == 13:
                    cmd_handler.console.print ("Swing Time, Left: " + str(fVal/10))
                elif i == 14:
                    cmd_handler.console.print ("Swing Time, Right: " + str(fVal/10))

        # rebuild time value
        tmHi = unpack('>H',data[30:32])
        tmLo = unpack('>H',data[32:34])
        Tsec = (float(tmHi[0])*65536.0 + float(tmLo[0])) / 1000
        cmd_handler.console.print("T="+str(Tsec)+" sec")
    
    def set_value(self,args):
        data_output=bytearray(4)

        vid=args[0]
        fval=args[1]

        if vid<=209:
            val=int(100.0 * fval)
        else:
            val=int(fval)

        data_output[0]=0
        data_output[1]=vid
        data_output[2]=int(val/256)
        data_output[3]=val%256

        cmd_handler=CMDHandler.get_instance()
        success,data_in=cmd_handler.send_cmd(Dataport.CMD_SET_VALUE,4,2,data_output)
        if success:
            if data_in[1] == 1:
                cmd_handler.console.log(f"[bold red]Error in CMD_set_value: Ekso State={data_in[0]}")
            elif data_in[1] == 2:
                cmd_handler.console.log(f"[bold red]Error in CMD_set_value: Out of Range: ID={data_output[1]}, val={fval}")
            elif data_in[1] == 3:
                cmd_handler.console.log(f"[bold red]Error in CMD_set_value: value not allowed={fval}")
            elif data_in[1] != 0:
                cmd_handler.console.log(f"Error, data_in[1]={data_in[1]}")
        else:
            cmd_handler.console.log(f"[bold red]Error in CMD_set_value: ID={data_output[1]}, val={val}")

    def cancel_action(self,args):
        data_output = bytearray(2)
        data_output[0] = 1
        data_output[1] = 0

        cmd_handler=CMDHandler.get_instance()
        success,data_in=cmd_handler.send_cmd(Dataport.CMD_CANCEL_ACTION,2,2,data_output)
        if success:
            if data_in[1]==1:
                cmd_handler.console.log(f"[bold red]Error in CMD_cancel_action: Ekso State={data_in[0]}")
            elif data_in[1]==3:
                cmd_handler.console.log(f"[bold red]Error in CMD_cancel_action: Cmd not allowed")
        else:
            cmd_handler.console.log(f'[bold red]Error in CMD_cancel_action: ID={data_output[1]}')
    
    def datalogger(self,args):
        cmd=args[0]
        if cmd=='start':
            CMDHandler.bdata_logging=True
        elif cmd=='stop':
            CMDHandler.bdata_logging=True
        elif cmd=='open':
            filename=args[1]
            self.fh_a=open(filename,"a")
        elif cmd=='close':
            self.fh_a.close()