+++
title = "Design and Verification of a SPI to JTAG Interface Adapter"
date = "2017-05-05"
authors = [
    "Nathan Genetzky",
    "Jordan Ulmer",
]
tags = [
    "altera",
    "ee",
    "jtag",
    "sdsu",
    "systemverilog",
    "c",
    "c++",
    "fpga",
    "tcl",
]

# Publication type.
# Legend:
# 0 = Uncategorized
# 1 = Conference proceedings
# 2 = Journal
# 3 = Work in progress
# 4 = Technical report
# 5 = Book
# 6 = Book chapter
publication_types = ["4"]

# Publication name and optional abbreviated version.
publication = "SDSU"
publication_short = "SDSU"

# Abstract and optional shortened version.
abstract = ""
abstract_short = ""

# Is this a selected publication? (true/false)
featured = true

# Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter the filename (excluding '.md') of your project file in `content/project/`.
projects = ["sdsu/2017-sdsu-ee492"]

# Links (optional).
url_pdf = "https://drive.google.com/file/d/0B0csOIPsLBNIWVAzb3BiM2psT1E/view?usp=sharing"
url_preprint = ""
url_code = "https://bitbucket.org/adhd_digital_design/ee492"
url_dataset = ""
url_project = ""
url_slides = "https://docs.google.com/presentation/d/19PDRV6uT1dF1hlnHNLF7mZ6MUgy6CDMPpeRlLuvi9P0/present?usp=sharing"
url_video = ""
url_poster = ""
url_source = ""

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.
links = [
]

# Does the content use source code highlighting?
highlight = false
+++

# Goal and Motivation:

Almost all hardware devices have JTAG connections which can provide data from
registers or provide low level control of pins via a boundary scan chain.
Unfortunately, most microcontrollers do not have libraries  or drivers for
communicating using the JTAG protocol.  The goal of this project is to provide
a way to allow users to use existing libraries to access data that is typically
accessed via JTAG protocol.
