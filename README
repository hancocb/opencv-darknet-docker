in progress

Running the container
```
docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" *container_name*
```

If you see the following error,
```
No protocol specified
Error: Can't open display *X*:*X*
```
run ```xhost local:docker``` before running the container. If
you are not using the docker group and running docker as sudo,
you will need to change ```local:docker``` to ```local:root```.