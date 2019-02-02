sudo systemctl list units > ~/installed_services.txt
sudo systemctl stop apache2
sudo systemctl disable apache2
sudo systemctl stop gnunet
sudo systemctl disable gnunet
sudo systemctl stop teamviewerd.service
sudo systemctl disable teamviewerd.service
sudo systemctl stop gnunet.service
sudo systemctl disable gnunet.service
sudo systemctl stop mpd.service
sudo systemctl disable mpd.servic
sudo systemctl stop avahi-daemon.service
sudo systemctl disable avahi-daemon.service
sudo systemctl stop bluetooth.service
sudo systemctl disable bluetooth.service
sudo systemctl stop irtt.service
sudo systemctl disable irtt.service
sudo systemctl stop ModemManager.service
sudo systemctl disable ModemManager.service
sudo systemctl stop stunnel4.service
sudo systemctl disable stunnel4.service

# To disable kdeconnect without uninstalling it:
kdeconnect_path="$(ps aux | grep kdeconnect | head -n1 | cut -d" " -f27)"
sudo chmod -x $kdeconnect_path && sudo chattr +i $kdeconnect_path

#Switch grub from graphical to text mode for boot splashs.
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT=""/g' /etc/default/grub
sudo sed -i 's/#GRUB_BADRAM/GRUB_BADRAM/g' /etc/default/grub
sudo update-grub

#Configure the avahi daemon to not listen on network ports:
sudo sed -i 's/use-ipv4=yes/use-ipv4=no/g' /etc/avahi/avahi-daemon.conf
sudo sed -i 's/use-ipv6=yes/use-ipv6=no/g' /etc/avahi/avahi-daemon.conf
#List all network interfaces, then convert the interface names into a comma seperated list.
IfaceList="$(ip addr | grep state | cut -d ":" -f2 | sed -e 's/^[ \t]*//' | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/,/g')"
#Deny Avahi from listening on any interface.
sudo sed -i "s/#deny-interfaces\=eth1/deny-interfaces\=$IfaceList/g" /etc/avahi/avahi-daemon.conf
sudo sed -i 's/enable-wide-area=yes/enable-wide-area=no/g' /etc/avahi/avahi-daemon.conf
