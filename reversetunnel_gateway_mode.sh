#!/usr/bin/env bash

##don't forget this in the /etc/ssh/sshd_config server's file:
#Match User stratio
#        GatewayPorts yes

ssh -f -gR 8888:localhost:80 $(whoami)@localhost echo #the -f puts it in the background and the echo is just a command 

#sudo ssh -L 1234:localhost:22 ubuntu@my_amazon_machine
##and then you can connect to it doing "ssh ubuntu@localhost -p 1234"

#sudo ssh -N -R 1234:localhost:80 ubuntu@my_amazon_machine
##and then see your apache from http://my_amazon_machine:1234

#sudo ssh -N -R 1234:localhost:22 ubuntu@my_amazon_machine
##and then let other people access your computer from the outside like this:ssh carlos@my_amazon_machine -p 1234
