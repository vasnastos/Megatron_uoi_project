import time
from multiprocessing.connection import Client
from dataport import add_cmd
from dataport import CMD_DataLogger,CMD_get_time,CMD_get_date
from dataport import CMD_get_settings,CMD_get_feedback,CMD_set_value,CMD_cancel_action
from serial_port import CMD_SerialPort