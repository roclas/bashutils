#!/usr/bin/env bash

##don't forget this in the /etc/ssh/sshd_config server's file:
#Match User stratio
#        GatewayPorts yes

ssh -gR 1234:localhost:80 carlos@localhost
