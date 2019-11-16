################################################################################
#
# arris_clients
#
################################################################################
ARRIS_CLIENTS_VERSION = 1.0
ARRIS_CLIENTS_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
ARRIS_CLIENTS_SITE_METHOD = file
ARRIS_CLIENTS_SOURCE = arris_clients.tar.xz

define ARRIS_CLIENTS_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${ARRIS_CLIENTS_SOURCE}
endef

define ARRIS_CLIENTS_BUILD_CMDS
	echo "No building required."
endef

define ARRIS_CLIENTS_INSTALL_TARGET_CMDS
	cd $(@D); for mode_755 in `find -L . -type f -not -path '*/.*'`; do \
	   if [ ! -L $(@D)/$$mode_755 ]; then \
	      cp -af $(@D)/$$mode_755 $(TARGET_DIR)/$$mode_755; \
	   else \
	      $(INSTALL) -D -m 0755 $(@D)/$$mode_755 $(TARGET_DIR)/$$mode_755; \
	   fi \
	done
endef

$(eval $(generic-package))
