################################################################################
#
# System Utilities Module/Library
#
################################################################################
SYSTEM_UTILS_VERSION = 1.0
SYSTEM_UTILS_SITE = $(BR2_EXTERNAL)/sources
SYSTEM_UTILS_SITE_METHOD = file
SYSTEM_UTILS_SOURCE = system_utils.tar.xz

define SYSTEM_UTILS_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${SYSTEM_UTILS_SOURCE}
endef

define SYSTEM_UTILS_BUILD_CMDS
	echo "No building required."
endef

define SYSTEM_UTILS_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
