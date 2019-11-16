################################################################################
#
# thermal
#
################################################################################
THERMAL_VERSION = 1.0
THERMAL_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
THERMAL_SITE_METHOD = file
THERMAL_SOURCE = thermal.tar.xz

define THERMAL_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${THERMAL_SOURCE}
endef

define THERMAL_BUILD_CMDS
	echo "No building required."
endef

define THERMAL_INSTALL_TARGET_CMDS
	cd $(@D); for mode_755 in `find -L . -type f -not -path '*/.*'`; do \
	   if [ ! -L $(@D)/$$mode_755 ]; then \
	      cp -af $(@D)/$$mode_755 $(TARGET_DIR)/$$mode_755; \
	   else \
	      $(INSTALL) -D -m 0755 $(@D)/$$mode_755 $(TARGET_DIR)/$$mode_755; \
	   fi \
	done
endef

$(eval $(generic-package))
