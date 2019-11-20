################################################################################
#
# intel_ce_pm
#
################################################################################
INTEL_CE_PM_VERSION = 1.0
INTEL_CE_PM_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
INTEL_CE_PM_SITE_METHOD = file
INTEL_CE_PM_SOURCE = intel_ce_pm.tar.xz

define INTEL_CE_PM_BUILD_CMDS
	echo "No building required."
endef

define INTEL_CE_PM_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
