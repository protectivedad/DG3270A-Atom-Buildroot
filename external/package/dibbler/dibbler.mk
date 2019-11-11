################################################################################
#
# dibbler
#
################################################################################
DIBBLER_VERSION = 1.0
DIBBLER_SITE = $(BR2_EXTERNAL)/sources
DIBBLER_SITE_METHOD = file
DIBBLER_SOURCE = dibbler.tar.xz

define DIBBLER_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${DIBBLER_SOURCE}
endef

define DIBBLER_BUILD_CMDS
	echo "No building required."
endef

define DIBBLER_INSTALL_TARGET_CMDS
	cd $(@D); for mode_755 in `find -L . -type f -not -path '*/.*'`; do \
	   if [ ! -L $(@D)/$$mode_755 ]; then \
	      cp -af $(@D)/$$mode_755 $(TARGET_DIR)/$$mode_755; \
	   else \
	      $(INSTALL) -D -m 0755 $(@D)/$$mode_755 $(TARGET_DIR)/$$mode_755; \
	   fi \
	done
endef

$(eval $(generic-package))
