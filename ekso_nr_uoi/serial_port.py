import time,serial,binascii
from struct import *
import crcmod.predefined
from datetime import datetime,timedelta
from rich.console import Console
import serial.tools.list_ports

class CMDHandler:
    singleton_instance=None
    bdata_logging=False
    bexxit=False

    @staticmethod
    def get_instance():
        if CMDHandler.singleton_instance==None:
            CMDHandler.singleton_instance=CMDHandler()
        
        return CMDHandler.singleton_instance

    def __init__(self):
        self.msg_id=200
        self.serial_connector=serial.Serial()
        self.total_rx_bytes=0
        self.total_tx_bytes=0
        self.console=Console(record=True)
        self.check="XXVV"
    
    def cmd_serial_port(self,data):
        cmd=data[0]
        argument=data[1]

        if cmd=='select':
            port_list=serial.tools.list_ports.comports()
            i=1
            com_name=list()
            for p in port_list:
                com_name.append(p.device)
                self.console.print(f'[bold green]{i}>{p.device}')
                i+=1
            self.console.print(f'[bold red] 0 > Exit',end='\n\n')
            self.console.print(f'Select a COM port[0-{i-1}]:')
            port_number=input('>>')
            port_index=None
            if port_number.isdigit():
                port_index=int(port_number)
            
            if port_index==None:
                raise ValueError("Port Index is NAN")
            
            port_index-=1
            return com_name[port_index]
        elif cmd=='open':
            self.serial_connector=argument
            self.serial_connector.baudrate=115200
            self.serial_connector.parity=serial.PARITY_NONE
            self.serial_connector.stopbits=serial.STOPBITS_ONE
            self.serial_connector.bytesize=serial.EIGHTBITS
            self.serial_connector.write_timeout=0
            self.serial_connector.timeout=0
            self.serial_connector.rtscts=False
            self.serial_connector.xonxoff=False
            self.serial_connector.open()
            self.serial_connector.reset_input_buffer()
            self.serial_connector.reset_output_buffer()
            return ''
    
    def get_crc(self,data):
        crc16=crcmod.predefined.mkCrcFun('crc-ccitt-false')
        return crc16(data)

    
    def millis(self,start_time):
       duration = datetime.now() - start_time
       return int(duration.total_seconds()*1000)

    def send_cmd(self,cmd,num_tx_bytes,num_rx_bytes,data):
        start_time=datetime.now()
        SIZE_HDR=4
        SIZE_CRC=2

        text_buffer=bytearray(SIZE_HDR+num_tx_bytes)
        text_buffer[0]=cmd
        text_buffer[1]=num_tx_bytes
        text_buffer=(self.msg_id>>8) & 255
        text_buffer=self.msg_id & 255

        for i in range(num_tx_bytes):
            text_buffer[i+SIZE_HDR]=data[i]
        
        calc_crc=self.get_crc(text_buffer)
        text_buffer.append(calc_crc>>8)
        text_buffer.append(calc_crc & 255)

        try:
            self.serial_connector.write(text_buffer)
        except:
            self.console.log("[bold red]Timeout error in serial connector write method")
            self.console.log(f"[bold blue]TxBytes={self.total_tx_bytes}, RxBytes={self.total_rx_bytes}")

        self.msg_id+=1
        rx_size=SIZE_HDR+num_tx_bytes+SIZE_CRC
        start_timer=time.time()
        while True:
            try:
                bytes_available=self.serial_connector.in_waiting
                if bytes_available>=rx_size:
                    break
            except:
                self.console.log("Error in self.serial_connector.in_waiting property")
                self.console.log(f"[bold blue]TxBytes={self.total_tx_bytes}, RxBytes={self.total_rx_bytes}")
                return False,0

            if self.millis(start_time)>500:
                last_msg_id=self.msg_id-1
                self.console.print(f'[bold green]*** MsgID=0x{last_msg_id:04x}, Cmd={str(cmd)}, timeout(Tx/Rx)={self.total_tx_bytes} / {self.total_rx_bytes}, Avail:"{bytes_available}, Exp:{rx_size}')
                self.serial_connector.reset_input_buffer()
                self.serial_connector.reset_output_buffer()
        

        try:
            rx_buffer=self.serial_connector.read(rx_size)
        except:
            self.console.log(f'[bold red]Read Error, rx_size={rx_size}')
            self.console.log(f'TxBytes={self.total_tx_bytes}, RxBytes={self.total_rx_bytes}')
            return False,0
        
        self.total_rx_bytes+=rx_size

        # Check crc
        calc_crc=self.get_crc(rx_buffer[0:rx_size-SIZE_CRC])
        r=unpack('>H',rx_buffer[rx_size-SIZE_CRC:rx_size])
        read_crc=r[0]

        correction_status=calc_crc==read_crc
        if not correction_status:
            self.log(f"[bold red] CRC error on response: read=f{hex(read_crc)}, calc={hex(calc_crc)}")
            for i in range(rx_size):
                self.console.print(f'Buffer_idx:{i}, value:0x{rx_buffer[i]:02x}')

            self.serial_connector.reset_input_buffer()
            self.serial_connector.reset_output_buffer()
        
        return correction_status,rx_buffer[SIZE_HDR:SIZE_HDR+num_rx_bytes]