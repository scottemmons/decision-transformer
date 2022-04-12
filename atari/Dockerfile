# Based on HumanCompatibleAI/eirli Dockerfile
# Conda bits are based on https://hub.docker.com/r/continuumio/miniconda3/dockerfile
FROM ubuntu:20.04

RUN apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    git \
    libgl1-mesa-dev \
    libgl1-mesa-glx \
    libglew-dev \
    libosmesa6-dev \
    software-properties-common \
    net-tools \
    unzip \
    unrar \
    vim \
    virtualenv \
    wget \
    xpra \
    xserver-xorg-dev \
    libxrandr2 \
    libxss1 \
    libxcursor1 \
    libxcomposite1 \
    libasound2 \
    libxi6 \
    libxtst6 \
    libegl1-mesa \
    xvfb \
    rsync \
    gcc \
    gnupg \
    g++ \
    tmux \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
RUN curl -o /usr/local/bin/patchelf https://s3-us-west-2.amazonaws.com/openai-sci-artifacts/manual-builds/patchelf_0.9_amd64.elf \
  && chmod +x /usr/local/bin/patchelf

# Install Cloud SDK
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - \
  && apt-get update -y \
  && apt-get install google-cloud-sdk -y

# tini is a simple init which is used by the official Conda Dockerfile (among
# other things). It can do stuff like reap zombie processes & forward signals
# (e.g. from "docker stop") to subprocesses. This may be useful if the code
# breaks in such a way that it creates lots of zombies or cannot easily be
# killed (e.g. maybe a Python extension segfaults and doesn't wait on its
# children, which keep running). That said, Sam hasn't yet run into a
# situation where it was necessary with the il-representations code base, at
# least as of October 2020.
ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

# Install Conda and make it the default Python
ENV PATH /opt/conda/bin:$PATH
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /root/conda.sh || true \
  && bash /root/conda.sh -b -p /opt/conda || true \
  && rm /root/conda.sh
RUN conda update -n base -c defaults conda \
  && conda install -c anaconda python=3.7 \
  && conda update pip \
  && conda clean -ay

# Install CUDA and PyTorch
# Note pytorch==1.2.0 doesn't work with cudatoolkit=11.0
# and pytorch==1.7.1 doesn't work with cudatoolkit=11.3
RUN conda install -c anaconda cudatoolkit \
  && conda install pytorch==1.7.1 cudatoolkit=11.0 -c pytorch

# Install remaining Python requirements
ADD requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

# Install Atari ROMs
RUN wget http://www.atarimania.com/roms/Roms.rar -O /tmp/Roms.rar \
  && mkdir /tmp/roms \
  && unrar x /tmp/Roms.rar /tmp/roms \
  && unzip /tmp/roms/ROMS.zip -d /tmp/roms \
  && unzip /tmp/roms/HC\ ROMS.zip -d /tmp/roms \
  && rm /tmp/Roms.rar \
  && python -m atari_py.import_roms /tmp/roms \
  && rm -r /tmp/roms

# Always run under tini (see explanation above)
ENTRYPOINT ["/usr/bin/tini", "--"]
