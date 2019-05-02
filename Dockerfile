# Base image
FROM ubuntu:16.04

# Install OpenCV requirements
RUN \
  sed -i "s/# \(.*multiverse$\)/\1/g" /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev && \
  apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev

# Build and install OpenCV
RUN \
  mkdir /opencv && cd /opencv && \
  git clone https://github.com/opencv/opencv.git && cd ./opencv && git checkout 3.4 && cd .. && \
  git clone https://github.com/opencv/opencv_contrib.git && cd ./opencv_contrib && git checkout 3.4 && cd .. && \
  cd ./opencv && mkdir ./build && cd ./build && \
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules/ -DPYTHON2_EXECUTABLE=/usr/bin/python2.7 -DPYTHON_INCLUDE_DIR=/usr/include/python2.7 -DPYTHON_INCLUDE_DIR2=/usr/include/x86_64-linux-gnu/python2.7 -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython2.7.so -DPYTHON2_NUMPY_INCLUDE_DIRS=/usr/lib/python2.7/dist-packages/numpy/core/include -DOPENCV_GENERATE_PKGCONFIG=ON -DBUILD_EXAMPLES=ON .. && \
  make -j7 && make install

# Run OpenCV tests
RUN \
  cd /opencv && git clone https://github.com/opencv/opencv_extra.git && \
  cd ./opencv_extra && export OPENCV_TEST_DATA_PATH=/opencv/opencv_extra/testdata && cd / && \
  ./opencv/opencv/build/bin/opencv_test_core

# Build Darknet
RUN \
  export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig && \
  mkdir /darknet && cd /darknet && \
  git clone https://github.com/pjreddie/darknet.git && cd ./darknet && \
  sed -i 's/OPENCV=0/OPENCV=1/g' ./Makefile && make && \
  ldconfig

# Set environment variables
ENV HOME /darknet

# Define working directory
WORKDIR /darknet

# Define default command
CMD ["bash"]