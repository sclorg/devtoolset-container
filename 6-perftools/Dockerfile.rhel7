FROM rhscl/s2i-core-rhel7
LABEL MAINTAINER Red Hat, Inc.

ENV SUMMARY="Red Hat Developer Toolset 6 Performance Tools container image" \
    DESCRIPTION="Performance tools: systemtap, valgrind, dyninst, elfutils, oprofile"

LABEL com.redhat.component="devtoolset-6-perftools-container" \
      name="rhscl/devtoolset-6-perftools-rhel7" \
      version="6" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Developer Toolset 6 Performance Tools" \
      io.k8s.min-memory="2Gi" \
      usage="docker run -ti -v /bin:/host:ro rhscl/devtoolset-6-perftools-rhel7 eu-objdump -d /host/<binary>"

RUN yum install -y yum-utils && \
    yum-config-manager --disable \* &> /dev/null && \
    yum-config-manager --enable rhel-server-rhscl-7-rpms && \
    yum-config-manager --enable rhel-7-server-rpms && \
    yum-config-manager --enable rhel-7-server-optional-rpms && \
    INSTALL_PKGS="devtoolset-6-systemtap devtoolset-6-valgrind devtoolset-6-dyninst devtoolset-6-dyninst-devel devtoolset-6-elfutils devtoolset-6-elfutils-devel devtoolset-6-oprofile devtoolset-6-oprofile-jit devtoolset-6-oprofile-devel" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y

# Copy extra files to the image.
COPY ./root/ /

ENV HOME=/root \
    PATH=/root/bin:/opt/rh/devtoolset-6/root/usr/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

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
