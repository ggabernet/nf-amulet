FROM continuumio/miniconda3

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
 unzip

ADD environment.yml /tmp/environment.yml
WORKDIR /tmp
RUN conda update -n base -c defaults conda
RUN conda install -c conda-forge mamba
RUN mamba env create -f /tmp/environment.yml
RUN git clone https://github.com/immcantation/amulet.git
WORKDIR /tmp/amulet
RUN pip install -e .
ENV PATH /opt/conda/envs/amulet/bin:$PATH