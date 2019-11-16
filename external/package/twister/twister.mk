################################################################################
#
# twister
#
################################################################################
TWISTER_VERSION = 1.0
TWISTER_SITE = $(BR2_EXTERNAL_DEFAULT_PATH)/sources
TWISTER_SITE_METHOD = file
TWISTER_SOURCE = twister.tar.xz

TWISTER_EXECUTABLE_FILES = \
	etc/run_script \
	etc/run_script_ct \
	etc/mdc_start.sh \
	usr/sbin/twister

TWISTER_SUPPORT_FILES = \
	etc/files.tar.gz \
	etc/twisterconfig.json \
	etc/twisterconfig_r.json

define TWISTER_EXTRACT_CMDS
	tar -C $(@D) -xf ${DL_DIR}/${TWISTER_SOURCE}
endef

define TWISTER_BUILD_CMDS
	echo "No building required."
endef

define TWISTER_INSTALL_TARGET_CMDS
	for mode_755 in ${TWISTER_EXECUTABLE_FILES}; do \
	   $(INSTALL) -D -m 0755 $(@D)/$$mode_755 $(TARGET_DIR)/$$mode_755; \
	done
	for mode_644 in ${TWISTER_SUPPORT_FILES}; do \
	   $(INSTALL) -D -m 0644 $(@D)/$$mode_644 $(TARGET_DIR)/$$mode_644; \
	done
endef

$(eval $(generic-package))
