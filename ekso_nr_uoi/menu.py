import time
from dataport import Dataport
from serial_port import CMDHandler

class Menu:
    MNU_MAIN = 0
    MNU_COM_SETUP = 1
    MNU_SEND_CMD = 2
    MNU_READ_DATA = 3

    def __init__(self):
        self.menu_id=Menu.MNU_MAIN
        self.cmd_handler=CMDHandler.get_instance()
        self.dataport_connector=Dataport.get_instance()
    
    def run(self,conn,menu_action,brefresh_display):
        if menu_action!='-':
            if self.menu_id==Menu.MNU_MAIN:
                if menu_action=='0':
                    CMDHandler.bexxit=True
                    return
                elif menu_action=='1':
                    self.menu_id=Menu.MNU_COM_SETUP
                elif menu_action=='2':
                    self.menu_id=Menu.MNU_SEND_CMD
                elif menu_action=='3':
                    self.menu_id=Menu.MNU_READ_DATA
        
            elif self.menu_id==Menu.MNU_COM_SETUP:
                if menu_action=='0':
                    self.menu_id=Menu.MNU_MAIN
            
            elif self.menu_id==Menu.MNU_SEND_CMD:
                if menu_action=='0':
                    self.menu_id==Menu.MNU_MAIN
                elif menu_action=='1':
                    conn.send([self.dataport_connector.add_cmd,[self.dataport_connector.get_time,[None]]])
                    time.sleep(0.25)
                elif menu_action=='2':
                    conn.send([self.dataport_connector.add_cmd,[self.dataport_connector.get_date,[None]]])
                    time.sleep(0.25)
                elif menu_action=='3':
                    conn.send([self.dataport_connector.add_cmd,[self.dataport_connector.get_settings,[None]]])
                    time.sleep(0.25)
                elif menu_action=='4':
                    conn.send([self.dataport_connector.add_cmd,[self.dataport_connector.get_feedback,[None]]])
                    time.sleep(0.25)
                elif menu_action=='5':
                    parameter_id=input("Enter id(200-219):")
                    if not parameter_id.isdigit():
                        raise ValueError(f"Parameter id you provide is not digit:{parameter_id}")

                    fval=float(input(f"Enter new value for parameter id {parameter_id}:"))
                    conn.send([self.dataport_connector.add_cmd,[self.dataport_connector.set_value,[parameter_id,fval]]])
                    time.sleep(0.25)
                elif menu_action=='6':
                    conn.send([self.dataport_connector.add_cmd,[self.dataport_connector.cancel_action,[None]]])
                    time.sleep(0.25)
            
            elif self.menu_id==Menu.MNU_READ_DATA:
                if menu_action=='0':
                    self.menu_id=Menu.MNU_MAIN
                elif menu_action=='1':
                    conn.send([self.dataport_connector.add_cmd,[self.dataport_connector.datalogger,['start']]])
                    self.cmd_handler.console.log("[bold green]Datalogging Mode: ON")
                elif menu_action=='2':
                    conn.send([self.dataport_connector.add,[self.dataport_connector.datalogger,['stop']]])
                    self.cmd_handler.console.log("[bold green]Datalogging Mode: OFF")
            
            if brefresh_display:
                if self.menu_id==Menu.MNU_MAIN:
                    self.cmd_handler.console.rule("[bold green]\nMain Menu")
                    self.cmd_handler.console.print('1> COM SETUP')
                    self.cmd_handler.console.print('2> Send Commands')
                    self.cmd_handler.console.print('3> Read Data')
                    self.cmd_handler.console.print('0> Exit')
                elif self.menu_id==Menu.MNU_COM_SETUP:
                    self.cmd_handler.console.rule("COM Setup")
                    self.cmd_handler.console.print('1> Display COM ports')
                    self.cmd_handler.console.print('0> Back')
                elif self.menu_id==Menu.MNU_SEND_CMD:
                    self.cmd_handler.console.rule("[bold green]Send Commands")
                    self.cmd_handler.console.print("1> Get Time")
                    self.cmd_handler.console.print("2> Get Date")
                    self.cmd_handler.console.print("3> Get Settings")
                    self.cmd_handler.console.print("4> Get Feedback")
                    self.cmd_handler.console.print("5> Set Value")
                    self.cmd_handler.console.print("6> Cancel Action")
                    self.cmd_handler.console.print("7> CRC Test")
                    self.cmd_handler.console.print("0> Back")
                elif self.menu_id==Menu.MNU_READ_DATA:
                    self.cmd_handler.console.rule("Read Data")
                    self.cmd_handler.console.print("1> Start Data Stream")
                    self.cmd_handler.console.print("2> Stop Data Stream")
                    self.cmd_handler.console.print("0> Back")