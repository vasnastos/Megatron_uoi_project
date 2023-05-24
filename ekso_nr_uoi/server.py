from multiprocessing.connection import Listener
from serial_port import CMDHandler
from dataport import Dataport

def run_server():
    listener = Listener(('localhost', 6000), authkey=b'secret password')
    running=True
    while running:
        conn=listener.accept()
        print(f'Connection accepted from:{listener.last_accepted}')
        while True:
            if conn.poll():
                msg=conn.recv()
                print(f'Message Received:{msg}')
                if msg=='close':
                    conn.close()
                    break
                if msg=='close_server':
                    conn.close()
                    running=False
                    break
                
                func=msg[0]
                args=msg[1]
                func(args)
            
            dataport_connector=Dataport.get_instance()
            dataport_connector.run_serial_cmd()
            dataport_connector.run_datalog()
    listener.close()

if __name__=='__main__':
    run_server()