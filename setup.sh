#!/bin/bash

sudo nano /etc/motd
sudo tee -a /etc/motd <<EOT
           ,   ,
         ,-`{-`/
      ,-~ , \ {-~~-,
    ,~  ,   ,`,-~~-,`,
  ,`   ,   { {      } }                                             }/
 ;     ,--/`\ \    / /                                     }/      /,/
;  ,-./      \ \  { {  (                                  /,;    ,/ ,/
; /   `       } } `, `-`-.___                            / `,  ,/  `,/
 \|         ,`,`    `~.___,---}                         / ,`,,/  ,`,;
  `        { {                                     __  /  ,`/   ,`,;
        /   \ \                                 _,`, `{  `,{   `,`;`
       {     } }       /~\         .-:::-.     (--,   ;\ `,}  `,`;
       \\._./ /      /` , \      ,:::::::::,     `~;   \},/  `,`;     ,-=-
        `-..-`      /. `  .\_   ;:::::::::::;  __,{     `/  `,`;     {
                   / , ~ . ^ `~`\:::::::::::<<~>-,,`,    `-,  ``,_    }
                /~~ . `  . ~  , .`~~\:::::::;    _-~  ;__,        `,-`
       /`\    /~,  . ~ , '  `  ,  .` \::::;`   <<<~```   ``-,,__   ;
      /` .`\ /` .  ^  ,  ~  ,  . ` . ~\~                       \\, `,__
     / ` , ,`\.  ` ~  ,  ^ ,  `  ~ . . ``~~~`,                   `-`--, \
    / , ~ . ~ \ , ` .  ^  `  , . ^   .   , ` .`-,___,---,__            ``
  /` ` . ~ . ` `\ `  ~  ,  .  ,  `  ,  . ~  ^  ,  .  ~  , .`~---,___
/` . `  ,  . ~ , \  `  ~  ,  .  ^  ,  ~  .  `  ,  ~  .  ^  ,  ~  .  `-,
EOT

sudo systemctl enable ssh
sudo systemctl start ssh
sudo timedatectl set-ntp true

sudo echo “FallbackNTP=time.nist.gov” | sudo tee -a /etc/systemd/timesyncd.conf 
sudo systemctl restart systemd-timesyncd

sudo apt update

sudo systemctl set-default multi-user.target

sudo echo "autologin-user = kali" | sudo tee -a /etc/lightdm/lightdm.conf
sudo echo "autologin-user-timeout = 0" | sudo tee -a /etc/lightdm/lightdm.conf

sudo apt-get -y install hostapd dnsmasq

sudo echo "denyinterfaces wlan0" | sudo tee -a /etc/dhcpcd.conf
sudo echo "source-directory /etc/network/interfaces.d" | sudo tee -a /etc/network/interfaces
sudo echo "auto lo" | sudo tee -a /etc/network/interfaces
sudo echo "iface lo inet loopback" /etc/network/interfaces
sudo echo "hostapd /etc/hostapd/hostapd.conf" | sudo tee -a /etc/network/interfaces
sudo echo "auto eth0" | sudo tee -a /etc/network/interfaces
sudo echo "iface eth0 inet dhcp" | sudo tee -a /etc/network/interfaces
sudo echo "iface eth0 inet dhcp" | sudo tee -a /etc/network/interfaces
sudo echo "auto wlan0" | sudo tee -a /etc/network/interfaces
sudo echo "allow-hotplug wlan0" | sudo tee -a /etc/network/interfaces
sudo echo "iface wlan0 inet static" | sudo tee -a /etc/network/interfaces
sudo echo "address 192.168.5.1" | sudo tee -a /etc/network/interfaces
sudo echo "netmask 255.255.255.0" | sudo tee -a /etc/network/interfaces
sudo echo "network 192.168.5.0" | sudo tee -a /etc/network/interfaces
sudo echo "broadcast 192.168.5.255" | sudo tee -a /etc/network/interfaces

sudo echo "# Wifi interface and driver to be used" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "interface=wlan0" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "driver=nl80211" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "# WiFi settings" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "hw_mode=g" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "channel=6" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "ieee80211n=1" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "wmm_enabled=1" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "macaddr_acl=0" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "ignore_broadcast_ssid=0" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "# Use WPA authentication and a pre-shared key" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "auth_algs=1" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "wpa=2" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "wpa_key_mgmt=WPA-PSK" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "rsn_pairwise=CCMP" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "# Network Name" | sudo tee -a /etc/hostapd/hostapd.conf
#set ssid on line below
sudo echo "ssid=Skynet" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "# Network password" | sudo tee -a /etc/hostapd/hostapd.conf
#set ssid on line below
sudo echo "wpa_passphrase=password" | sudo tee -a /etc/hostapd/hostapd.conf
sudo echo "rsn_pairwise=CCMP" | sudo tee -a /etc/hostapd/hostapd.conf

sudo echo 'DAEMON_CONF="/etc/hostapd/hostapd.conf"' | sudo tee -a /etc/default/hostapd

sudo echo "interface=wlan0" | sudo tee -a /etc/dnsmasq.conf
sudo echo "listen-address=192.168.5.1" | sudo tee -a /etc/dnsmasq.conf
sudo echo "bind-interfaces" | sudo tee -a /etc/dnsmasq.conf
sudo echo "server=8.8.8.8" | sudo tee -a /etc/dnsmasq.conf
sudo echo "domain-needed" | sudo tee -a /etc/dnsmasq.conf
sudo echo "bogus-priv" | sudo tee -a /etc/dnsmasq.conf
sudo echo "dhcp-range=192.168.5.100,192.168.5.200,24h" | sudo tee -a /etc/dnsmasq.conf

sudo systemctl unmask hostapd
sudo systemctl enable hostapd               
sudo systemctl start hostapd
sudo dnsmasq --test -C /etc/dnsmasq.conf 
sudo systemctl enable dnsmasq 
sudo systemctl restart dnsmasq

sudo echo "sudo iptables -t nat -A POSTROUTING -o wlan1 -j MASQUERADE" | sudo tee -a /etc/sysctl.conf
sudo echo "sudo iptables -A FORWARD -i wlan1 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT" | sudo tee -a /etc/sysctl.conf
sudo echo "sudo iptables -A FORWARD -i wlan0 -o wlan1 -j ACCEPT" | sudo tee -a /etc/sysctl.conf

sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"

sudo echo "[Unit]" | sudo tee -a /etc/systemd/system/iptables.service
sudo echo "Description= iptables" | sudo tee -a /etc/systemd/system/iptables.service
sudo echo "[Service]" | sudo tee -a /etc/systemd/system/iptables.service
sudo echo "ExecStart=/bin/bash /usr/sbin/iptables.sh  #in this line specify the path to the script." | sudo tee -a /etc/systemd/system/iptables.service
sudo echo "[Install]" | sudo tee -a /etc/systemd/system/iptables.service
sudo echo "WantedBy=multi-user.target" | sudo tee -a /etc/systemd/system/iptables.service

sudo systemctl enable iptables
sudo systemctl start iptables
