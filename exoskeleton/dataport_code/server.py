from multiprocessing.connection import Listener
from serial_port import CMD_SerialPort
from dataport import run_serial_cmd,run_datalog

listener = Listener(('localhost', 6000), authkey=b'secret password')

running = True
while running:
    conn = listener.accept()
    print('connection accepted from', listener.last_accepted)

    while True:
        # check for an incoming message
        if conn.poll():
            msg = conn.recv()
            print(msg)
            if msg == 'close':
                conn.close()
                break
            if msg == 'close_server':
                conn.close()
                running = False
                break
                
            # run the function
            func = msg[0]
            args = msg[1]
            func(args)

        run_serial_cmd()
        run_datalog()

listener.close()
