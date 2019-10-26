+++
title = "The Tea Kettle Temperature Control Project"
date = 2015-03-23
draft = false

authors = [
  "Jerome Charles",
  "Nathan Genetzky",
]

publication_types = ["4"]

publication = "South Dakota State University"
publication_short = "SDSU"

abstract = "The aim of this project was to use an MCP7900 thermistor and a PIC18F8722 microcontroller to control the temperature of a tea-kettle using a “bang-bang” approach. What this means is that if the kettle went over a desired temperature the system will turn it off, and if the kettle temperature goes under the desired temperature, the system turns it back on until it raises to the desired temperature. This project was coded using both the PIC assembly and C programming languages. The C program was more intricate and required more lines of code. This was because the user in C could enter the temperature in degrees Celsius; whereas in the Assembly program, the user was restricted to three temperature settings that would be detected  by using the keypad."
abstract_short = "The aim of this project was to use an MCP7900 thermistor and a PIC18F8722 microcontroller to control the temperature of a tea-kettle."

featured = true

tags = [
    "asm",
    "ee",
    "c",
    "microchip",
    "pic",
    "pic18",
    "sdsu",
]
categories = [
  "sdsu"
]
projects = ["2015-sdsu-ee347"]

url_code = "https://github.com/NGenetzky/sdsu/tree/8607497e510e2b01480774f47e3ef9807d56d2e0/ee347/project1"
links = [
    {name = "docx", url = "https://drive.google.com/file/d/0B0Fa-Ogpus4wWXdQLVNPT0ZnU3c/view" },
    {name = "gdocpub", url="https://docs.google.com/document/d/e/2PACX-1vQoTJ17RhcwY3SQfgfPhAYf4nm_pR3ndCIdSTXgJBa9wVMKKe5h3iyIcH9bKwpxoWLLfkb3wgvXQZdi/pub"},
]
+++

- [2015_03_12-Project1-code-C.c](https://github.com/NGenetzky/sdsu/blob/8607497e510e2b01480774f47e3ef9807d56d2e0/ee347/project1/2015_03_12-Project1-code-C.c)
- [2015_03_18-Project1-code-C-ASM.asm](https://github.com/NGenetzky/sdsu/blob/8607497e510e2b01480774f47e3ef9807d56d2e0/ee347/project1/2015_03_18-Project1-code-C-ASM.asm)

{{< figure src="EE347-tea-kettle-teamperature-control-flow-diagram.png"
  title="Flow Diagram" >}}

{{< figure src="2015-02-27-ee347-project-1-front.jpg"
  title="EE347 Project 1 (front)" >}}
{{< figure src="2015-02-27-ee347-project-1-side.jpg"
  title="EE347 Project 1 (side)" >}}
