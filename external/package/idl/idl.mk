################################################################################
#
# IDL
#
################################################################################
IDL_VERSION = 1.0
IDL_SITE = $(BR2_EXTERNAL)/sources
IDL_SITE_METHOD = file
IDL_SOURCE = idl.tar.xz

define IDL_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${IDL_SOURCE}
endef

define IDL_BUILD_CMDS
	echo "No building required."
endef

define IDL_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
