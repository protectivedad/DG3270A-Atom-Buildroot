################################################################################
#
# xtables
#
################################################################################
XTABLES_VERSION = 1.0
XTABLES_SITE = $(BR2_EXTERNAL)/sources
XTABLES_SITE_METHOD = file
XTABLES_SOURCE = xtables.tar.xz

define XTABLES_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${XTABLES_SOURCE}
endef

define XTABLES_BUILD_CMDS
	echo "No building required."
endef

define XTABLES_INSTALL_TARGET_CMDS
	cd $(@D); for mode_755 in `find -L . -type f -not -path '*/.*'`; do \
	   if [ ! -L $(@D)/$$mode_755 ]; then \
	      cp -af $(@D)/$$mode_755 $(TARGET_DIR)/$$mode_755; \
	   else \
	      $(INSTALL) -D -m 0755 $(@D)/$$mode_755 $(TARGET_DIR)/$$mode_755; \
	   fi \
	done
endef

$(eval $(generic-package))
