# Variables are documented in hack/build.sh.
BASE_IMAGE_NAME = devtoolset
VERSIONS = 4-toolchain 4-perftools
OPENSHIFT_NAMESPACES = 

# Include common Makefile code.
include hack/common.mk
