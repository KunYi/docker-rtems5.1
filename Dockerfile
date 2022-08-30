# This image for RTOS RTEMS 5 Development
FROM ubuntu:jammy
LABEL maintainer="KunYi Chen <kunyi.chen@gmail.com>"

ARG TARGETPLATFORM
ARG DEBIAN_FRONTEND=noninteractive
ARG DEFAULT_USER=kunyi
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y locales

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US:en

RUN apt-get build-dep -y build-essential gcc-defaults g++ gdb unzip \
            pax bison flex texinfo python3-dev libpython2-dev libncurses5-dev \
            zlib1g-dev

RUN apt install -y python-is-python3 python3 python2-dev git git-lfs wget unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd --create-home --no-log-init --shell /bin/bash $DEFAULT_USER
USER $DEFAULT_USER
WORKDIR /home/$DEFAULT_USER

COPY --chown=$DEFAULT_USER:$DEFAULT_USER build.sh /home/$DEFAULT_USER/rtems5_install.sh
RUN chmod u+x rtems5_install.sh
RUN echo "" >> /home/$DEFAULT_USER/.bashrc && \
    echo "# add RTEMS PATH" >> /home/$DEFAULT_USER/.bashrc && \
    echo "export PATH=$HOME/development/rtems/5.1/bin:$PATH" >> /home/$DEFAULT_USER/.bashrc
