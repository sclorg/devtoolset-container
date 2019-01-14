FROM registry.fedoraproject.org/f27/s2i-core:latest

ENV SUMMARY="Fedora variant of Red Hat Developer Toolset's C/C++ Toolchain from Software Collections" \
    DESCRIPTION="Platform for building C and C++ applications" \
    NAME=toolchain \
    VERSION=1 \
    ARCH=x86_64

LABEL com.redhat.component="$NAME" \
      name="$FGC/$NAME" \
      version="$VERSION" \
      architecture="$ARCH" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Fedora variant of Developer Toolset's C/C++ Toolchain from Software Collections" \
      usage="docker run -ti -v /src/app:/opt/app-root/src:z $FGC/$NAME bash" \
      help="docker run IMAGE cat /help.1 | /usr/bin/groff -t -man -ETascii" \
      maintainer="SoftwareCollections.org <sclorg@redhat.com>"

RUN INSTALL_PKGS="gcc gcc-c++ gcc-gfortran gdb make" && \
    dnf install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    dnf clean all -y

# Copy extra files to the image.
COPY ./root/ /

ENV HOME=/opt/app-root/src \
    PATH=/opt/app-root/src/bin:/opt/app-root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN mkdir -p ${HOME} && \
    groupadd -r default -f -g 1001 && \
    usermod -g default default && \
    chown -R 1001:1001 /opt/app-root /usr/bin/container-entrypoint /usr/bin/usage && \
    chmod u+x /usr/bin/usage && \
    rpm-file-permissions

USER 1001

WORKDIR ${HOME}

# Set the default CMD to print the usage of the language image
ENTRYPOINT ["container-entrypoint"]
CMD ["usage"]
