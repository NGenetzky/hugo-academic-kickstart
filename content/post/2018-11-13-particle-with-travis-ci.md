+++
title = "Particle With Travis CI"
date = 2018-11-13T22:33:31-06:00
draft = false
tags = [
  "ci",
  "cpp",
  "particle",
]
categories = [
  "hobby-electronics",
]
+++

## Goal

I just created a number of github repositories for particle. Much of the code
was transferred from my existing code base at [particle-projects](https://github.com/NGenetzky/particle-projects). The
primary goal of these projects was not to demonstrate my capability as a C++
programmer, but actually to demonstrate a good example for an open source
particle project or library.

As such I have a few goals:

1. Offline builds (Thanks to [po](https://github.com/nrobinson2000/po))
2. Continuous Intgration (Thanks to [travis-ci](https://travis-ci.org/))
3. Modern C++

## Approach

I created
[particle-project-base](https://github.com/NGenetzky/particle-project-base) to
serve as a solid foundation for my future projects and libraries. This
repository should only contain the structure and the infrastructure of a good
project but not real code.

I then forked this project to create a project and a library repository.

- [particle-project-serial-pub-sub](https://github.com/NGenetzky/particle-project-serial-pub-sub)
- [particle-library-iot-tinker](https://github.com/NGenetzky/particle-library-iot-tinker)

The reason I forked the project is because it allows improvements to easily be
shared between the projects with the history maintained. On the other hand,
because they are separate projects:

1. They can be more easily digested by new users.
2. They can be independently verified.
3. Any use of code from other libraries must be explicit.
