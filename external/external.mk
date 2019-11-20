include $(sort $(wildcard $(BR2_EXTERNAL_DEFAULT_PATH)/package/*/*.mk))

ifeq ($(BR2_PACKAGE_OPENSSL),y)
ifeq ($(BR2_PACKAGE_OPENSSL_LEGACY),y)
define OPENSSL_LINK_LEGACY
	ln -fsr $(TARGET_DIR)/usr/lib/libssl.so $(TARGET_DIR)/usr/lib/libssl.so.1.0.0
endef
OPENSSL_POST_INSTALL_TARGET_HOOKS += OPENSSL_LINK_LEGACY
endif
endif

ifeq ($(BR2_PACKAGE_HOSTAPD),y)
ifeq ($(BR2_PACKAGE_HOSTAPD_QCA988X),y)
HOSTAPD_CONFIG_SET += \
	CONFIG_DRIVER_ATHEROS \
	NEED_AP_MLME

HOSTAPD_CONFIG_ENABLE += \
	CONFIG_WNM

HOSTAPD_CONFIG_DISABLE += \
	CONFIG_DRIVER_HOSTAP \
	CONFIG_DRIVER_NL80211

ifeq ($(BR2_PACKAGE_HOSTAPD_HIDEDEBUG),y)
HOSTAPD_CONFIG_ENABLE += \
	CONFIG_NO_STDOUT_DEBUG
endif

endif
endif

ifeq ($(BR2_PACKAGE_WPA_SUPPLICANT),y)
ifeq ($(BR2_PACKAGE_WPA_SUPPLICANT_QCA988X),y)

WPA_SUPPLICANT_CONFIG_SET += \
	NEED_AP_MLME

WPA_SUPPLICANT_CONFIG_DISABLE += \
	CONFIG_CTRL_IFACE_DBUS_NEW \
	CONFIG_CTRL_IFACE_DBUS_INTRO

WPA_SUPPLICANT_CONFIG_DISABLE += \
	CONFIG_DRIVER_WIRED

ifeq ($(BR2_PACKAGE_WPA_SUPPLICANT_HIDEDEBUG),y)
WPA_SUPPLICANT_CONFIG_ENABLE += \
	CONFIG_NO_STDOUT_DEBUG
endif

endif
endif

