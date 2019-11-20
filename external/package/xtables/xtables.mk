################################################################################
#
# xtables
#
################################################################################
XTABLES_VERSION = 1.0
XTABLES_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
XTABLES_SITE_METHOD = file
XTABLES_SOURCE = xtables.tar.xz

define XTABLES_BUILD_CMDS
	echo "No building required."
endef

define XTABLES_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
