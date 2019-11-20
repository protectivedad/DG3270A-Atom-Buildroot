################################################################################
#
# twister
#
################################################################################
TWISTER_VERSION = 1.0
TWISTER_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
TWISTER_SITE_METHOD = file
TWISTER_SOURCE = twister.tar.xz

define TWISTER_BUILD_CMDS
	echo "No building required."
endef

define TWISTER_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
