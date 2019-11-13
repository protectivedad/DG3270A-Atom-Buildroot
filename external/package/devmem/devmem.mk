################################################################################
#
# DEVMEM Device Driver
#
################################################################################
DEVMEM_VERSION = 1.0
DEVMEM_SITE = $(BR2_EXTERNAL)/sources
DEVMEM_SITE_METHOD = file
DEVMEM_SOURCE = devmem.tar.xz

define DEVMEM_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${DEVMEM_SOURCE}
endef

define DEVMEM_BUILD_CMDS
	echo "No building required."
endef

define DEVMEM_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
