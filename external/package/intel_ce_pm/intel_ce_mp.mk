################################################################################
#
# intel_ce_pm
#
################################################################################
INTEL_CE_PM_VERSION = 1.0
INTEL_CE_PM_SITE = $(BR2_EXTERNAL)/sources
INTEL_CE_PM_SITE_METHOD = file
INTEL_CE_PM_SOURCE = intel_ce_pm.tar.xz

define INTEL_CE_PM_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${INTEL_CE_PM_SOURCE}
endef

define INTEL_CE_PM_BUILD_CMDS
	echo "No building required."
endef

define INTEL_CE_PM_INSTALL_TARGET_CMDS
	cd $(@D); for mode_755 in `find -L . -type f -not -path '*/.*'`; do \
	   if [ ! -L $(@D)/$$mode_755 ]; then \
	      cp -af $(@D)/$$mode_755 $(TARGET_DIR)/$$mode_755; \
	   else \
	      $(INSTALL) -D -m 0755 $(@D)/$$mode_755 $(TARGET_DIR)/$$mode_755; \
	   fi \
	done
endef

$(eval $(generic-package))
