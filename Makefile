# Variables are documented in hack/build.sh.
BASE_IMAGE_NAME = devtoolset
VERSIONS = 4-toolchain 4-perftools 6-toolchain 6-perftools
OPENSHIFT_NAMESPACES = 

# Include common Makefile code.
include hack/common.mk
