################################################################################
#
# sc_usb_tools
#
################################################################################
SC_USB_TOOLS_VERSION = 1.0
SC_USB_TOOLS_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
SC_USB_TOOLS_SITE_METHOD = file
SC_USB_TOOLS_SOURCE = sc_usb_tools.tar.xz

define SC_USB_TOOLS_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${SC_USB_TOOLS_SOURCE}
endef

define SC_USB_TOOLS_BUILD_CMDS
	echo "No building required."
endef

define SC_USB_TOOLS_INSTALL_TARGET_CMDS
	cd $(@D); for mode_755 in `find -L . -type f -not -path '*/.*'`; do \
	   if [ ! -L $(@D)/$$mode_755 ]; then \
	      cp -af $(@D)/$$mode_755 $(TARGET_DIR)/$$mode_755; \
	   else \
	      $(INSTALL) -D -m 0755 $(@D)/$$mode_755 $(TARGET_DIR)/$$mode_755; \
	   fi \
	done
endef

$(eval $(generic-package))
