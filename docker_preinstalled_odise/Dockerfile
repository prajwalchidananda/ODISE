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

# Install PyTorch, torchvision, and CUDA support
RUN conda install pytorch=1.13.1 torchvision=0.14.1 pytorch-cuda=11.6 -c pytorch -c nvidia && \
    conda install -c "nvidia/label/cuda-11.6.1" libcusolver-dev

# Set environment variables for CUDA
ENV CUDA_HOME=/usr/local/cuda-11.6
ENV LD_LIBRARY_PATH=${CUDA_HOME}/lib64:$LD_LIBRARY_PATH
ENV PATH=${CUDA_HOME}/bin:$PATH

# Clone the ODISE repository
RUN git clone https://github.com/NVlabs/ODISE.git /app/ODISE

# Set the working directory to the ODISE directory
WORKDIR /app/ODISE

# Install the ODISE package
RUN pip install -e .

# Install xformers
RUN pip install xformers==0.0.16

# Set the entrypoint to bash
ENTRYPOINT ["bash"]
