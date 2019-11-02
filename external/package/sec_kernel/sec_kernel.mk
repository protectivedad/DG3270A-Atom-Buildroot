################################################################################
#
# sec_kernel
#
################################################################################
SEC_KERNEL_VERSION = 1.0
SEC_KERNEL_SITE = $(BR2_EXTERNAL)/sources
SEC_KERNEL_SITE_METHOD = file
SEC_KERNEL_SOURCE = sec_kernel.tar.xz

define SEC_KERNEL_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${SEC_KERNEL_SOURCE}
endef

define SEC_KERNEL_BUILD_CMDS
	echo "No building required."
endef

define SEC_KERNEL_INSTALL_TARGET_CMDS
	cd $(@D); for mode_755 in `find -L . -type f -not -path '*/.*'`; do \
	   if [ ! -L $(@D)/$$mode_755 ]; then \
	      cp -af $(@D)/$$mode_755 $(TARGET_DIR)/$$mode_755; \
	   else \
	      $(INSTALL) -D -m 0755 $(@D)/$$mode_755 $(TARGET_DIR)/$$mode_755; \
	   fi \
	done
endef

$(eval $(generic-package))
