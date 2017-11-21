FROM centos/s2i-core-centos7
LABEL MAINTAINER Red Hat, Inc.

ENV SUMMARY="Red Hat Developer Toolset 4 Performance Tools container image" \
    DESCRIPTION="Performance tools: systemtap, valgrind, dyninst, elfutils, oprofile"

LABEL com.redhat.component="devtoolset-4-perftools-docker" \
      name="centos/devtoolset-4-perftools-centos7" \
      version="4" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Devtoolset 4 Perftools" \
      io.k8s.min-memory="2Gi" \
      usage="docker run -ti -v /bin:/host:ro centos/devtoolset-4-perftools-centos7 eu-objdump -d /host/<binary>"

RUN yum install -y centos-release-scl-rh && \
    INSTALL_PKGS="devtoolset-4-systemtap devtoolset-4-valgrind devtoolset-4-dyninst devtoolset-4-dyninst-devel devtoolset-4-elfutils devtoolset-4-elfutils-devel devtoolset-4-oprofile devtoolset-4-oprofile-jit devtoolset-4-oprofile-devel" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y

# Copy extra files to the image.
COPY ./root/ /

ENV HOME=/root \
    PATH=/root/bin:/opt/rh/devtoolset-4/root/usr/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN mkdir -p ${HOME} && \
    chmod u+x /usr/bin/usage && \
    rpm-file-permissions

USER 0

WORKDIR ${HOME}

# Enable the SCL for all bash scripts.
ENV BASH_ENV=/root/etc/scl_enable \
    ENV=/root/etc/scl_enable \
    PROMPT_COMMAND=". /root/etc/scl_enable"

# Set the default CMD to print the usage of the perftools image
ENTRYPOINT ["container-entrypoint"]
CMD ["usage"]
