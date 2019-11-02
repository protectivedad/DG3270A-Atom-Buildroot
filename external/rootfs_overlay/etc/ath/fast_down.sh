cat /proc/uptime
# ARRIS MOD - START -9 (it's faster), + properly clean up.
killall -9 hostapd
killall -9 lbd
rm /var/run/hostapd/*
rm /var/run/.lbd
# ARRIS MOD - END
res=0
while [ "$res" == "0" ]; do
ps > /tmp/res
cat /tmp/res | grep hostapd > /dev/null
res=$?
usleep 100
done
# ARRIS ADD - START - need to flush UDMA before destroying VAPs
VAPID=0
while [ "${VAPID}" -lt "16" ]; do
    ifconfig ath${VAPID} down
    let VAPID=VAPID+1
done
# ARRIS ADD - END
VAPID=0
while [ "${VAPID}" != "16" ];
do
   wlanconfig ath${VAPID} destroy
   let VAPID=VAPID+1
done
rmmod wlan_scan_ap
rmmod wlan_scan_sta
rmmod ath_pktlog
rmmod wlan_me
rmmod umac
rmmod ath_dev
rmmod hst_tx99
rmmod ath_dfs
rmmod ath_spectral
rmmod ath_rate_atheros
rmmod ath_hal
rmmod asf
rmmod adf
rmmod acfg_mod
airtime cleanup
cat /proc/uptime  
