<h1>Docker container for Darknet + OpenCV</h1>
<h2>Building the container</h2>
<pre>
  git clone https://github.com/hancocb/opencv-darknet-docker.git
  cd ./opencv-darknet-docker
  docker build -t darknet .
</pre>  
<h2>Running the container</h2>
<pre>
  docker run -i -d --name=darknet --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" darknet
</pre>
If you see the following error,
<pre>
No protocol specified
Error: Can't open display <em>X</em>:<em>X</em>
</pre>
run ```xhost local:docker``` before running the container. If
you are not using the docker group and running docker as sudo,
you will need to change ```local:docker``` to ```local:root```.
<h2>Using the container</h2>
Example:
<pre>
  docker exec darknet ./darknet imtest <em>path_to_image</em>
</pre>
