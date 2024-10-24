#!/bin/bash

PROJECT_NAME=learning_manipulation
PROJECT_CONTAINER_NAME=learning_manipulation
CONTAINER_NAME=${PROJECT_CONTAINER_NAME}
IMAGE_NAME=${PROJECT_NAME}
TAG_NAME=latest

# Allow access to the X server
xhost +local:docker

# Check if a container with the same name is already running
if [ $(docker ps -aq -f name=$CONTAINER_NAME) ]; then
    echo "Container with the name $CONTAINER_NAME already exists."
    if [ $(docker ps -q -f name=$CONTAINER_NAME) ]; then
        echo "Entering the existing running container..."
        docker exec -it --workdir /root/workspace $CONTAINER_NAME bash
    else
        echo "Starting the existing stopped container..."
        # initialize to /root/mujoco_docker directory
        docker start $CONTAINER_NAME
        docker exec -it --workdir /root/workspace $CONTAINER_NAME bash
    fi
    exit
fi

docker run -it \
    --privileged \
    --gpus all \
    --net host \
    --env DISPLAY=${DISPLAY} \
    -v /dev:/dev \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ${PWD}:/root/workspace \
    -e LD_LIBRARY_PATH=/root/.mujoco/mujoco200/bin \
    --name ${CONTAINER_NAME} \
    ${IMAGE_NAME}:${TAG_NAME} \
    bash

# enter the container
docker exec -it --workdir /root/workspace ${CONTAINER_NAME} bash

xhost -local:docker
