# HAProxy and Docker example

This is an example of a simple architecture using multiple docker hosts, load-balanced using HAProxy.

# Quick start

## Requirements

To run the example, you need the following tools :

- Virtualbox
- Vagrant

## Architecture

![architecture diagram](docs/diagram.png)

## Getting up and running

First, set the number of docker hosts you want in the **Vagrantfile**. Each host is on his own virtual machine.

    # Set the number of docker hosts you want
    $nodeCount = 2

Then, from a terminal

    vagrant up

You should be able to access the proxy from http://192.168.0.10

You can have access to stats at the following address : http://192.168.0.10/haproxy?stats
