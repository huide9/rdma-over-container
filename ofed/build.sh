#!/usr/bin/env bash
docker build -t rdma:ofed-cuda-cudnn-pytorch1.8-with-ompi5.0rc-vision0.9 - < ./Dockerfile
