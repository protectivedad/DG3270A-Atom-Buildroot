################################################################################
#
# PWM Device Driver
#
################################################################################
PWM_VERSION = 1.0
PWM_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
PWM_SITE_METHOD = file
PWM_SOURCE = pwm.tar.xz

define PWM_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${PWM_SOURCE}
endef

define PWM_BUILD_CMDS
	echo "No building required."
endef

define PWM_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
