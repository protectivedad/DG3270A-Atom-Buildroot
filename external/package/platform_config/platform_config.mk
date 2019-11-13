################################################################################
#
# Platform Configuration Device Driver
#
################################################################################
PLATFORM_CONFIG_VERSION = 1.0
PLATFORM_CONFIG_SITE = $(BR2_EXTERNAL)/sources
PLATFORM_CONFIG_SITE_METHOD = file
PLATFORM_CONFIG_SOURCE = platform_config.tar.xz

define PLATFORM_CONFIG_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${PLATFORM_CONFIG_SOURCE}
endef

define PLATFORM_CONFIG_BUILD_CMDS
	echo "No building required."
endef

define PLATFORM_CONFIG_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
