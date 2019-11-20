################################################################################
#
# Intel CE Diagnostic Test Suite
#
################################################################################
DTS_VERSION = 1.0
DTS_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
DTS_SITE_METHOD = file
DTS_SOURCE = dts.tar.xz

define DTS_BUILD_CMDS
	echo "No building required."
endef

define DTS_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
