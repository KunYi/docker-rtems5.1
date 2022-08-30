docker-rtems
===

using docker for development RTEMS Embedded RTOS 5.1

### prepare
#### install docker engine
need install Docker Engine first, check [this article](https://docs.docker.com/engine/install/ubuntu/) if on Ubuntu platform.

#### configuration for none-root user
and check [this article](https://docs.docker.com/engine/install/linux-postinstall/) for non-root user

#### build docker image
```
$ git clone https://github.com/KunYi/docker-rtems5.1.git  # clone this repository to local
$ cd docker-rtems

# if your want base Ubuntu 22.04, run the below command
$ docker build --build-arg DEFAULT_USER=${USER} -t rtems/ubuntu:latest .

# or base Ubuntu 20.04
$ docker build --build-arg DEFAULT_USER=${USER} -t rtems/ubuntu -f Dockerfile.focal .
```

### launch docker for development
```
$ ./entrycontainer
```

### setup RTEMS tools, just run once
in container
./rtems5_install.sh
