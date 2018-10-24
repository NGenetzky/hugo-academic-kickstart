+++
title = "Hardware Integrated Prototyping Environment at SDSU Engineering Expo"
date = "2017-04-28"
authors = [
    "Nathan Genetzky",
    "Jordan Ulmer",
    "Tanner Johnson",
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
selected = true

# Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter the filename (excluding '.md') of your project file in `content/project/`.
projects = ["sdsu/2017-hipe"]

# Links (optional).
url_pdf = ""
url_preprint = ""
url_code = ""
url_dataset = ""
url_project = ""
url_slides = ""
url_video = "https://drive.google.com/file/d/0B0csOIPsLBNIQXE3SEpuVGtReUU/view?usp=sharing"
url_poster = "https://drive.google.com/file/d/0B0csOIPsLBNIZExIS0lIaXIyekU/view?usp=sharing"
url_source = ""

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.
url_custom = [
]

# Does the content use source code highlighting?
highlight = false

[image]
  caption = "HIPE Team at Engineering Expo"

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = "Smart"
+++

# Abstract

Digital hardware designers currently utilize software simulation tools to
prototype and verify their digital designs. Existing tools provide designers
with accurate signal information that allows them to identify and amend errors
in their designs. Simulations for digital hardware designs can take days to
complete; this costs companies, such as Rockwell Collins, over $100,000 per
engineer per year! Steadily changing markets demand increasingly complex
designs to meet customer needs and keep up with rapidly advancing technology.
Complex designs are developed using iterative prototyping and require a
significant amount of processing power to verify using software simulations.
Since these designs are modeled and processed by a CPU onboard a PC, the
computation time required to analyze millions of events becomes impractical.
Rapid design prototyping is an essential part of the digital hardware design
process. For this reason, the project will build on the pre-existing industry
standard workflow used by Rockwell Collins in order to allow digital designers
to interact with signals from complex digital designs in the same way that they
would in the current simulation environment.

The goal of this project is to decrease simulation time by integrating hardware
with the existing simulation environment while still providing access to
internal signals of a design under test. A Hardware Integrated Prototyping
Environment (HIPE) is being developed to overcome the existing simulation
software’s shortcomings. The HIPE design consists of an FPGA development board,
the existing simulation software on a PC, and a hardware-software interface
connecting the two.
