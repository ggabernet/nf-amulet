FROM nvidia/cuda:12.4.1-base-ubuntu22.04

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN apt-get update

RUN apt-get install -y unzip wget git

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
RUN conda --version

ADD environment.yml /tmp/environment.yml
WORKDIR /tmp
RUN conda update -n base -c defaults conda
RUN conda install -c conda-forge mamba
RUN mamba env create -f /tmp/environment.yml
RUN git clone https://github.com/immcantation/amulet.git
WORKDIR /tmp/amulet
RUN pip install -e .
ENV PATH /opt/conda/envs/amulet/bin:$PATH