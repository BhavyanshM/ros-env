#!/bin/bash

IMAGE_TAG=kinetic:latest

# Assume dense_sptam node is inside a catkin workspace
CATKIN_WS_DIR=$PWD/../../

case "$1" in
  run)
    nvidia-docker run -it \
    --net=host \
    -v /etc/group:/etc/group:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v $CATKIN_WS_DIR:/usr/src/sptam \
    -v $HOME/.ssh:/home/$( id -u -n)/.ssh:ro \
    -v $SSH_AUTH_SOCK:/ssh-agent \
    -u $( id -u ):$( id -g ) \
    --mount type=tmpfs,destination=/home/$( id -u -n) \
    -e "SSH_AUTH_SOCK=/ssh-agent" \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    $IMAGE_TAG \
    /bin/bash
    ;;
  build)
    docker build -t $IMAGE_TAG .
    ;;
  *)
    echo "Usage: $0 {run|build}"
    exit 1
esac
