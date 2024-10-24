#!/bin/bash

PROJECT_NAME=learning_manipulation

# Check if the image already exists
if [[ "$(docker images -q ${PROJECT_NAME} 2> /dev/null)" != "" ]]; then
    echo "Docker image '${PROJECT_NAME}' already exists. Use the existing image. Exiting..."
    exit 1
fi

# Build the Docker image
docker build -t ${PROJECT_NAME} .
