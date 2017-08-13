FROM ubuntu:16.04

WORKDIR /usr/src/app

# install from apt
RUN apt-get update -y -qq \
    && apt-get install -y \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    build-essential \
    cmake \
    pkg-config \
    libjpeg8-dev \
    libtiff5-dev \
    libjasper-dev \
    libpng12-dev \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    libgtk-3-dev \
    libatlas-base-dev \
    gfortran \
    python2.7-dev \
    unzip \
    wget

RUN apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# get source code
RUN cd ~/ &&\
    wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.1.0.zip &&\
    wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.1.0.zip &&\
    unzip opencv.zip &&\
    unzip opencv_contrib.zip &&\
    rm -rf opencv.zip opencv_contrib.zip

# install numpy
RUN cd ~/ &&\
    wget https://bootstrap.pypa.io/get-pip.py &&\
    python get-pip.py &&\
    pip install numpy &&\
    rm -rf ~/get-pip.py

# install opencv 
RUN cd ~/opencv-3.1.0/ &&\
    mkdir build &&\
    cd build &&\
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D INSTALL_C_EXAMPLES=OFF \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.1.0/modules \
    -D BUILD_EXAMPLES=ON .. &&\
    make -j4 &&\
    make install &&\
    ldconfig &&\
    cd ~/ &&\
    rm -rf ~/opencv*

EXPOSE 8000

CMD ["bash"]



    
    
    

    

    


    
