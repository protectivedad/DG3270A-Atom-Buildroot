################################################################################
#
# Arris HNC
#
################################################################################
HNC_VERSION = 1.0
HNC_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
HNC_SITE_METHOD = file
HNC_SOURCE = hnc.tar.xz

define HNC_BUILD_CMDS
	echo "No building required."
endef

define HNC_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
