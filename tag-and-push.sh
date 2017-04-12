#!/bin/bash

# use the time as a tag
UNIXTIME=$(date +%s)

# docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
docker tag containerpilotexperiment_container-pilot:latest kurron/container-pilot:latest
docker tag containerpilotexperiment_container-pilot:latest kurron/container-pilot:${UNIXTIME}
docker images

# Usage:  docker push [OPTIONS] NAME[:TAG]
docker push kurron/container-pilot:latest
docker push kurron/container-pilot:${UNIXTIME}
