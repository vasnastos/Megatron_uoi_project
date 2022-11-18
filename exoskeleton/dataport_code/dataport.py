import time
import config
import queue
from struct import *

from multiprocessing.connection import Client
from serial_port import CMD_SerialPort, send_cmd

# commands
CMD_GET_TIME = 150
CMD_GET_DATE = 151
CMD_GET_SETTINGS = 152
CMD_GET_DATA = 153
CMD_GET_FEEDBACK = 154
CMD_SET_VALUE = 155
CMD_CANCEL_ACTION = 156

q = queue.Queue()
fh_a = 0

DATA_LOGGING_PERIOD_MSEC = 20 

datalog_cmd_good = 0
datalog_cmd_total = 1

nextDataLogTime = 0

def add_cmd(f):
    q.put(f)

def run_serial_cmd():
    if not q.empty():
        f = q.get()
        func = f[0]
        args = f[1]
        func(args)
        q.task_done()

def run_datalog():
    global nextDataLogTime
    
    timeNow = time.time_ns() / 1000000

    # is it time for the next data request
    if config.bDataLogging and timeNow >= nextDataLogTime:
        nextDataLogTime = timeNow + DATA_LOGGING_PERIOD_MSEC
        add_cmd([CMD_get_datalog,[None]])
            
def CMD_get_datalog(args):
    global fh_a
    global datalog_cmd_good
    global datalog_cmd_total
    
    success, data = send_cmd(CMD_GET_DATA,0,54,0)
    datalog_cmd_total += 1

    if success:
        datalog_cmd_good += 1
        # create CSV string from data values
        strData = ""
        for i in range(27):
            strData += str(int(data[2*i]*256 + data[2*i+1])) + ","

        strData += "\n"
        fh_a.write(strData)
                   
def CMD_get_time(args):
    success, data = send_cmd(CMD_GET_TIME,0,4,0)

    if success:
        print ((str(data[0])+":"+str(data[1])+":"+str(data[2])))
  
def CMD_get_date(args):
    success, data = send_cmd(CMD_GET_DATE,0,4,0)

    if success:
        print ((str(data[1])+"/"+str(data[2])+"/"+str(data[0])))

def CMD_get_settings(args):
    success, data = send_cmd(CMD_GET_SETTINGS,0,44,0)
    
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
                print ("Upper Leg Length: "+str(fVal/100))
            elif i == 1:
                print ("Lower Leg Length: "+str(fVal/100))
            elif i == 2:
                print ("Step Length: "+str(fVal/100))
            elif i == 3:
                print ("Step Height: "+str(fVal/100))
            elif i == 4:
                print ("Swing Time: "+str(fVal/100))
            elif i == 5:
                print ("Stand Time: "+str(fVal/100))
            elif i == 6:
                print ("Knee Flex: "+str(fVal/100))
            elif i == 7:
                print ("Hip Flex: "+str(fVal/100))
            elif i == 8:
                iVal = int(fVal)
                if iVal > 32767:
                    iVal = iVal - 65535
                print ("Forward Shift: "+str(int(round(iVal/100,0))))
            elif i == 9:
                iVal = int(fVal)
                if iVal > 32767:
                    iVal = iVal - 65535
                print ("Lateral Shift: "+str(int(round(iVal/100,0))))
            elif i == 10:
                print ("Walk Mode: "+strWalkModes[int(fVal)])
            elif i == 11:
                print ("Stand Mode: "+strStandModes[int(fVal)])
            elif i == 12:
                print ("Target Sounds: "+strTargetSounds[int(fVal)])
            elif i == 13:
                print ("Injury Mode: "+strInjuryMode[int(fVal)])
            elif i == 14:
                strOut = "Left Swing Assist: "
                val = int(fVal)
                if val <= 20:
                    strOut = strOut + str(val*5)
                else:
                    strOut = strOut + strSwingAssist[val-21]
                print (strOut)
            elif i == 15:
                strOut = "Right Swing Assist: "
                val = int(fVal)
                if val <= 20:
                    strOut = strOut + str(val*5)
                else:
                    strOut = strOut + strSwingAssist[val-21]
                print (strOut)
            elif i == 16:
                print ("Left Stance Support: "+strStanceSupport[int(fVal)])
            elif i == 17:
                print ("Right Stance Support: "+strStanceSupport[int(fVal)])
            elif i == 18:
                print ("Swing Complete: "+strSwingComplete[int(fVal)])
            elif i == 19:
                print ("PilotID: "+str(int(fVal)))
            elif i == 20:
                print ("Sit Mode: "+strSitModes[int(fVal)])
            elif i == 21:
                print ("Lean Allowance: "+strLeanAllowance[int(fVal)])
        
def CMD_get_feedback(args):
    success, data = send_cmd(CMD_GET_FEEDBACK,0,34,0)
    
    if success:
        for i in range(15):
            r = unpack('>H',data[2*i:2*(i+1)])
            fVal = float(r[0])
            if fVal > 32767:
                fVal -= 65536
            if i == 0:
                print("Steps: " + str(int(fVal)))
            elif i == 1:
                print("Upright Time(sec): " + str(int(fVal)))
            elif i == 2:
                print("Walk Time(sec): " + str(int(fVal)))
            elif i == 3:
                print("MinGain, Left: " + str(fVal/10))
            elif i == 4:
                print("FwdGain, Left: " + str(fVal/10))
            elif i == 5:
                print("MinGain, Right: " + str(fVal/10))
            elif i == 6:
                print("FwdGain, Right: " + str(fVal/10))
            elif i == 7:
                print("Hip Stance Support, Left: " + str(fVal/10))
            elif i == 8:
                print("Knee Stance Support, Left: " + str(fVal/10))
            elif i == 9:
                print("Hip Stance Support, Right: " + str(fVal/10))
            elif i == 10:
                print("Knee Stance Support, Right: " + str(fVal/10))
            elif i == 11:
                print("Step Length, Left: " + str(fVal/10))
            elif i == 12:
                print("Step Length, Right: " + str(fVal/10))
            elif i == 13:
                print("Swing Time, Left: " + str(fVal/10))
            elif i == 14:
                print("Swing Time, Right: " + str(fVal/10))

        # rebuild time value
        tmHi = unpack('>H',data[30:32])
        tmLo = unpack('>H',data[32:34])
        Tsec = (float(tmHi[0])*65536.0 + float(tmLo[0])) / 1000
        print ("T="+str(Tsec)+" sec")

def CMD_set_value(args):
    data_out = bytearray(4)

    ID = args[0]
    fVal = args[1]
     
    if (ID <= 209):
        val = int(100.0 * fVal)
    else:
        val = int(fVal)
        
    data_out[0] = 0
    data_out[1] = ID
    data_out[2] = int(val / 256)
    data_out[3] = val % 256
    
    success, data_in = send_cmd(CMD_SET_VALUE,4,2,data_out)
    if success:
        if data_in[1] == 1:
            print("Error in CMD_set_value: Ekso State=" + str(data_in[0]))
        elif data_in[1] == 2:
            print("Error in CMD_set_value: Out of Range: ID=" + str(data_out[1]) + ", val=" + str(fVal))
        elif data_in[1] == 3:
            print("Error in CMD_set_value: value not allowed="  + str(fVal))
        elif data_in[1] != 0:
            print("Error, data_in[1]="+str(data_in[1]))
    else:
        print ("Error in CMD_set_value: ID=" + str(data_out[1]) + ", val=" + str(val))

def CMD_cancel_action(args):
    data_out = bytearray(2)
    data_out[0] = 1
    data_out[1] = 0
    
    success, data_in = send_cmd(CMD_CANCEL_ACTION,2,2,data_out)
    if success:
        if data_in[1] == 1:
            print("Error in CMD_cancel_action: Ekso State=" + str(data_in[0]))
        elif data_in[1] == 3:
            print("Error in CMD_cancel_action: Cmd not allowed")
    else:
        print ("Error in CMD_cancel_action: ID=" + str(data_out[1]))

def CMD_DataLogger(args):
    global fh_a
 
    cmd = args[0]
    if cmd == 'start':
        config.bDataLogging = True
    elif cmd == 'stop':
        config.bDataLogging = False
    elif cmd == 'open':
        fName = args[1]
        fh_a = open(fName, "a")
    elif cmd == 'close':
        fh_a.close()
