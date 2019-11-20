################################################################################
#
# sc_usb_tools
#
################################################################################
SC_USB_TOOLS_VERSION = 1.0
SC_USB_TOOLS_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
SC_USB_TOOLS_SITE_METHOD = file
SC_USB_TOOLS_SOURCE = sc_usb_tools.tar.xz

define SC_USB_TOOLS_BUILD_CMDS
	echo "No building required."
endef

define SC_USB_TOOLS_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
