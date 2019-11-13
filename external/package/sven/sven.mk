################################################################################
#
# System Visible Event Nexus
#
################################################################################
SVEN_VERSION = 1.0
SVEN_SITE = $(BR2_EXTERNAL)/sources
SVEN_SITE_METHOD = file
SVEN_SOURCE = sven.tar.xz

define SVEN_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${SVEN_SOURCE}
endef

define SVEN_BUILD_CMDS
	echo "No building required."
endef

define SVEN_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
