### The image is based on the one with pytorch configured linux

##################
## OFED setup ##
##################

## Stage: Build driver
#ARG D_BASE_IMAGE=ubuntu:20.04
ARG D_BASE_IMAGE=sclinux1:443/repo_rdma/cityscaps:fizzbb
FROM $D_BASE_IMAGE AS build

# Build Args - pass with --build-arg flag during build
ARG D_OFED_VERSION="5.0-2.1.8.0"
ARG D_OS="ubuntu20.04"
ARG D_ARCH="x86_64"
ARG D_OFED_PATH="MLNX_OFED_LINUX-${D_OFED_VERSION}-${D_OS}-${D_ARCH}"

ARG D_OFED_TARBALL_NAME="${D_OFED_PATH}.tgz"
ARG D_OFED_BASE_URL="https://www.mellanox.com/downloads/ofed/MLNX_OFED-${D_OFED_VERSION}"
ARG D_OFED_URL_PATH="${D_OFED_BASE_URL}/${D_OFED_TARBALL_NAME}"

# Internal arguments
ARG D_WITHOUT_FLAGS="--without-rshim-dkms --without-iser-dkms --without-isert-dkms --without-srp-dkms --without-kernel-mft-dkms --without-mlnx-rdma-rxe-dkms"

# Download and extract tarball
WORKDIR /root
RUN set -x && \
    apt-get -yq update && \
    apt-get -yq install curl perl && \
    (curl -sL ${D_OFED_URL_PATH} | tar -xzf -) && \
    /root/${D_OFED_PATH}/mlnxofedinstall --without-fw-update --kernel-only --force ${D_WITHOUT_FLAGS} && \
    rm -rf /tmp/MLNX_OFED_LINUX* && \
    sed -i '/ESP_OFFLOAD_LOAD=yes/c\ESP_OFFLOAD_LOAD=no' /etc/infiniband/openib.conf && \
    cp /root/${D_OFED_PATH}/docs/scripts/openibd-post-start-configure-interfaces/post-start-hook.sh /etc/infiniband/post-start-hook.sh && \
    chmod +x /etc/infiniband/post-start-hook.sh && \
    apt-get -yq install iproute2 net-tools ifupdown linux-modules-$(uname -r) netplan.io && \
    rm -rf /root/${D_OFED_PATH} && \
    apt-get clean autoclean && \
    rm -rf /var/lib/apt/lists/*

## Stage: Build container
FROM build

WORKDIR /
ADD ./entrypoint.sh /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]



##########################  reference dockerfile from Zhaobo's cityscaps branch

#From sclinux1:443/repo_rdma/cityscaps:fizzbb

## build cmd: docker build -t centaurusinfra/swin-transform-ss-cityscapes --build-arg CACHEBUST=$(date +%s) .
#From pytorch/pytorch:1.7.1-cuda11.0-cudnn8-runtime
#RUN apt-get update && apt-get install -y git vim wget
#RUN apt-get install ffmpeg libsm6 libxext6  -y # for libGL.so in container
#
#ARG CACHEBUST=1 # add this for not using cached git version during build
#RUN git clone https://github.com/Fizzbb/Swin_Trans_SS_Cityscapes.git
#WORKDIR ./Swin_Trans_SS_Cityscapes/
#
#RUN pip install -r requirement.txt
#RUN pip install mmcv-full==1.3.0 -f https://download.openmmlab.com/mmcv/dist/cu110/torch1.7.0/index.html
#RUN python setup.py develop
#
### comment out the execution code (should be move to execution script section in cluster) 
##download model checkpoint file for verification
##RUN wget https://download.openmmlab.com/mmsegmentation/v0.5/upernet/upernet_r50_512x1024_40k_cityscapes/upernet_r50_512x1024_40k_cityscapes_20200605_094827-aa54cb54.pth
## need GPU server to run the following
##RUN python model_verify.py
#
##download backbone for future training
#RUN wget https://github.com/SwinTransformer/storage/releases/download/v1.0.0/swin_tiny_patch4_window7_224.pth
##CMD ["sleep", "infinity"]
#CMD ["tools/dist_train.sh", "configs/swin/upernet_swin_tiny_patch4_window7_512x512_1k_cityscapes.py", "2", "--options", "model.pretrained=swin_tiny_patch4_window7_224.pth"]
