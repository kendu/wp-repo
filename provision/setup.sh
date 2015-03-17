#!/bin/bash

################################################################################
#                                                                              #
#                                 {o,o}                                        #
#                                 |)__)                                        #
#                                 -"-"-                                        #
#                                                                              #
################################################################################
#
# The setup script. Sets up development enviorment
#
###############################---EXECUTION---##################################

#Run docker containers
docker-compose up -d --no-recreate

#Pre build scritpt:
# ./provision/preBuild

#Start proxy
docker start proxy || \
docker run \
    -d \
    --restart always \
    --name proxy \
    -p 80:80 \
    -v /var/run/docker.sock:/tmp/docker.sock \
    jwilder/nginx-proxy


################################################################################
