FROM nvidia/cuda:12.4.1-base-ubuntu22.04

RUN apt-get update

RUN apt-get install -y unzip wget git && rm -rf /var/lib/apt/lists/*

ENV PATH /opt/conda/bin:$PATH

# Install miniconda3
# Leave these args here to better use the Docker build cache
# renovate: datasource=custom.miniconda_installer
ARG INSTALLER_URL_LINUX64="https://repo.anaconda.com/miniconda/Miniconda3-py312_24.3.0-0-Linux-x86_64.sh"
ARG SHA256SUM_LINUX64="96a44849ff17e960eeb8877ecd9055246381c4d4f2d031263b63fa7e2e930af1"
# renovate: datasource=custom.miniconda_installer
ARG INSTALLER_URL_S390X="https://repo.anaconda.com/miniconda/Miniconda3-py312_24.3.0-0-Linux-s390x.sh"
ARG SHA256SUM_S390X="b601cb8e3ea65a4ed1aecd96d4f3d14aca5b590b2e1ab0ec5c04c825f5c5e439"
# renovate: datasource=custom.miniconda_installer
ARG INSTALLER_URL_AARCH64="https://repo.anaconda.com/miniconda/Miniconda3-py312_24.3.0-0-Linux-aarch64.sh"
ARG SHA256SUM_AARCH64="05f70cbc89b6caf84e22db836f7696a16b617992eb23d6102acf7651eb132365"

RUN set -x && \
    UNAME_M="$(uname -m)" && \
    if [ "${UNAME_M}" = "x86_64" ]; then \
        INSTALLER_URL="${INSTALLER_URL_LINUX64}"; \
        SHA256SUM="${SHA256SUM_LINUX64}"; \
    elif [ "${UNAME_M}" = "s390x" ]; then \
        INSTALLER_URL="${INSTALLER_URL_S390X}"; \
        SHA256SUM="${SHA256SUM_S390X}"; \
    elif [ "${UNAME_M}" = "aarch64" ]; then \
        INSTALLER_URL="${INSTALLER_URL_AARCH64}"; \
        SHA256SUM="${SHA256SUM_AARCH64}"; \
    fi && \
    wget "${INSTALLER_URL}" -O miniconda.sh -q && \
    echo "${SHA256SUM} miniconda.sh" > shasum && \
    sha256sum --check --status shasum && \
    mkdir -p /opt && \
    bash miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh shasum && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

ADD environment.yml /tmp/environment.yml
WORKDIR /tmp
RUN conda update -n base -c defaults conda
RUN conda install -c conda-forge mamba
RUN mamba env create -f /tmp/environment.yml
RUN git clone https://github.com/immcantation/amulety.git
ENV PATH /opt/conda/envs/amulety/bin:$PATH
ARG PATH /opt/conda/envs/amulety/bin:$PATH
WORKDIR /tmp/amulety
RUN git checkout dev
RUN /opt/conda/envs/amulety/bin/python -m pip install .

# Getting IgBLAST references
WORKDIR /
RUN wget -c https://github.com/nf-core/test-datasets/raw/airrflow/database-cache/igblast_base.zip
RUN unzip igblast_base.zip