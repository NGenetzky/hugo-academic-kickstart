+++
title = "Swagger Server implemented with python flask on RPI"
date = 2018-02-04
draft = false
tags = [
    "github",
    "openapi",
    "python",
    "resin",
    "rpi",
    "swagger",
]
categories = []
+++

## More complicated application

Earlier today I deployed a application to my rpi3 that started from an example
project provided by Resin.io, but now I would like to explore converting an
existing application that is a little more complex.

## Swagger Petstore

This is a sample Petstore server. You can find out more about Swagger at
http://swagger.io or on irc.freenode.net, #swagger.

## Swagger Codegen from OpenAPI

- [OpenAPI-Specification](https://github.com/OAI/OpenAPI-Specification)
- [NGenetzky/ngenetzky-petstore](https://github.com/NGenetzky/ngenetzky-petstore)
- [swaggerhub/ngenetzky-petstore](https://app.swaggerhub.com/apis/nathansen/ngenetzky-petstore/1.0.0)

I revisted an old project that explored the capability to generate code from a
config file describing an API. This project involved manually generating
the swagger-codegen from [swaggerhub](https://app.swaggerhub.com/).

## Modifying Project to deploy to Resin.io

This was much simpler than I thought it was going to be.

1. Copied the Dockerfile
2. Two simple modifications
  1. FROM is template (`FROM resin/%%RESIN_MACHINE_NAME%%-alpine-python:3`)
  2. ENV to enable initsystem (`ENV INITSYSTEM on`)
3. Force push to the git.resin.io application remote

