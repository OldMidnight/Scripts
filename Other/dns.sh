#!/system/bin/sh
#
# Systemless keweon DNS Manager (Source : Systemless-DNS-Changer-v1.0)
# Thanks to xda, tanu548@xda-developers and to all users who contribute
divider='======================================================' > /dev/null 2>&1
magisk='/sbin/.core/img' > /dev/null 2>&1
core=$magisk'/MidnightCore' > /dev/null 2>&1
dns_stored=$core'/post-fs-data.sh' > /dev/null 2>&1
#
BL='\e[01;90m' > /dev/null 2>&1; # Black
R='\e[01;91m' > /dev/null 2>&1; # Red
G='\e[01;92m' > /dev/null 2>&1; # Green
Y='\e[01;93m' > /dev/null 2>&1; # Yellow
B='\e[01;94m' > /dev/null 2>&1; # Blue
P='\e[01;95m' > /dev/null 2>&1; # Purple
C='\e[01;96m' > /dev/null 2>&1; # Cyan
W='\e[01;97m' > /dev/null 2>&1; # White
N='\e[0m' > /dev/null 2>&1; # Null
#
. /sbin/.core/mirror/bin/util_functions.sh
while :
do
# Magisk partition mounting...
mount_magisk_img
# DNS Remover
DNS_line_remover ( ) {
		sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.76.125.130:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.76.125.130:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.77.62.37:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.77.62.37:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 213.32.112.244:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 213.32.112.244:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 104.207.131.11:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 104.207.131.11:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.77.25.72:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.77.25.72:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.77.138.206:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.77.138.206:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.76.151.221:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.76.151.221:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.32.183.39:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.32.183.39:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.76.57.41:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.76.57.41:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.77.144.132:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.77.144.132:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.32.140.26:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.32.140.26:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 139.59.33.236:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 139.59.33.236:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 208.67.222.222:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 208.67.222.222:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 176.103.130.130:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 176.103.130.130:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 8.8.8.8:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 8.8.8.8:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 1.1.1.1:53/d' $dns_stored
		sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 1.1.1.1:53/d' $dns_stored
}
# DNS checker...
if grep -q 45.76.125.130 $dns_stored > /dev/null 2>&1
then
	current_dns=$G'Keweon Australia/Sydney DNS'$N
elif grep -q 45.77.62.37 $dns_stored > /dev/null 2>&1
then
	current_dns=$G'Keweon France/Paris DNS'$N
elif grep -q 213.32.112.244 $dns_stored > /dev/null 2>&1
then
	current_dns=$G'Keweon France/Roubaix DNS'$N
elif grep -q 104.207.131.11 $dns_stored > /dev/null 2>&1
then
	current_dns=$G'Keweon Germany/FFM DNS'$N
elif grep -q 45.77.25.72 $dns_stored > /dev/null 2>&1
then
	current_dns=$G'Keweon Japan/Tokyo DNS'$N
elif grep -q 45.77.138.206 $dns_stored > /dev/null 2>&1
then
	current_dns=$G'Keweon Netherland/Amsterdam DNS'$N
elif grep -q 45.76.151.221 $dns_stored > /dev/null 2>&1
then
	current_dns=$G'Keweon Singapore/Singapore DNS'$N
elif grep -q 45.32.183.39 $dns_stored > /dev/null 2>&1
then
	current_dns=$G'Keweon UK/London DNS'$N
elif grep -q 45.76.57.41 $dns_stored > /dev/null 2>&1
then
	current_dns=$G'Keweon USA/Dallas DNS'$N
elif grep -q 45.77.144.132 $dns_stored > /dev/null 2>&1
then
	current_dns=$G'Keweon USA/New Jersey DNS'$N
elif grep -q 45.32.140.26 $dns_stored > /dev/null 2>&1
then
	current_dns=$G'Keweon USA/Silicon Valley DNS'$N
elif grep -q 139.59.33.236 $dns_stored > /dev/null 2>&1
then
	current_dns=$G'Keweon India/Bangalore DNS'$N
elif grep -q 208.67.222.222 $dns_stored > /dev/null 2>&1
then
	current_dns=$G'Open DNS'$N
elif grep -q 176.103.130.130 $dns_stored > /dev/null 2>&1
then
	current_dns=$G'Adguard  DNS'$N
elif grep -q 8.8.8.8 $dns_stored > /dev/null 2>&1
then
	current_dns=$G'Google DNS'$N
elif grep -q 1.1.1.1 $dns_stored > /dev/null 2>&1
then
	current_dns=$G'CloudFlare DNS'$N
else
	current_dns=$B'Default'$N
fi
clear
echo -e $Y"$divider"$N
echo -e $G" MidnightDNS: By OldMidnight & Bhaskarjy0ti(@XDA) "$N
echo -e $C"Credits to @Bhaskarjyoti for letting me maintain this!"$N
echo -e $Y"$divider"$N
echo -e $W'CURRENT :'$N $current_dns
echo -e $W'1. Keweon Australia/Sydney DNS'$N
echo -e $W'2. Keweon France/Paris DNS'$N
echo -e $W'3. Keweon France/Roubaix DNS'$N
echo -e $W'4. Keweon Germany/FFM DNS'$N
echo -e $W'5. Keweon Japan/Tokyo DNS'$N
echo -e $W'6. Keweon Netherland/Amsterdam DNS'$N
echo -e $W'7. Keweon Singapore/Singapore DNS'$N
echo -e $W'8. Keweon UK/London DNS'$N
echo -e $W'9. Keweon USA/Dallas DNS'$N
echo -e $W'10.Keweon USA/New Jersey DNS'$N
echo -e $W'11.Keweon USA/Silicon Valley DNS'$N
echo -e $W'12.Keweon India/Bangalore DNS'$N
echo -e $W'13.Open DNS'$N
echo -e $W'14.Adguard DNS'$N
echo -e $W'15.Google DNS'$N
echo -e $W'16.CloudFlare DNS'$N
echo -e $W'17.Restore Default DNS'$N
echo -e $W'0. Exit'$N
echo -e $Y"$divider"$N
echo -e -n $W'[CHOOSE] : '$N
read -r DNS_ADDRESSED
case $DNS_ADDRESSED in
	1)
	clear
		DNS_line_remover
		echo 'iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.76.125.130:53' >> $dns_stored
		echo 'iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.76.125.130:53' >> $dns_stored
	;;
	2)
	clear
		DNS_line_remover
		echo 'iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.77.62.37:53' >> $dns_stored
		echo 'iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.77.62.37:53' >> $dns_stored
	;;
	3)
	clear
		DNS_line_remover
		echo 'iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 213.32.112.244:53' >> $dns_stored
		echo 'iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 213.32.112.244:53' >> $dns_stored
	;;
	4)
	clear
		DNS_line_remover
		echo 'iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 104.207.131.11:53' >> $dns_stored
		echo 'iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 104.207.131.11:53' >> $dns_stored
	;;
	5)
	clear
		DNS_line_remover
		echo 'iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.77.25.72:53' >> $dns_stored
		echo 'iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.77.25.72:53' >> $dns_stored
	;;
	6)
	clear
		DNS_line_remover
		echo 'iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.77.138.206:53' >> $dns_stored
		echo 'iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.77.138.206:53' >> $dns_stored
	;;
	7)
	clear
		DNS_line_remover
		echo 'iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.76.151.221:53' >> $dns_stored
		echo 'iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.76.151.221:53' >> $dns_stored
	;;
	8)
	clear
		DNS_line_remover
		echo 'iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.32.183.39:53' >> $dns_stored
		echo 'iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.32.183.39:53' >> $dns_stored
	;;
	9)
	clear
		DNS_line_remover
		echo 'iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.76.57.41:53' >> $dns_stored
		echo 'iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.76.57.41:53' >> $dns_stored
	;;
	10)
	clear
		DNS_line_remover
		echo 'iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.77.144.132:53' >> $dns_stored
		echo 'iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.77.144.132:53' >> $dns_stored
	;;
	11)
	clear
		cert
		DNS_line_remover
		echo 'iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 45.32.140.26:53' >> $dns_stored
		echo 'iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 45.32.140.26:53' >> $dns_stored
	;;
	12)
	clear
		DNS_line_remover
		echo 'iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 139.59.33.236:53' >> $dns_stored
		echo 'iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 139.59.33.236:53' >> $dns_stored
	;;
	13)
	clear
		DNS_line_remover
		echo 'iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 208.67.222.222:53' >> $dns_stored
		echo 'iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 208.67.222.222:53' >> $dns_stored
	;;
	14)
	clear
		DNS_line_remover
		echo 'iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 176.103.130.130:53' >> $dns_stored
		echo 'iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 176.103.130.130:53' >> $dns_stored
	;;
	15)
	clear
		DNS_line_remover
		echo 'iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 8.8.8.8:53' >> $dns_stored
		echo 'iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 8.8.8.8:53' >> $dns_stored
	;;
	16)
	clear
		DNS_line_remover
		echo 'iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 1.1.1.1:53' >> $dns_stored
		echo 'iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 1.1.1.1:53' >> $dns_stored
	;;
	17)
	clear
		DNS_line_remover
	;;
	0)
	clear
	echo -e $B"$divider"$N
	echo -e $G'           PLEASE REBOOT TO APPLY CHANGES   '$N
	echo -e $B"$divider"$N
	sleep 1
	unmount_magisk_img
	exit 0
	;;
esac
done