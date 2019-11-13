################################################################################
#
# Intel CE Watchdog
#
################################################################################
WDT_VERSION = 1.0
WDT_SITE = $(BR2_EXTERNAL)/sources
WDT_SITE_METHOD = file
WDT_SOURCE = wdt.tar.xz

define WDT_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${WDT_SOURCE}
endef

define WDT_BUILD_CMDS
	echo "No building required."
endef

define WDT_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $$(dirname $$file) ] && mkdir -p $$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
