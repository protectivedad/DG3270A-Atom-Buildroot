################################################################################
#
# arris_clients
#
################################################################################
ARRIS_CLIENTS_VERSION = 1.0
ARRIS_CLIENTS_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
ARRIS_CLIENTS_SITE_METHOD = file
ARRIS_CLIENTS_SOURCE = arris_clients.tar.xz

define ARRIS_CLIENTS_BUILD_CMDS
	echo "No building required."
endef

define ARRIS_CLIENTS_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
