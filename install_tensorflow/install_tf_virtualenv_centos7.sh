#!/bin/bash
USER=tensorflow
GPU_VERSION='-gpu' # cpu version, set this to ''

yum -y install epel-release install gcc gcc-c++ python-pip python-devel atlas atlas-devel gcc-gfortran openssl-devel libffi-devel
yum -y install cuda-command-line-tools-9-0

useradd $USER -d /home/$USER
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/extras/CUPTI/lib64
pip install --upgrade virtualenv
mkdir /home/$USER/
virtualenv --system-site-packages /home/$USER/
source /home/tensorflow/bin/activate
## install with gpu version
pip install --upgrade tensorflow${GPU_VERSION}
## or install with cpu version
##pip install --upgrade tensorflow

## Get cuDNN lib and put it to /home/$USER
echo "Get cuDNN lib and put it to /home/$USER"

## Set env
echo "## Add for $USER " >>  /home/$USER/.bashrc
echo "export
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-9.0/lib64:/home/$USER/cuda/lib64" >> /home/$USER/.bashrc
echo "export CUDA_HOME=/home/$USER/cuda/lib64" >> /home/$USER/.bashrc
echo "export PATH=/usr/local/cuda-9.0/bin:$PATH" >> /home/$USER/.bashrc

chown $USER:$USER -R /home/$USER
