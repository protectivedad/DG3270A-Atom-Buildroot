################################################################################
#
# dibbler
#
################################################################################
DIBBLER_VERSION = 1.0
DIBBLER_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
DIBBLER_SITE_METHOD = file
DIBBLER_SOURCE = dibbler.tar.xz

define DIBBLER_BUILD_CMDS
	echo "No building required."
endef

define DIBBLER_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
