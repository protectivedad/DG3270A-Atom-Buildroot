################################################################################
#
# Intel CE Bootparams Module
#
################################################################################
BOOTPARAMS_VERSION = 1.0
BOOTPARAMS_SITE = $(BR2_EXTERNAL)/sources
BOOTPARAMS_SITE_METHOD = file
BOOTPARAMS_SOURCE = bootparams.tar.xz

define BOOTPARAMS_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${BOOTPARAMS_SOURCE}
endef

define BOOTPARAMS_BUILD_CMDS
	echo "No building required."
endef

define BOOTPARAMS_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
