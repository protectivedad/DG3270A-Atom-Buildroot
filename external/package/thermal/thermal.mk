################################################################################
#
# thermal
#
################################################################################
THERMAL_VERSION = 1.0
THERMAL_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
THERMAL_SITE_METHOD = file
THERMAL_SOURCE = thermal.tar.xz

define THERMAL_BUILD_CMDS
	echo "No building required."
endef

define THERMAL_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
