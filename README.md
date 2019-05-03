# Docker container for Darknet + OpenCV

## Building the container
```
  git clone https://github.com/hancocb/opencv-darknet-docker.git
  cd ./opencv-darknet-docker
  docker build -t darknet .
```

## Running the container
```
  docker run -i -d --name=darknet --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" darknet
```
If you see the following error,
```
No protocol specified
Error: Can't open display X:X
```
run `xhost local:docker` before running the container. If
you are not using the docker group and running docker as sudo,
you will need to change `local:docker` to `local:root`.

## Using the container
Example:
```
  docker exec darknet ./darknet imtest path_to_image
```
