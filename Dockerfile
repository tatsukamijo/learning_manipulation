ARG cuda_docker_tag="11.2.2-cudnn8-devel-ubuntu20.04"
FROM nvidia/cuda:${cuda_docker_tag}

RUN apt-get update

# tzdata is required below. To avoid hanging, install it first.
RUN DEBIAN_FRONTEND="noninteractive" apt-get install tzdata -y
RUN apt-get install git wget curl libgl1-mesa-glx -y

# Install python3.8.
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get install python3.8 -y

# Make python3.8 the default python.
RUN rm /usr/bin/python3
RUN ln -s /usr/bin/python3.8 /usr/bin/python3
RUN ln -s /usr/bin/python3.8 /usr/bin/python
RUN apt-get install python3-distutils -y

# Install pip.
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN rm get-pip.py

# Create Mujoco subdir.
RUN mkdir /root/.mujoco
COPY mjkey.txt /root/.mujoco/mjkey.txt

# Prerequisites
RUN apt-get install \
  libosmesa6-dev \
  libgl1-mesa-glx \
  libglfw3 \
  libglew-dev \
  libglib2.0-0 \
  libegl1-mesa \
  libegl1-mesa-dev \
  libgl1-mesa-dri \
  libgles2-mesa-dev \
  libglew2.1 \
  patchelf \
  gcc \
  libxrandr2 \
  libxinerama1 \
  libxcursor1 \
  python3.8-dev \
  unzip -y \
  libxrandr2 \
  libxinerama1 \
  libxcursor1 \
  vim \
  openssh-server \
  curl

# Download and install mujoco.
RUN wget https://www.roboti.us/download/mujoco200_linux.zip
RUN unzip mujoco200_linux.zip
RUN rm mujoco200_linux.zip
RUN mv mujoco200_linux /root/.mujoco/mujoco200
RUN wget -P /root/.mujoco/mujoco200/bin/ https://roboti.us/file/mjkey.txt

# Add LD_LIBRARY_PATH environment variable.
ENV LD_LIBRARY_PATH "/root/.mujoco/mujoco200/bin:${LD_LIBRARY_PATH}"
RUN echo 'export LD_LIBRARY_PATH=/root/.mujoco/mujoco200/bin:${LD_LIBRARY_PATH}' >> /etc/bash.bashrc

# Install Python packages.
RUN pip install mujoco gym torch==2.0.0 torchvision==0.15.1

# # Robosuite dependencies
# WORKDIR /root/workspace/robosuite
# RUN 

