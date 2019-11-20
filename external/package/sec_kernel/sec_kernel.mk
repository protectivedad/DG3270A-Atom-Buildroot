################################################################################
#
# sec_kernel
#
################################################################################
SEC_KERNEL_VERSION = 1.0
SEC_KERNEL_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
SEC_KERNEL_SITE_METHOD = file
SEC_KERNEL_SOURCE = sec_kernel.tar.xz

define SEC_KERNEL_BUILD_CMDS
	echo "No building required."
endef

define SEC_KERNEL_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
