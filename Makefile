.EXPORT_ALL_VARIABLES:

BUILDROOT_VERS := 2015.11.1
BUILDROOT_SRC := buildroot-${BUILDROOT_VERS}.tar.bz2

GLIBC_SRC := glibc

export PROJ_DIR=$(shell pwd)

include definitions

.PHONY: all clean prep

all:
	echo "Run build_image.sh to compile image."

$(PROJ_DL_DIR) $(BR_DIR):
	mkdir -p $@

$(PROJ_DL_DIR)/$(GLIBC_SRC):
	git -b v${BUILDROOT_VERS} clone https://github.com/protectivedad/DG3270A-Atom-Glibc.git ${PROJ_DL_DIR}/glibc

$(PROJ_DL_DIR)/$(BUILDROOT_SRC):
	wget https://buildroot.org/downloads/${BUILDROOT_SRC} -O ${PROJ_DL_DIR}/${BUILDROOT_SRC}
	touch ${PROJ_DL_DIR}/${BUILDROOT_SRC}

$(BR_DIR)/Makefile: $(PROJ_DL_DIR)/$(BUILDROOT_SRC)
	tar -xf ${PROJ_DL_DIR}/${BUILDROOT_SRC} \
	   -C ${BR_DIR} \
	   --strip-components=1 --keep-old-files 2>/dev/null
	touch ${BR_DIR}/Makefile

$(BR_DIR)/.config: $(BR_DIR)/Makefile
	make -C ${BR_DIR} dg3270a_defconfig
	touch ${BR_DIR}/.config

busybox-mergeconfig:
	meld ${BR_DIR}/output/build/busybox-1.24.1/.config ${BR2_EXTERNAL}/package/busybox/busybox.config

prep: $(BR_DIR) $(PROJ_DL_DIR) $(BR_DIR)/.config $(PROJ_DL_DIR)/$(GLIBC_SRC)

clean:
	git clean -dXf .

%:
	cd ${BR_DIR}; make $@

