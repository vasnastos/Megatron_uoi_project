6/9/2021
Readme.txt file for DataPort python scripts

The python files in this directory form a simple python application to communicate with the DataPort module running on the Ekso.  

The python application has a client/server structure, where server.py should always be started first.

There are two examples for the client side of this python application 

1) client.py is a non-interactive script that opens a predefined COM port, runs a series of DataPort commands, and then shuts down the client and server python scripts 

2) console.py is an interactive script where the operator uses a text-based menu to select from a list of available COM ports and then choose what commands to send to the DataPort.

file list
-----------
client.py - non-interactive client-side script described above
config.py - global variables used by python application 
console.py - interactive client-side script described above 
dataport.py - contains functions for each DataPort command 
KBHit.py - handles keyboard input in a non-blocking way
menu.py - handles display and actions for text-based menu system
serial_port.py - manages serial communication interface to DataPort 
server.py - main program; handles connections from clients, executes DataPort commands 
