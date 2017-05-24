FROM centos:centos7
LABEL MAINTAINER Marek Polacek <polacek@redhat.com>

ENV SUMMARY="Red Hat Developer Toolset 6 Toolchain container image" \
    DESCRIPTION="Platform for building C/C++ applications using Red Hat \
Developer Toolset 6. Red Hat Developer Toolset is a Red Hat \
offering for developers on the Red Hat Enterprise Linux platform. \
It provides a complete set of development and performance analysis tools \
that can be installed and used on multiple versions of Red Hat \
Enterprise Linux. Executables built with the Red Hat Developer Toolset \
toolchain can then also be deployed and run on multiple versions of \
Red Hat Enterprise Linux."

LABEL com.redhat.component="devtoolset-6-toolchain-docker" \
      name="centos/devtoolset-6-toolchain-centos7" \
      version="6" \
      release="1" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Developer Toolset 6 Toolchain"

RUN yum install -y centos-release-scl-rh && \
    INSTALL_PKGS="devtoolset-6-gcc devtoolset-6-gcc-c++ devtoolset-6-gcc-gfortran devtoolset-6-gdb" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y

# Copy extra files to the image.
COPY ./root/ /

ENV HOME=/opt/app-root/src \
    PATH=/opt/app-root/src/bin:/opt/app-root/bin:/opt/rh/devtoolset-6/root/usr/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

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

COPY root/opt/app-root/etc/scl_enable /opt/app-root/etc/scl_enable

# Enable the SCL for all bash scripts.
ENV BASH_ENV=/opt/app-root/etc/scl_enable \
    ENV=/opt/app-root/etc/scl_enable \
    PROMPT_COMMAND=". /opt/app-root/etc/scl_enable"

# Set the default CMD to print the usage of the language image
ENTRYPOINT ["container-entrypoint"]
CMD ["usage"]
