#!/bin/bash -v

DOCKER_HOST=`/sbin/ip route|awk '/default/ { print $3 }'` DOCKER_RUNNING=yes salt-call --local state.apply &&\
tail -F $DOCKER_TAILF_FILE