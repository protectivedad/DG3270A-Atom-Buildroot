################################################################################
#
# Intel CE IOSF Module
#
################################################################################
IOSF_VERSION = 1.0
IOSF_SITE = $(BR2_EXTERNAL)/sources
IOSF_SITE_METHOD = file
IOSF_SOURCE = iosf.tar.xz

define IOSF_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${IOSF_SOURCE}
endef

define IOSF_BUILD_CMDS
	echo "No building required."
endef

define IOSF_INSTALL_TARGET_CMDS
	cd $(@D); for file in `find -L . -type f -not -path '*/.*'`; do \
	   [ ! -d $(TARGET_DIR)/$$(dirname $$file) ] && mkdir -p $(TARGET_DIR)/$$(dirname $$file) || true; \
	   cp -af $(@D)/$$file $(TARGET_DIR)/$$file; \
	done
endef

$(eval $(generic-package))
