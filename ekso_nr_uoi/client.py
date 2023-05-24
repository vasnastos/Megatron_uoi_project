import time,os,datetime,subprocess
from multiprocessing.connection import Client
from serial_port import CMDHandler
from menu import Menu
import KBHit


class EksoClient:
    def __init__(self) -> None:
        self.server_subprocess=subprocess.Popen(['python','server.py'])
        self.conn=Client(('localhost',6000),authkey=b'secret password')
        self.menu=Menu()

        # set port hardcoded
        self.port_name='COM14'
        #self.port_name = '/dev/ttyACM0'
    
    def get_filelog(self):
        filepath=os.path.join('','subjects')
        if not os.path.exists(filepath):
            os.mkdir(filepath)

        filedb=os.path.join('','subjects','eksoNRlog.csv')
        if not os.path.exists(filedb):
            with open(filedb,'w') as writer:
                writer.write('Filename,Datetime\n')
        
        subjects=os.listdir(filepath)
        subject_idxs=[int(filename.removesuffix('.csv').split('_')[len(filename.removesuffix('.csv').split('_'))-1]) for filename in subjects if filename!='eksoNRlog.csv']
        headers=["Pitch","Roll","Rtoe","Rheel","Ltoe","Lheel","RHipX","RhipY","LHipX","LHipY","RHCur","RHAng","RKCur","RKAng","LHCur","LHAng","LKCur","LKAng","State","FootState","MinState","KeyState","WeightShift","HMI","RefTime","Thigh","Tlow","EMPTY"]

        subject_id=1 if len(subject_idxs)==0 else max(subject_idxs)+1
        new_subject_filename=os.path.join(filepath,f'eksoNR_subject_{subject_id}.csv')

        with open(filedb,'a') as writer:
            writer.write(f"{new_subject_filename},{datetime.datetime.now().strftime('%Y_%m_%d_%H_%M_%S')}\n")

        with open(new_subject_filename,'w') as writer:
            writer.write(f"{','.join(headers)}\n")

        return new_subject_filename


    def run_single_experiment(self):

        self.conn.send([self.menu.cmd_handler.cmd_serial_port,['open',self.port_name]])
        self.conn.send([self.menu.dataport_connector.datalogger,['open',self.get_filelog()]])
        time.sleep(1)

        self.conn.send([self.menu.dataport_connector.add_cmd,[self.menu.dataport_connector.get_time,[None]]])
        self.conn.send([self.menu.dataport_connector.add_cmd,[self.menu.dataport_connector.get_date,[None]]])

        self.conn.send([self.menu.dataport_connector.add_cmd,[self.menu.dataport_connector.datalogger,['start']]])
        time.sleep(2)
        self.conn.send([self.menu.dataport_connector.add_cmd,[self.menu.dataport_connector.datalogger,['stop']]])

        self.conn.send([self.menu.dataport_connector.datalogger,[self.menu.dataport_connector.set_value,[200,13]]])
        self.conn.send([self.menu.dataport_connector.datalogger,[self.menu.dataport_connector.set_value,[202,15.5]]])

        self.conn.send([self.menu.dataport_connector.datalogger,['close',None]])
        self.conn.send([self.menu.cmd_handler.cmd_serial_port,['close',None]])

        self.conn.send('close_server')
        self.conn.close()
    
    def loop(self):
        self.port_name=self.menu.cmd_handler.cmd_serial_port(['select',''])
        self.conn.send([self.menu.cmd_handler.cmd_serial_port, ['open', self.port_name]])
        self.conn.send([self.menu.dataport_connector.datalogger, ['open', self.get_filelog()]])


        kb = KBHit.KBHit()

        # main loop - run until exit flag is set
        refresh = True
        while not CMDHandler.bexxit:
            c = '-'
            if kb.kbhit():
                refresh = True
                
                c = kb.getch()
                if ord(c) == 27: # ESC
                    break
                print(c)
                
            self.menu.run(self.conn, c, refresh)
            refresh = False
                
        # restore normal terminal settings
        kb.set_normal_term()

        # close the serial connection
        self.conn.send([self.menu.cmd_handler.cmd_serial_port, ['close',None]])
        self.conn.send([self.menu.dataport_connector.datalogger, ['close', None]])

        # kill the server
        self.conn.send('close_server')

        # close this connection
        self.conn.close()

        self.server_subprocess.terminate()
        exit()


if __name__=='__main__':
    client=EksoClient()
    client.loop()