+++
date = "2017-05-01"
title = "SDSU-EE465-Senior Design"
summary = "Communication Protocols for Embedded Systems"
tags = [
    "altera",
    "ee",
    "jtag",
    "sdsu",
    "systemverilog",
    "c++",
    "fpga",
    "tcl",
]
+++

# Project Management for HIPE

# Software Development for HIPE

1. TCL
    1. TCP Server for executing TCL commands and replying with response.
    2. UDP Server for executing TCL commands and replying with response.
1. C++
    1. TCP Client for using TCP server.
    2. UDP Client for using UDP server.
    3. TCL Packet for executing TCL commands via UDP or TCP Client.
    4. Jtag Library for using ::quartus::jtag TCL package.
    5. HipeC provides a C api interacting with JTAG device and its TDRs.
1. Firmware
    1. Define dynamic number of JTAG TDRs.
    2. Allow access to TDRs based on JTAG Tap controller
    3. Interfaces with Altera’s virtual_jtag_sld_node to act as virtual JTAG devices.
    4. Allows user to read or control signals within their design.
1. SystemVerilog
    1. Provides Read/Shift access to TDRs.
    2. Allows firmware modules to be mocked in simulation
    3. Allows interaction with modules synthesized on physical FPGA.

