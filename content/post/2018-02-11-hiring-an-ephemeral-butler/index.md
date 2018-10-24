+++
title = "Hiring a Ephemeral Butler"
date = 2018-02-11
draft = false
tags = [
    "ci",
    "docker",
    "jenkins",
]
categories = []
+++

## Clean up, before I get messy

I have been running a lot of different docker containers, and often forgetting
to use `--rm`. So I pruned my system: `docker system --prune` as recommended by
[this answer on StackOverfow](https://stackoverflow.com/a/32723127).


## Starting Simple

I followed the [steps outlined on jenkinsci](https://github.com/jenkinsci/docker/blob/master/README.md).
I used the command below to get the password from the master container I just started.

```
docker exec -it $(docker container ls -l --format "{{.Names}}") cat /var/jenkins_home/secrets/initialAdminPassword
```

## Composed of Greatness

I like to plan for the future and I imagine eventually I will have to customize
the official image. So I created my own Dockerfile `FROM` the image above. Scripts
are nice for one-off build and runs, but for anything more complex I like to make a
docker-compose file.

I installed the plugins via the web interface, but then I will later export
them to `plugins.txt` for reproducibility of the `master_home` volume. For
now I simply captured what was installed by default by using the command
provided in the readme above.

```
JENKINS_HOST=username:password@myhost.com:port
curl -sSL "http://$JENKINS_HOST/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'|sed 's/ /:/'
```

## Encapsulation of requirements

I do not have an entire server farm at my disposal. I have a single powerful
computer. For this reason I would like to be able to execute builds within
a docker container. I am researching into the various plugins available and
the works published by others.

Most notably:

- [The simple way to run Docker-in-Docker for CI](https://getintodevops.com/blog/the-simple-way-to-run-docker-in-docker-for-ci)
- [dind-jenkins-slave](https://github.com/tehranian/dind-jenkins-slave)
- [Using Docker-in-Docker for your CI or testing environment? Think twice.](http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)

