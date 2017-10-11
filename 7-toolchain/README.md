Toolchain For Building C and C++ Applications Docker Image
==========================================================

Developer Toolchain is part of the Red Hat Software Collections and the Toolchain is a subset of tools usable for building C and C++ applications. Docker container based on Red Hat Software Collection packages is available as rhscl/devtoolset-7-toolchain-rhel7 in registry.access.redhat.com. Docker container based on CentOS packagess is available as centos/devtoolset-7-toolchain-centos7 in the Docker Hub.


Description
-----------
Developer Toolset from Red Hat Software Collections provides various tools for C and C++ developers, so they are able to use the Developer Toolset tools without needing to be running a RHEL host. The Toolchain part of the Developer Toolset contains tools for building such applications (GCC compiler for C and C++, GDB, gfortran compiler, etc.). Perftools part contains then tools for debugging and further analysis of the applications (oprofile, valgrind, systemtap, etc.).


Usage
-----------
Suppose you have a source for a C application in the `/src/app` directory on the host and that we use the RHEL-based variant (Docker image called rhscl/devtoolset-7-toolchain-rhel7). To build such application you can mount the application sources to the container and run appropriate tools interactively:

```
docker run -ti --rm -v /src/app:/opt/app-root/src:z rhscl/devtoolset-7-toolchain-rhel7 bash
bash-4.3$ gcc -o foo -ggdb -g2 foo.c
```

That will compile one file from `/src/app` using GCC from container with options `-ggdb -g2`.

To run `make` non-interactively, run:

```
docker run -ti --rm -v $PWD:/opt/app-root/src:z rhscl/devtoolset-7-toolchain-rhel7 make
```

That will compile the project from current directory using `make` utility.

In both cases above user must ensure that the directory where GCC will write data into is writable for the user used inside the container (by default UID 1001).


Environment variables and volumes
---------------------------------
You can set the following mount points by passing the `-v /host:/container` flag to Docker.

|  Volume mount point      | Description                       |
| :----------------------- | --------------------------------- |
|  `/opt/app-root`         | Directory for application sources |



Missing dependencies
--------------------
It may happen that the program combiled in the container won't have all the dependencies available. In that case, the Developer Toolset Container Image is supposed to be used as a starting point for users, so they do not need to spin their own container from scratch. Creating a new layer on top of the existing container image can be done by writing a new Dockerfile, that will use this image in the FROM clause. For example to install `boost-devel` library as a dependency, create the following Dockerfile:

```
FROM rhscl/devtoolset-7-toolchain-rhel7

USER 0
RUN yum install -y --setopt=tsflags=nodocs boost-devel && yum clean all -y
USER 1001
```

Then, build the Dockerfile like this (you need a subscribed RHEL-7 machine to install additional RPMs into the RHEL-based container image):

```
docker build -t myorg/devtoolset-7-toolchain-rhel7 .
```


Troubleshooting
---------------
The error log or standard log if container is run non-interactively is available in the container log. The log can be examined by running:

    docker logs <container>


See also
--------
Dockerfile and other sources for this container image are available on
https://github.com/sclorg/devtoolset-container.
In that repository, Dockerfile for CentOS is called Dockerfile, Dockerfile
for RHEL is called Dockerfile.rhel7.

