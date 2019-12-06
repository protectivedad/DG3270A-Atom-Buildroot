################################################################################
#
# Arris Event
#
################################################################################
ARRIS_EVENT_VERSION = 1.0
ARRIS_EVENT_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
ARRIS_EVENT_SITE_METHOD = file
ARRIS_EVENT_SOURCE = arris_event.tar.xz

define ARRIS_EVENT_BUILD_CMDS
	echo "No building required."
endef

define ARRIS_EVENT_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
