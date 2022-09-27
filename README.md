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
### apt
```
sudo add-apt-repository ppa:deadsnakes/ppa 
sudo apt update 
sudo apt install python3.9 
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

# Libraries
https://pytorch.org/get-started/locally/
```
conda install pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch
```




# References
## Driver
https://github.com/mjiUST/driver_cuda_cudnn
