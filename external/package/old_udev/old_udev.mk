################################################################################
#
# old_udev
#
################################################################################
OLD_UDEV_VERSION = 175
OLD_UDEV_SOURCE = udev-${OLD_UDEV_VERSION}.tar.xz
OLD_UDEV_SITE = http://www.kernel.org/pub/linux/utils/kernel/hotplug

OLD_UDEV_CONF_OPTS = --disable-introspection \
	--disable-keymap \
	--disable-hwdb \
	--disable-gudev \
	--disable-gtk-doc-html

define OLD_UDEV_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/udev/udevd $(TARGET_DIR)/usr/sbin
	$(INSTALL) -D -m 0755 $(@D)/udev/udevadm $(TARGET_DIR)/usr/sbin
endef

$(eval $(autotools-package))

