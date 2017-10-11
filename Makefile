# Variables are documented in common/build.sh.
BASE_IMAGE_NAME = devtoolset
VERSIONS = 4-toolchain 4-perftools 6-toolchain 6-perftools 7-toolchain 7-perftools
OPENSHIFT_NAMESPACES = 

# HACK:  Ensure that 'git pull' for old clones doesn't cause confusion.
# New clones should use '--recursive'.
.PHONY: $(shell test -f common/common.mk || echo >&2 'Please do "git submodule update --init" first.')

include common/common.mk
