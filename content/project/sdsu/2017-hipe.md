+++
date = "2017-05-01"
title = "Hardware Integrated Prototyping Environment"
summary = "HIPE provides an interface between the user’s simulation environment and a Field Programmable Gate Array (FPGA) containing a Design Under Test (DUT)."
authors = [
    "Nathan Genetzky",
    "Jordan Ulmer",
    "Tanner Johnson",
]
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

# Executive Summary

Rockwell Collins currently tests their digital hardware designs using software
simulation.  Simulations of complex digital hardware designs, such as
communication interfaces and video processing components, result in a
computational bottleneck at the CPU, and require an impractical amount of time
to test using the conventional method of software simulation. Hardware
Integrated Prototype Environment (HIPE) was developed as a method to test
digital hardware designs faster than it is possible than with software
simulation alone.

HIPE provides an interface between the user’s simulation environment and a
Field Programmable Gate Array (FPGA) containing a Design Under Test (DUT).
This interface eliminates the need to simulate the DUT using software and
thereby reduces the computational load on the CPU.

Within the simulation environment, a HIPE module written in SystemVerilog
replaces the user’s DUT, interfaces with the user’s testbench, and transmits
the testbench’s data to a TCP Client, written in C++.  HIPE’s TCP client
utilizes HIPE C++ libraries to convert the incoming data to Tool Command
Language (TCL) commands and then sends these commands to a TCP server, written
in TCL.  The TCP server utilizes a Quartus library to execute the incoming
commands and communicate with the user’s HIPE-integrated DUT on an Altera FPGA
via a USB-JTAG connection.  Data from the user’s DUT is transmitted back
through HIPE’s communication chain to the simulation environment.  The data is
then displayed in ModelSim’s Wave Viewer window.

HIPE has successfully met and exceeded all specifications.  HIPE was tested
using ModelSim 10.1d, a Hardware Description Language (HDL) simulation tool, on
Ubuntu 12.04 with several known working DUTs.  For a 190-bit operand Array
Multiplier DUT, a simulation utilizing HIPE performed 16 times faster than its
respective baseline simulation and demonstrated a consistent 280 transactions
per second (8 signals per transaction).  When integrated with a DUT, HIPE added
an average of less than one logic element per signal connected to HIPE.  HIPE’s
communication speed can be improved in the future by increasing the number of
signals per transaction, resolving communication delay issues, and replacing
the TCP Server/Client with an alternative communication method.

