FROM centos:centos7
MAINTAINER Red Hat, Inc.

RUN yum install -y centos-release-scl-rh && \
    INSTALL_PKGS="devtoolset-6-systemtap devtoolset-6-valgrind devtoolset-6-dyninst devtoolset-6-dyninst-devel devtoolset-6-elfutils devtoolset-6-elfutils-devel devtoolset-6-oprofile devtoolset-6-oprofile-jit devtoolset-6-oprofile-devel" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y

# Each language image can have 'contrib' a directory with extra files needed to
# run and build the applications.
COPY ./contrib/ /root

ENV HOME=/root \
    PATH=/root/bin:/opt/rh/devtoolset-6/root/usr/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN mkdir -p ${HOME} && \
    chmod u+x /root/bin/usage

USER 0

WORKDIR ${HOME}

COPY contrib/etc/scl_enable /root/etc/scl_enable

# Enable the SCL for all bash scripts.
ENV BASH_ENV=/root/etc/scl_enable \
    ENV=/root/etc/scl_enable \
    PROMPT_COMMAND=". /root/etc/scl_enable"

# Set the default CMD to print the usage of the perftools image
ENTRYPOINT ["container-entrypoint"]
CMD ["usage"]
