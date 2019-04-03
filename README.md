Developer Toolset Docker images
===============================

This repository contains Dockerfiles for Developer Toolset images.
Users can choose between RHEL, Fedora and CentOS based images.

For more information about contributing, see
[the Contribution Guidelines](https://github.com/sclorg/welcome/blob/master/contribution.md).
For more information about concepts used in these docker images, see the
[Landing page](https://github.com/sclorg/welcome).


Versions
---------------
Developer toolset versions and variants currently provided are:
* [Toolchain Container Image from Developer Toolset 7](7-toolchain)
* [Perftools Container Image from Developer Toolset 7](7-perftools)

RHEL versions currently supported are:
* RHEL7

CentOS versions currently supported are:
* CentOS7


Installation
----------------------
Choose either the CentOS7 or RHEL7 based image:

*  **RHEL7 based image**


    These images are available in the [Red Hat Container Catalog](https://access.redhat.com/containers/#/registry.access.redhat.com/rhscl/devtooset-7-toolchain-rhel7).
    To download it run:

    ```
    $ docker pull registry.access.redhat.com/rhscl/devtooset-7-toolchain-rhel7
    ```

    To build a RHEL7 based DevToolset Toolchain image, you need to run Docker build on a properly
    subscribed RHEL machine.

    ```
    $ git clone --recursive https://github.com/sclorg/devtoolset-container.git
    $ cd devtoolset-container
    $ git submodule update --init
    $ make build TARGET=rhel7 VERSIONS=7-toolchain
    ```

*  **CentOS7 based image**

    This image is available on DockerHub. To download it run:

    ```
    $ docker pull centos/devtooset-7-toolchain-centos7
    ```

    To build a CentOS based DevToolset Toolchain image from scratch run:

    ```
    $ git clone --recursive https://github.com/sclorg/devtoolset-container.git
    $ cd devtoolset-container
    $ git submodule update --init
    $ make build TARGET=centos7 VERSIONS=7-toolchain
    ```

For using other versions or variants of DevToolset Toolchain, just replace the `7-toolchain` value by particular version
in the commands above.

**Notice: By omitting the `VERSIONS` parameter, the build/test action will be performed
on all provided versions of DevToolset Toolchain, which must be specified in  `VERSIONS` variable.
This variable must be set to a list with possible versions (subdirectories).**


Usage
---------------------------------

For information about usage of the Toolchain Container Image from Developer Toolset 7,
see [usage documentation](7-toolchain).

For information about usage of the Perftools Container Image from Developer Toolset 7,
see [usage documentation](7-perftools).


Test
---------------------------------

This repository also provides a test framework, which checks basic functionality
of the DevToolset Toolchain image.

Users can choose between testing DevToolset Toolchain based on a RHEL or CentOS image.

*  **RHEL based image**

    To test a RHEL7 based DevToolset Toolchain image, you need to run the test on a properly
    subscribed RHEL machine.

    ```
    $ cd devtoolset-container
    $ git submodule update --init
    $ make test TARGET=rhel7 VERSIONS=7-toolchain
    ```

*  **CentOS based image**

    ```
    $ cd devtoolset-container
    $ git submodule update --init
    $ make test TARGET=centos7 VERSIONS=7-toolchain
    ```

For using other versions of DevToolset Toolchain, just replace the `7-toolchain` value by particular version
in the commands above.

**Notice: By omitting the `VERSIONS` parameter, the build/test action will be performed
on all provided versions of DevToolset Toolchain, which must be specified in  `VERSIONS` variable.
This variable must be set to a list with possible versions (subdirectories).**
