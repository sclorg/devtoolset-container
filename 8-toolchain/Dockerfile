FROM centos/s2i-core-centos7
LABEL MAINTAINER Marek Polacek <polacek@redhat.com>

ENV SUMMARY="Red Hat Developer Toolset 8 Toolchain container image" \
    DESCRIPTION="Platform for building C/C++ applications using Red Hat \
Developer Toolset 8. Red Hat Developer Toolset is a Red Hat \
offering for developers on the Red Hat Enterprise Linux platform. \
It provides a complete set of development and performance analysis tools \
that can be installed and used on multiple versions of Red Hat \
Enterprise Linux. Executables built with the Red Hat Developer Toolset \
toolchain can then also be deployed and run on multiple versions of \
Red Hat Enterprise Linux."

LABEL com.redhat.component="devtoolset-8-toolchain-container" \
      name="centos/devtoolset-8-toolchain-centos7" \
      version="8" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Developer Toolset 8 Toolchain" \
      maintainer="Marek Polacek <polacek@redhat.com>"

RUN yum install -y centos-release-scl-rh && \
    INSTALL_PKGS="devtoolset-8-gcc devtoolset-8-gcc-c++ devtoolset-8-gcc-gfortran devtoolset-8-gdb" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum -y clean all --enablerepo='*'


# Copy extra files to the image.
COPY ./root/ /

ENV HOME=/opt/app-root/src \
    PATH=/opt/app-root/src/bin:/opt/app-root/bin:/opt/rh/devtoolset-8/root/usr/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

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
