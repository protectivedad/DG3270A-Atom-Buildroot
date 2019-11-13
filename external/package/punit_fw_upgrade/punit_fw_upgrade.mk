################################################################################
#
# Kernel Module to Upgrade P-Unit Firmware
#
################################################################################
PUNIT_FW_UPGRADE_VERSION = 1.0
PUNIT_FW_UPGRADE_SITE = $(BR2_EXTERNAL)/sources
PUNIT_FW_UPGRADE_SITE_METHOD = file
PUNIT_FW_UPGRADE_SOURCE = bootparams.tar.xz

define PUNIT_FW_UPGRADE_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${PUNIT_FW_UPGRADE_SOURCE}
endef

define PUNIT_FW_UPGRADE_BUILD_CMDS
	echo "No building required."
endef

define PUNIT_FW_UPGRADE_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
