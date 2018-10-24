+++
title = "Valentine's Day for Jenkins"
date = 2018-02-14
draft = false
tags = [
    "ci",
    "docker",
    "jenkins",
]
categories = []
+++

## Using Docker - No plugins required

Last time I investigated using Docker inside the "master" container. It was
pretty cool, but it was inconvenient when directories needed to be mounted to
the containers. I intend to continue investigating the Docker plugins, but I
felt like Jenkins needed some company for Valentines Day.

## Jenkins JNLP Slaves as Docker Containers

The goal is to add a "Normal" Jenkins slave node that can connect to the master
in the typical fashion.  The Jenkins JNLP Agent Docker image published by
[jenkinsci/docker-jnlp-slave](https://github.com/jenkinsci/docker-jnlp-slave)
can act as a base image and provides a useful entrypoint. Any number of these
slaves can be added to the docker-compose.yaml and then be available to the master.
It appears that `/home/jenkins/agent` is intended to be used for the workdir.

## Configuration

Although the entrypoint above supports command line arguments I found that it
was much easier to configure the values using multiple 'env_file' entries. This
way I can share the common variables easily and keep the "secret" out of
version control. The entrypoint provided with docker-jnlp-slave was not
designed to handle the scenario where the master is being launched by the same
docker-compose file. The slave would attempt to connect before the master was
ready and then crash. I fixed this by using a simple wrapper to the entrypoint
that would keep retrying until the connection was successful.
