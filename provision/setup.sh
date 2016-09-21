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
#################################---ENV---######################################

set -e
set -u

################################################################################

##############################---VARIABLES---###################################

DOCKER_IMAGES=( "kendu/wordpress" "mysql" )
DOCKER_PULL_LOCK=".dockerPullLock"
if ! [ "$#" -lt 1 ] && [ $1 == "--pull" ]
    then
    DOCKER_PULL=true
else
    DOCKER_PULL=false
fi

################################################################################

###############################---EXECUTION---##################################

#Pull containers.
if  [ ${DOCKER_PULL} == true ] ||
    [ ! -e "${DOCKER_PULL_LOCK}" ] ||
    [[ "$(date -r ${DOCKER_PULL_LOCK} +%F )" != "$(date +%F )" ]]
    then
    echo " > Checking for docker image updates"
    touch ${DOCKER_PULL_LOCK}
    for image in ${DOCKER_IMAGES[@]}
    do
        docker pull $image
    done
else
    echo " > Docker images have already been updated today, to force use '--pull'"
fi

#Run docker containers
docker-compose up -d --no-recreate

#Pre build scritpt:
./provision/preBuild

################################################################################
