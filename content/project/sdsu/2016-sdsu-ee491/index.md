+++
date = "2016-01-01"
title = "SDSU-EE491-Independent Study"
summary = "Communication Protocols for Embedded Systems"
tags = [
    "ee",
    "android",
    "c++",
    "ifttt",
    "independent",
    "matlab",
    "particle",
    "sdsu",
    "tasker",
    "thingspeak",
]
+++

# Communication Protocols for Embedded Systems (1/2)

2016SP

1. Communication Protocols on Particle Microcontroller
    1. Serial on Particle Microcontroller
    2. I2C on Particle Microcontroller
    3. CAN on Particle Microcontroller
2. Applications on Particle Microcontroller
    1. Application utilizing GPIO expander [I2C]
    2. Application utilizing LCD character display [I2C]
3. Matlab on PC
    1. Matlab Client for Particle Cloud REST API
        1. Execute any Particle Function
        2. Read any Particle Variable
    2. Matlab Class for interacting with Serial Port
    3. Matlab Script for controlling Particle Microcontroller via my Particle Client
4. Tasker Projects on Android
    1. Tasker Tasks for using Particle Cloud REST API
    2. Tasker Scene for controlling Particle Microcontroller
5. Thingspeak channel
    1. Library code for Particle Microcontroller for publishing data to Thingspeak
    2. Webhooks for Particle Cloud for publishing data to Thingspeak
    3. Matlab script for importing and using data from Thingspeak
6. IFTTT Applets
    1. Receive email, text message, or notification from Particle Microcontroller
    2. Log data from Particle Microcontroller into Google Sheet
    3. Execute a command on Particle Microcontroller when a button is pressed on Phone
7. Smart Car Remote Library
    1. Use digital and analog signals from Freenove Board
    2. Publish values read from board to thingspeak channel
    3. Perform specific functions based on how long a button is pressed.
8. Other Libraries on Particle Microcontroller
    1. Control RGB on Particle
    2. Executing any number of commands (no parameters) from Particle API
    3. Executing any number of functions (1 string parameter) from Particle API

# Communication Protocols for Embedded Systems (2/2)

2017FA

1. Digital Port Library
    1. Combine up to 32 digital IO in any order
    2. Provide Read/Write access to each bit.
    3. Provide access to 32 bit integer representing value of port.
    4. Interfaces with Particle’s Tinker app to provide Read/Write access to some of the bits.
2. Register Bank Library
    1. Able to define custom getter and setter functions for each integer register.
    2. Provide Read/Write access getter/setter for each register.
3. File Library
    1. Stores characters which can be read from Particle Cloud.
    2. Able to append characters from Particle Cloud.
    3. Able to append characters from Serial communication.
    4. Able to read  function calls from a File and appends result of executing function to a File.
4. Tinker Library for Particle’s Tinker Android App
    1. Able to define custom functions for digitalread and digitalwrite from Tinker App
    2. Able to define custom functions for analogread and analogwrite from Tinker App
    3. Custom functions were defined for Register Bank and Digital Port.
5. Applications on Particle Microcontroller
    1. Execute functions from other device via Serial
        1. Performed digital reads, digital writes, analog reads.
        2. Performed reads and writes of registers in Register Bank.
        3. Performed reads and writes to bits in Digital Port
    2. Interact with FreeNove board
        1. Write LEDs and read Joystick, potentiometers, and switches.
        2. Publish data from analog and digital inputs to Thingspeak channel

# [Notebook](https://drive.google.com/drive/folders/0B8VD0Zdh0kV1MHo3SVFUbmI3Znc?usp=sharing) on GDrive

1. [2016-12-15-Digital Write or Read of up to 32 digital pins via cloud](https://docs.google.com/document/d/1MfsHqb2PtRfqkllonqriMbOFVn3qAxwobkmKheZnfAQ/edit?usp=sharing)
2. [2016-12-18-Created DigitalPort, Stream and Function](https://docs.google.com/document/d/1OnW6E9injsD21ZcGL0Htflg3XweqlrTiVBDNszY1QXU/edit?usp=sharing)
3. [2016-12-20-Using the Tinker Android App for my own purposes](https://docs.google.com/document/d/1FXeGcEZWNs8HTtK1urkot22k3xkJqtGJE9vZIqmOW_4/edit?usp=sharing)
4. [2016-12-23-Separate into Apps. Use functions through Serial.](https://docs.google.com/document/d/1B2gTJZRzd_kH33cNRD4VxqU5aBDGEqdjVeUZIHC0vg0/edit?usp=sharing)
5. [2016-12-24-Access multiple integers on microcontroller using RegisterBank](https://docs.google.com/document/d/1Q_SC3GUFbKhhee7alBq42jYUvod6EE4ROQnGZFAnCVY/edit?usp=sharing)
6. [2016-12-25-Tinker with Registers and DigitalPins](https://docs.google.com/document/d/1_xL1B_F6Z7VRJOKgXOHjGL8w7VZDxXLMbA7NvdtJ1dk/edit?usp=sharing)
7. [2017-01-28-Communicate_with_photon_via_WiFi_through_cloud](https://docs.google.com/document/d/1h21xta-Wy08qsY5a6NRLQuCtsizAjbgwOSXdVOTogBk/edit?usp=sharing)
8. [2017-03-28-Using functions via Serial communication](https://docs.google.com/document/d/13pAgph1S-gc1kM0-VsKtEvEKJByLkDyTGUL-VTns25E/edit?usp=sharing)

