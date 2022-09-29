# rdma-over-container

* draft project so far.
* Before enable FreeFlow, the current job is to have RDMA/Pytroch enabled iamge for "distributed" AI training tasks.

* `bin/vRouter.sh` is for triggering running container on the RDMA enabled machine.

# Dev Tools
## conda
https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html
```
bash Anaconda-latest-Linux-x86_64.sh
```

#### bash:
bash install will set shell environment through `$HOME/.bashrc`, make sure the `$HOME/.profile` includes below settings:
```
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
    fi  
fi

# set PATH so cuda bin if it exists
CUDAPATH="/usr/local/cuda"
if [ -d "$CUDAPATH/bin" ] ; then
    PATH="$PATH:$CUDAPATH/bin"
fi
```

## python3.9 
### conda

```
...
```
### apt installation
```
sudo add-apt-repository ppa:deadsnakes/ppa 
sudo apt update 
sudo apt install python3.9 
```

## CUDA
### locla mode
```
wget https://developer.download.nvidia.com/compute/cuda/11.4.0/local_installers/cuda_11.4.0_470.42.01_linux.run
sudo sh cuda_11.4.0_470.42.01_linux.run
```
## rdma user lib
```
git clone git://github.com/rdma-core

follow the README.md
```


# Driver prepareation
## other
https://github.com/CentaurusInfra/alnair/wiki/GPU-node-preparation#gpu-node-preparation

## cudnn
If you hit GPG keyring problem and can solve it smoothly, here's a workaround to install tarball directly:

cudnn download web: https://developer.nvidia.com/cudnn You need an account before download.
```
 tar xvf cudnn*.tgz
 cd cudnn-linux-x86_64.../
 sudo cp inluce/*.h /usr/local/cuda/include/
 sudo cp lib/libcudnn* /usr/local/cuda/lib64/
 sudo chmod a+r /usr/local/cuda/lib64/libcudnn*
```

## RDMA OFED  
Kernel modules and RDMA tools included. 


# Libraries
## pytorch (binary)
https://pytorch.org/get-started/locally/
```
conda install pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch
```

## openmpi
```
sudo apt install openmpi-bin openmpi-common
```
The following will be installed when installing `openmpi-bin`:
```
 libfabric1 libhwloc-plugins libhwloc5 libopenmpi2 libpsm-infinipath1 ocl-icd-libopencl1 openmpi-bin openmpi-common
 
```
### Build from source:
```
mkdir build && cd build
../configure --prefix=/usr/local --with-cuda --enable-mpi-thread-multiple
```
or with more debug info
```
../configure --prefix=/usr/local --with-cuda --enable-mpi-thread-multiple --enable-debug 
../configure --prefix=/usr/local --with-cuda --enable-mpi-thread-multiple --enable-debug --enable-mem-debug --enable-event-debug ?
```
```
make -j X all
sudo make install
```
#### in my case:
```
mkdir build && cd build && ../configure --prefix=/usr/local --with-cuda --enable-mpi-thread-multiple --enable-debug --enable-mem-debug --enable-event-debug  && make -j 32 all && sudo make install 
```
## pytorch with openmpi build first
```
git clone --recursive git://github.com/pytorch...
cd pytorch
python setup.py install 
```


# References
## Driver
https://github.com/mjiUST/driver_cuda_cudnn
