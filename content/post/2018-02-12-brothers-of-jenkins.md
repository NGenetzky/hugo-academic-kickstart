+++
title = "Brothers of Jenkins"
date = 2018-02-12
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = [
    "ci",
    "docker",
    "jenkins",
]
categories = []

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `image = "example.jpg"`.
# Use `caption` to display an image caption.
#   Markdown linking is allowed, e.g. `caption = "[Image credit](http://example.org)"`.
# Set `preview` to `false` to disable the thumbnail in listings.
#[header]
#image = ""
#caption = ""
#preview = true
+++

## Avoid Docker-in-Docker

[Using Docker-in-Docker for your CI or testing environment? Think twice.](http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)
by [@jpetazzo](http://jpetazzo.github.io/) explains why the DinD approach is
bad for CI, and how using an alternative approach will allow the docker
container to create sibling containers rather than child containers.

## Modifying my Docker setup

I need to install docker into in a layer on top of the standard Jenkins image.
[@mjuuso](https://github.com/mjuuso) has already demonstrated this in
 [getintodevops/jenkins-withdocker](https://github.com/getintodevops/jenkins-withdocker)
 and there is an associated blog post
 ([The simple way to run Docker-in-Docker for CI](https://getintodevops.com/blog/the-simple-way-to-run-docker-in-docker-for-ci)).
 Another example of the same additions to a Dockerfile can be found on this post
 ([Building containers with Docker in Docker and Jenkins](https://renzedevries.wordpress.com/2016/06/30/building-containers-with-docker-in-docker-and-jenkins/)).

The first issue is quickly encountered, permission are required for Jenkins to
use docker.  This was handled pretty cleanly by adding 'docker' to
[group_add](https://docs.docker.com/compose/compose-file/compose-file-v2/#group_add)
in the `docker-compose.yaml` file. I believe `--user="$(id -u)"` might work if
the container is run directly, but it is slightly doing something slightly
different.

## Parents and Children have different points of view

The second issue might be encountered when trying to mount a directory during a run
command.  Mounting directories to container inside Jenkins does not work as expected.

The other problem is slightly more complex.
[Alternative to Docker-in-Docker](https://www.develves.net/blogs/asd/2016-05-27-alternative-to-docker-in-docker/)
identifies a possible solution.

One solution that may be available for many builds that wish to run a container
that does not require additional volumes could be:

```
docker run \
    ... \
    --volume "jenkins_home:${JENKINS_HOME}"
    --workdir "${WORKSPACE}"
    ...
```

For instance I was able to build this site from within the dockerized jenkins.
I had to change some variables (aka HUGO_DESTINATION) for it to work. As I begin to
think about it more I actually think the image is trying to do too much for me.
I simply expect it to provide access to the hugo application, but instead it is
attempting to make it easier to use.

```
docker run \
    --user "1000:1000" \
    --volume "ngenetzkyci_master_home:${JENKINS_HOME}" \
    --workdir "${WORKSPACE}" \
    -e HUGO_DESTINATION="${WORKSPACE}/public" \
    jojomi/hugo:latest \
    hugo
```


