in progress

Running the container
<pre>
docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" *container_name*
</pre>

If you see the following error,
<pre>
No protocol specified
Error: Can't open display <em>X</em>:<em>X</em>
</pre>
run <pre>xhost local:docker</pre> before running the container. If
you are not using the docker group and running docker as sudo,
you will need to change <pre>local:docker</pre> to <pre>local:root</pre>.