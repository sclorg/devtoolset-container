FROM centos:centos7
LABEL MAINTAINER Marek Polacek <polacek@redhat.com>

ENV SUMMARY="Red Hat Developer Toolset 4 Toolchain container image" \
    DESCRIPTION="Platform for building C/C++ applications using Red Hat \
Developer Toolset 4. Red Hat Developer Toolset is a Red Hat \
offering for developers on the Red Hat Enterprise Linux platform. \
It provides a complete set of development and performance analysis tools \
that can be installed and used on multiple versions of Red Hat \
Enterprise Linux. Executables built with the Red Hat Developer Toolset \
toolchain can then also be deployed and run on multiple versions of \
Red Hat Enterprise Linux."

LABEL com.redhat.component="devtoolset-4-toolchain-docker" \
      name="centos/devtoolset-4-toolchain-centos7" \
      version="4" \
      release="1" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Developer Toolset 4 Toolchain"

RUN yum install -y centos-release-scl-rh && \
    INSTALL_PKGS="devtoolset-4-gcc devtoolset-4-gcc-c++ devtoolset-4-gcc-gfortran devtoolset-4-gdb" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y


# Copy extra files to the image.
COPY ./root/ /

ENV HOME=/opt/app-root/src \
    PATH=/opt/app-root/src/bin:/opt/app-root/bin:/opt/rh/devtoolset-4/root/usr/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN mkdir -p ${HOME} && \
    groupadd -r default -f -g 1001 && \
    useradd -u 1001 -r -g default -d ${HOME} -s /sbin/nologin \
    -c "Default Application User" default && \
    chown -R 1001:1001 /opt/app-root && \
    chmod u+x /opt/app-root/bin/usage

USER 1001

WORKDIR ${HOME}

# Use entrypoint so path is correctly adjusted already at the time the command
# is searching, so something like docker run IMG gcc runs binary from SCL.
COPY root/opt/app-root/bin/container-entrypoint /usr/bin/container-entrypoint

# Install the usage script with base image usage informations
COPY root/opt/app-root/bin/usage /usr/local/bin/usage

# Enable the SCL for all bash scripts.
ENV BASH_ENV=/opt/app-root/etc/scl_enable \
    ENV=/opt/app-root/etc/scl_enable \
    PROMPT_COMMAND=". /opt/app-root/etc/scl_enable"

# Set the default CMD to print the usage of the language image
ENTRYPOINT ["container-entrypoint"]
CMD ["usage"]
