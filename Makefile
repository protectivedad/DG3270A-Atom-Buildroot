.EXPORT_ALL_VARIABLES:

BUILDROOT_VERS := 2016.08.1
BUILDROOT_SRC := buildroot-${BUILDROOT_VERS}.tar.bz2

export PROJ_DIR=$(shell pwd)

include definitions

.PHONY: all clean prep

all:
	echo "Run build_image.sh to compile image."

$(PROJ_DL_DIR) $(BR_DIR):
	mkdir -p $@

$(PROJ_DL_DIR)/$(BUILDROOT_SRC):
	wget https://buildroot.org/downloads/${BUILDROOT_SRC} -O ${PROJ_DL_DIR}/${BUILDROOT_SRC}
	touch ${PROJ_DL_DIR}/${BUILDROOT_SRC}

$(BR_DIR)/Makefile: $(PROJ_DL_DIR)/$(BUILDROOT_SRC)
	(tar -xf ${PROJ_DL_DIR}/${BUILDROOT_SRC} \
	   -C ${BR_DIR} \
	   --strip-components=1 --keep-old-files) 2>/dev/null || true
	for patch in ${BR2_EXTERNAL}/patches/buildroot/*.patch; do \
	   patch -p1 -d ${BR_DIR} <$${patch}; \
	done
	touch ${BR_DIR}/Makefile

$(BR_DIR)/.config: $(BR_DIR)/Makefile
	make -C ${BR_DIR} buildroot_defconfig
	touch ${BR_DIR}/.config

busybox-mergeconfig:
	meld ${BR_DIR}/output/build/busybox-1.25.0/.config ${BR2_EXTERNAL}/configs/busybox_defconfig

prep: $(BR_DIR) $(PROJ_DL_DIR) $(BR_DIR)/.config

saveconfigs:
	cd ${BR_DIR}; make savedefconfig
	make busybox-savedefconfig
	make linux-savedefconfig

busybox-savedefconfig: ${BR_DIR}/output/build/busybox-1.25.0/.config
	cp ${BR_DIR}/output/build/busybox-1.25.0/.config ${BR2_EXTERNAL}/configs/busybox_defconfig

linux-savedefconfig: ${BR_DIR}/output/build/linux-2.6.39/.config
	make -C ${BR_DIR} $@
	cp -a ${BR_DIR}/output/build/linux-2.6.39/.config ${BR2_EXTERNAL}/configs/linux_defconfig

clean:
	git clean -dXf .

%:
	cd ${BR_DIR}; make $@

