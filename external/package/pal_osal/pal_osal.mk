################################################################################
#
# pal_osal
#
################################################################################
PAL_OSAL_VERSION = 1.0
PAL_OSAL_SITE = $(BR2_EXTERNAL)/sources
PAL_OSAL_SITE_METHOD = file
PAL_OSAL_SOURCE = pal_osal.tar.xz

define PAL_OSAL_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${PAL_OSAL_SOURCE}
endef

define PAL_OSAL_BUILD_CMDS
	echo "No building required."
endef

define PAL_OSAL_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
