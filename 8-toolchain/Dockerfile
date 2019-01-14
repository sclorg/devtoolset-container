FROM centos/s2i-core-centos7
LABEL MAINTAINER Marek Polacek <polacek@redhat.com>

ENV SUMMARY="Red Hat Developer Toolset 7 Toolchain container image" \
    DESCRIPTION="Platform for building C/C++ applications using Red Hat \
Developer Toolset 7. Red Hat Developer Toolset is a Red Hat \
offering for developers on the Red Hat Enterprise Linux platform. \
It provides a complete set of development and performance analysis tools \
that can be installed and used on multiple versions of Red Hat \
Enterprise Linux. Executables built with the Red Hat Developer Toolset \
toolchain can then also be deployed and run on multiple versions of \
Red Hat Enterprise Linux."

LABEL com.redhat.component="devtoolset-7-toolchain-container" \
      name="centos/devtoolset-7-toolchain-centos7" \
      version="7" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Developer Toolset 7 Toolchain" \
      usage="docker run -ti -v /src/app:/opt/app-root/src:z centos/devtoolset-7-toolchain-centos7 bash"

RUN yum install -y centos-release-scl-rh && \
    INSTALL_PKGS="devtoolset-7-gcc devtoolset-7-gcc-c++ devtoolset-7-gcc-gfortran devtoolset-7-gdb" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y

# Copy extra files to the image.
COPY ./root/ /

ENV HOME=/opt/app-root/src \
    PATH=/opt/app-root/src/bin:/opt/app-root/bin:/opt/rh/devtoolset-7/root/usr/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN mkdir -p ${HOME} && \
    groupadd -r default -f -g 1001 && \
    usermod -g default default && \
    chown -R 1001:1001 /opt/app-root /usr/bin/container-entrypoint /usr/bin/usage && \
    chmod u+x /usr/bin/usage && \
    rpm-file-permissions

USER 1001

WORKDIR ${HOME}

# Enable the SCL for all bash scripts.
ENV BASH_ENV=/opt/app-root/etc/scl_enable \
    ENV=/opt/app-root/etc/scl_enable \
    PROMPT_COMMAND=". /opt/app-root/etc/scl_enable"

# Set the default CMD to print the usage of the language image
ENTRYPOINT ["container-entrypoint"]
CMD ["usage"]
