# base image
FROM sclinux1:443/repo_rdma/cuda:10.2-cudnn8-dev-ubu18
# local copy of: nvidia/cuda:10.2-cudn8-devel-ubuntu18.04

ENV PATH="/root/anaconda3/bin:${PATH}"
ARG PATH="/root/anaconda3/bin:${PATH}"
ENV OS_VER ubuntu18.04
ENV PLATFORM x86_64
ENV MOFED_VER 4.9-5.1.0.0

# install linux tools
RUN apt update && apt-get install -y wget git libcap2 net-tools libnuma-dev libudev-dev libz-dev vim iputils-ping

WORKDIR /opt

# Basic tools
###########
## conda ##
###########
RUN wget https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Anaconda3-2022.05-Linux-x86_64.sh -b \
    && rm -f Anaconda3-2022.05-Linux-x86_64.sh \
    && conda install -y sphinx_rtd_theme recommonmark 

RUN conda activate && conda update -y -n base -c defaults conda

## python 2.7 - some of OFED pkgs need python2.6/2.7
RUN conda create -n p27 -y python=2.7 

# RDMA drivers and tools support
##########
## OFED ##
##########

SHELL ["conda", "run", "-n", "p27", "/bin/bash", "-c"]
RUN conda activate p27 \
    && wget https://content.mellanox.com/ofed/MLNX_OFED-4.9-5.1.0.0/MLNX_OFED_LINUX-4.9-5.1.0.0-ubuntu18.04-x86_64.tgz \
    && tar xzf MLNX_OFED_LINUX-4.9-5.1.0.0-ubuntu18.04-x86_64.tgz \
    && cd MLNX_OFED_LINUX-4.9-5.1.0.0-ubuntu18.04-x86_64 \
    && ./mlnxofedinstall --force

###
###  the following image contains the above results:                ###
# FROM szlinux1:443/repo_rdma/ubu18:cuda102-cudnn8-ofed4.9-conda-python27

## conda p38 and support lib
RUN conda create -n p38 -y python=3.8 \
    && conda activate p38 \
    && conda install -y sphinx_rgd_theme -c "conda-forge/label/gcc7"

SHELL ["conda", "run", "-n", "p38", "/bin/bash", "-c"]

###########
## ompi  ##
###########

### the tag keep updating, modify to get the latest v5 of ompi
RUN cd /opt \
    && git clone https://github.com/open-mpi/ompi.git \
    && cd ompi \
    && git checkout tags/v5.0.0rc8 -b b5.0.0rc8 \
    && git submodule update --init --recursive \
    && ./autogen.pl \
    && mkdir build \
    && cd build \ 
    && ../configure --prefix=$CONDA_PREFIX --with-cuda --enable-mpi-thread-multiple --enable-debug \
    && make -j32 all \
    && make install

############################
## pytorch and submodules ##
############################
# export CMAKE_PREFIX_PATH="$(dirname $(which conda))/../" \

RUN cd /opt \
    && conda create -n p38 -y python=3.8 \
    && conda activate p38 \
    && export CMAKE_PREFIX_PATH=$CONDA_PREFIX \
    && conda install -y numpy ninja pyyaml mkl mkl-include setuptools cmake cffi typing_extensions future six requests dataclasses \
    && conda install -c pytorch -y magma-cuda102 \
    && git clone https://github.com/pytorch/pytorch.git \
    && cd pytorch && git checkout tags/v1.8.2 -b b1.8.2 \
    && git clean -xdf && python setup.py clean \
    && git submodule sync \
    && git submodule deinit -f . \
    && git submodule update --init --recursive \
    && python setup.py install

## torchvision
RUN cd /opt \
    && git clone https://github.com/pytorch/vision.git \
    && cd vision \
    && git checkout tags/v0.9.2 -b b0.9.2 \
    && python setup.py install

### alnair
#RUN cd /opt \
#    && git clone https://github.com/CentaurusInfra/alnair.git \
#    && cd alnair/test/distributed-training/  
    
