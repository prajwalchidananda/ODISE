# Use the official NVIDIA CUDA image as a base
FROM nvidia/cuda:11.6.1-cudnn8-devel-ubuntu20.04

# Set the working directory in the container
WORKDIR /app

# Set environment variables
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=US/Pacific

# Install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    curl \
    g++ \
    wget \
    bzip2 \
    git \
    vim \
    tmux \
    htop \
    git \
    zip \
    unzip \
    ca-certificates \
    libosmesa6-dev \
    libgl1-mesa-glx \
    libglfw3 \
    patchelf \
    libglu1-mesa \
    libxext6 \
    libxtst6 \
    libxrender1 \
    libxi6 \
    libjpeg-dev \
    libpng-dev \
    libopenblas-dev \
    libopencv-dev \
    libyaml-dev \
    libavformat-dev \
    libavcodec-dev \
    libswscale-dev \
    libavutil-dev \
    libavfilter-dev \
    libavdevice-dev \
    libswresample-dev \
    less \
    groff \
    mpich \
    && rm -rf /var/lib/apt/lists/*

# Install git lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get install -y git-lfs
RUN git lfs install


RUN curl https://rclone.org/install.sh | bash

# Set timezone
RUN ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime

# Set CUDA_ROOT
RUN export CUDA_HOME="/usr/local/cuda"

# Install Miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh

# Add conda to PATH
ENV PATH /opt/conda/bin:$PATH

# Create and activate the conda environment
RUN conda create -n odise python=3.9 && \
    echo "source activate odise" > ~/.bashrc
ENV PATH /opt/conda/envs/odise/bin:$PATH
ENV CONDA_DEFAULT_ENV odise


# Set the working directory to the ODISE directory
RUN conda install pytorch=1.13.1 torchvision=0.14.1 pytorch-cuda=11.6 -c pytorch -c nvidia -y
RUN conda install -c "nvidia/label/cuda-11.6.1" libcusolver-dev -y
RUN git clone https://github.com/prajwalchidananda/ODISE.git /app/ODISE && \
    cd /app/ODISE && \
    git checkout dust3r_docker && \
    git checkout d301c78

# Install the ODISE package
WORKDIR /app/ODISE
RUN pip install -e .

# Install xformers
RUN pip install xformers==0.0.16

# Downgrade pillow to 9.5.0 to avoid issues with detectron2
RUN pip install pillow==9.5.0

# Downgrade numpy to 1.23.1 to avoid issues with np.bool
RUN pip install numpy==1.23.1

RUN chmod +x /opt/conda/envs/odise/bin/python
