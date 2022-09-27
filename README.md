# rdma-over-container

* draft project so far.
* Before enable FreeFlow, the current job is to have RDMA/Pytroch enabled iamge for "distributed" AI training tasks.

* `bin/vRouter.sh` is for triggering running container on the RDMA enabled machine.



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


# References
## Driver
https://github.com/mjiUST/driver_cuda_cudnn
