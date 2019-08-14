FROM gapsystem/gap-docker-base

MAINTAINER The GAP Group <support@gap-system.org>

# Prerequirements
RUN    sudo apt-get update -qq \
    && sudo apt-get -qq install -y \
                                   # for ANUPQ package to build in 32-bit mode
                                   gcc-multilib \
                                   # for ZeroMQ package
                                   libzmq3-dev \
                                   # for curlInterface
                                   libcurl4-openssl-dev \
                                   # for Jupyter
                                   python3-pip

RUN sudo pip3 install notebook jupyterlab_launcher jupyterlab traitlets ipython vdom

RUN    cd /home/gap/inst/ \
    && wget -q https://github.com/gap-system/gap/archive/stable-4.9.zip \
    && unzip -q stable-4.9.zip \
    && rm stable-4.9.zip \
    && cd gap-stable-4.9 \
    && ./autogen.sh \
    && ./configure \
    && make \
    && mkdir pkg \
    && cd pkg \
    && wget -q https://www.gap-system.org/pub/gap/gap4pkgs/packages-stable-4.9.tar.gz \
    && tar xzf packages-stable-4.9.tar.gz \
    && rm packages-stable-4.9.tar.gz \
    && ../bin/BuildPackages.sh \
    && cd JupyterKernel-* \
    && python3 setup.py install --user

RUN jupyter serverextension enable --py jupyterlab --user

ENV PATH /home/gap/inst/gap-stable-4.9/pkg/JupyterKernel-0.99999/bin:${PATH}
ENV JUPYTER_GAP_EXECUTABLE /home/gap/inst/gap-stable-4.9/bin/gap.sh

# Set up new user and home directory in environment.
# Note that WORKDIR will not expand environment variables in docker versions < 1.3.1.
# See docker issue 2637: https://github.com/docker/docker/issues/2637
USER gap
ENV HOME /home/gap
ENV GAP_HOME /home/gap/inst/gap-stable-4.9
ENV PATH ${GAP_HOME}/bin:${PATH}

# Start at $HOME.
WORKDIR /home/gap

# Start from a BASH shell.
CMD ["bash"]
