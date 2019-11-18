.EXPORT_ALL_VARIABLES:

BUILDROOT_VERS := 2017.05.2
BUILDROOT_SRC := buildroot-${BUILDROOT_VERS}.tar.bz2

export PROJ_DIR=$(shell pwd)

include definitions

.PHONY: all clean toolchain nonlto lto

all:
	@echo "Do: make {stage}"
	@echo "  Where stage is either toolchain, nolto or lto."
	@echo "For toolchain './scripts/build toolchain' needs to"
	@echo "be run to complete the stage."

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

busybox-mergeconfig:
	meld ${BR_DIR}/output/build/busybox-1.26.2/.config ${BR2_EXTERNAL}/configs/busybox_defconfig

.toolchain_prep: $(BR_DIR) $(PROJ_DL_DIR) $(PROJ_TC_DIR) $(BR_DIR)/Makefile
	make -C ${BR_DIR} toolchain_defconfig

toolchain: .toolchain_prep
	@echo "$@ has been prepared."
	@echo "Need to manually run './scripts/build_toolchain.sh'"

lto_gcc := ar nm ranlib
# Make sure we are using the non-gcc wrapped ar nm and ranlib
# then do the nonlto defconfig and cleanup everything for fresh
# build this is necessary for removing the buildroot toolchain
# to use it as an external toolchain.
.nonlto_prep:
	for item in $(lto_gcc); do \
		ln -srfn ${PROJ_DIR}/toolchain/usr/bin/i686-buildroot-linux-gnu-$${item} ${PROJ_DIR}/toolchain/usr/bin/i686-linux-$${item}; \
	done
	make -C ${BR_DIR} nonlto_defconfig
	make -C ${BR_DIR} clean

.nonlto: .nonlto_prep
	make -C ${BR_DIR}
	touch $@

nonlto: .nonlto
	@echo "$@ has been built."
	@echo "Build the lto kernel and apps next."

# Make sure we are using the gcc wrapped ar nm and ranlib
# then do the lto defconfig and clean the external toolchain
# to pick up the new optimization flags.
.lto_prep:
	for item in $(lto_gcc); do \
		ln -srfn ${PROJ_DIR}/toolchain/usr/bin/i686-buildroot-linux-gnu-gcc-$${item} ${PROJ_DIR}/toolchain/usr/bin/i686-linux-$${item}; \
	done
	make -C ${BR_DIR} lto_defconfig
	make -C ${BR_DIR} toolchain-external-custom-dirclean

.lto: .lto_prep
	make -C ${BR_DIR}
	touch $@

lto: .lto
	for item in $(lto_gcc); do \
		ln -srfn ${PROJ_DIR}/toolchain/usr/bin/i686-buildroot-linux-gnu-$${item} ${PROJ_DIR}/toolchain/usr/bin/i686-linux-$${item}; \
	done
	@echo "$@ has been built."
	@echo "Image has been built."

saveconfigs:
	cd ${BR_DIR}; make savedefconfig
	make busybox-savedefconfig
	make linux-savedefconfig

busybox-savedefconfig: ${BR_DIR}/output/build/busybox-1.26.2/.config
	cp ${BR_DIR}/output/build/busybox-1.26.2/.config ${BR2_EXTERNAL}/configs/busybox_defconfig

linux-savedefconfig: ${BR_DIR}/output/build/linux-2.6.39/.config
	make -C ${BR_DIR} $@
	cp -a ${BR_DIR}/output/build/linux-2.6.39/.config ${BR2_EXTERNAL}/configs/linux_defconfig

clean:
	for item in $$(cat .gitignore); do \
		git clean -dfX ./$${item}; \
	done

%:
	cd ${BR_DIR}; make $@

