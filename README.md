# learning_manipulation

## 1. Clone the repository & setup the submodule
```bash
git clone https://github.com/tatsukamijo/learning_manipulation.git
git submodule update --init --recursive
```

## 2. Setup the Docker container
```bash
./BUILD_DOCKER_IMAGE.sh
./RUN_DOCKER_CONTAINER.sh YOUR_NAME
```
Building the Docker image may take a while.  
Read the robosuite documentation while waiting for that: https://robosuite.ai/docs/overview.html

