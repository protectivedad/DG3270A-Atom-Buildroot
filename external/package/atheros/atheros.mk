################################################################################
#
# Atheros Wifi
#
################################################################################
ATHEROS_VERSION = 1.0
ATHEROS_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
ATHEROS_SITE_METHOD = file
ATHEROS_SOURCE = atheros.tar.xz

define ATHEROS_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${ATHEROS_SOURCE}
endef

define ATHEROS_BUILD_CMDS
	echo "No building required."
endef

define ATHEROS_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
