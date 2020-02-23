---
title: IPFS
summary: A viable peer to peer alternative to HTTP.
# authors: []
tags:
- "meetup"
- "penguins-unbound"
categories: []
date: "2020-02-15"
---

# 2020-02-15 IPFS

## Penguins Unbound Intro

- TODO: email him about Wireguard 
- March - John will share random musing
- ?minibar? in April
- April - PiHole presentation
- Later presentation on Sonic Pi. Live coding music synthesizer
- Home Assitant meetup (Feb 24th), search for groups.

## IPFS interplanetary filesystem

A viable peer to peer alternative to HTTP.

author: emacsmax@posteo.net

## Current

### HTTP

- made in 1991
- de facto standard
- very centralized
- TCP/IP
- centralization causes censorship to be easy


### IPFS 

Motivations:

- decentralization
- persistence
- efficient (60% faster)

Overview

- peer to peer netwrok and protcol for hosting and sharing files
- written in Go (reference impl)
- also written in javascrip

apps

- graphical desktop application
- CLI
- browser extension
- IPFS iis built into 'brave' browser
- IPFS cluster

Mutable File System

- content within IPFS is content address and immutable
- MFS (Mutable File System) allows you to create and remove and modify files
- updating hashes and links is automatic

Content Addressing

- Objects are stored based on content, not lcoation
- Content identifiers serve this purpose in IPFS
- Content identifiers = codec + multihash

Selectors

- expressions that select a subset of nodes in a DAG

Merkle DAG

DAG=D

- data objects and named links create the Merkle DAG
- DAG = direct _ grpah
- Merkle is the crypto scheme

IPLD - InterPlantary Linked Data

- Creates a framework for content addressable decen data
- skel structure of the IPFS
- models linking data with hases are IPLD in the IPFS universe
- IPLD can be expressed in a number of data serialization formats: CBOR, JSON, YAML

IPLD Data Structure Hiearchy

Three layers

- block layer
- data model
- schema layer

Block Layer

- root layer of the hierachy
composed of a CID and its binary data

specifies the address of the blocks and how they are linked between one another and how they describe their codec


Data Model Layer

- data types (scalar kinds)
- represent these in a way that is agnotstic to the codecs we specify in the block layer
- flex

Schema Lyaer

- easy to use typing system
- lang. agnostic
- basic constructs for handling data types
- mapped to IPLD data model
- represented as a node grpah in IPLD

Authoring Schemas

- written in DSL or JSON
- definitions start with a type
- has presentation kinds (on top of data model kinds)

Use case for schemas

- docs
- validation
- versioning migration
- data transformation
- code generation

What can you do with it

- hosting websites and other traditional web content
- serving git repositories
- storing and playing media like videos and gifs

install ipfs

- get ipfs from your package manager
- or get the script from ipfs update script

Configuring your nodes

- start by running ipfs ini in shell, generates config
- different address types in the config we need to concern ourselves with

config items

- swarm
- API
- gateway

Configuring your node

what do address types mean?

- swarm address specify to the local daemon where to listen for other IPFS clients
- API address where the daemon will serve the HTTP APi from
- gteway address is 

- Bootsrap is an array of addresses that specifies IPFS peers your daemon connects to when connecting to the network
- Mounts set the default mount point for both IPFS and IPNS file mounts

Starting it

`ipfs daemon &`

you can open web ui at `http://127.0.0.1:5001/webui
GUI for viewing stats and stuff


### What now

- Add a file: `ipfs add somefile`
- interact with IPFS objects like they were a UNIX filesystem: `ipfs files`
    - provide commands like: ls, cp , mv, etc
    - chcid, flush, read, write

Set up your website

trivial to setup:

1. cd into directory
2. `ipfs add -r site-directory


Configuring DNS and IPNS

- set domain name, just use a TXT record like normal (using NDSLink)
- Use IPNS to avoid having to republish and update the record everytime
- Point using CNAME record

### Ancilary components

libp2p

- set of tools for making peer to peer to peer network applicaiton
- number of components: tranport, peer routing content delivery, messenging

Filecoin

- filecoin is the missing incentive compoent in IPFS
- algorithmic in

three facets

- decentralaized storage network
- proof of storage (replication spacetime)
- storage and retrival marks

DSN (decentral storage network)

Prop

- integrity
- retrievability
- publicly verifable
- autiable
- intrity comprable

Proof of Storage

- created to deal with waste inherent in proof of work
- Ensures greater security: Sybil Attacks, Outsourcing Attacks, and generation Attacks

PoS shows user that provider has allocated it to a unique block 

question time

- John: mentioned memcachedd, TODO look up
- John: cachedcluster those across
- How is it related to blockchian? Filecoin is blockchain based.
- network and storage is similar to blockchain
- Is there anything that provides permissions or authentication?
- people are using it to host a uncensorable wikipedia

## Closing up

Trading hardware

- John has two Access Points routers Atheros chip - *0211
- Cisco switch router
- phones
- ubiquete

amir runs freegeek

freegeek is looking for voluneers

three modes

- network manager - networkd
- networkd with netplay
- ifupdown - required for software defined network

- if you use laptop use 'network manager'
- if you use desktop. disable network manager but keep networkd
- if you run KVM and stuff, then go back to ifupdown (remove netplan, networkd)

when you create software defined netowk, it creates virtual interface devices.
