################################################################################
#
# IPROUTE2 Binary Files
#
################################################################################
IPROUTE2_BIN_VERSION = 1.0
IPROUTE2_BIN_SITE = $(BR2_EXTERNAL)/sources
IPROUTE2_BIN_SITE_METHOD = file
IPROUTE2_BIN_SOURCE = iproute2_bin.tar.xz

define IPROUTE2_BIN_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${IPROUTE2_BIN_SOURCE}
endef

define IPROUTE2_BIN_BUILD_CMDS
	echo "No building required."
endef

define IPROUTE2_BIN_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))