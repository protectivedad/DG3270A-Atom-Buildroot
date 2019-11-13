################################################################################
#
# gpio
#
################################################################################
GPIO_VERSION = 1.0
GPIO_SITE = $(BR2_EXTERNAL)/sources
GPIO_SITE_METHOD = file
GPIO_SOURCE = gpio.tar.xz

define GPIO_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${GPIO_SOURCE}
endef

define GPIO_BUILD_CMDS
	echo "No building required."
endef

define GPIO_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $$(dirname $$file) ] && mkdir -p $$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
