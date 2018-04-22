#!/system/bin/sh
#
alias touch="/sbin/.core/busybox/touch"
. /sbin/.core/mirror/bin/util_functions.sh
if [ -d /system/xbin ]
then
	bin=xbin
else
	bin=bin
fi
if grep -q 'beta' $core/system/$bin/midnight
then
	mm='MidnightMain(Beta)'
else
	mm=MidnightMain
fi
divider='======================================================' > /dev/null 2>&1
magisk='/sbin/.core/img' > /dev/null 2>&1
core=$magisk'/MidnightCore' > /dev/null 2>&1
dns_stored=$core'/post-fs-data.sh' > /dev/null 2>&1
DNS=/sdcard/$mm/MidnightDNS
DNSLIST=$DNS/DNSList.txt
if [ ! -d $DNS ]
then
	mkdir $DNS
fi
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
set_dns() {
	clear
	echo -e $W'Follow the instructions below'$N
	echo -e $W'You will be prompted to enter 2 DNS addresses.'$N
	echo -e $W'If you only know one, enter the same one twice'$N
	sd=0
	while [ $sd != 1 ]
	do
		echo -e $G'Enter DNS 1:'$N
		read -r DNS_1
		echo -e $G'Enter DNS 2:'$N
		read -r DNS_2
		echo -e $W'You entered:'$N
		echo -e $G"DNS 1: $DNS_1"$N
		echo -e $G"DNS 2: $DNS_2"$N
		echo -e $W'Is this correct?(y/n)'$N
		read -r DCHECK
		case $DCHECK in
			y)
				export $DNS_1
				export $DNS_2
				sd=$((sd + 1))
				;;
			n)
				;;
			*)
				;;
		esac
	done
}
DNS_line_remover ( ) {
	sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination /d' $dns_stored
	sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination /d' $dns_stored
	sed -i "/setprop dhcp.wlan0.dns1 /d" $dns_stored
	sed -i "/setprop dhcp.wlan0.dns2 /d" $dns_stored
	sed -i "/setprop net.eth0.dns1 /d" $dns_stored
	sed -i "/setprop net.eth0.dns2 /d" $dns_stored
	sed -i "/setprop setprop net.dns1 /d" $dns_stored
	sed -i "/setprop setprop net.dns2 /d" $dns_stored
	sed -i "/setprop net.ppp0.dns1 /d" $dns_stored
	sed -i "/setprop net.ppp0.dns2 /d" $dns_stored
	sed -i "/setprop net.rmnet0.dns1 /d" $dns_stored
	sed -i "/setprop net.rmnet0.dns2 /d" $dns_stored
	sed -i "/setprop net.pdpbr1.dns1 /d" $dns_stored
	sed -i "/setprop net.pdpbr1.dns2 /d" $dns_stored
}
DNS_line_adder() {
	echo "setprop dhcp.wlan0.dns1 $DNS_1" >> $dns_stored
	echo "setprop dhcp.wlan0.dns2 $DNS_2" >> $dns_stored
	echo "setprop net.eth0.dns1 $DNS_1" >> $dns_stored
	echo "setprop net.eth0.dns2 $DNS_2" >> $dns_stored
	echo "setprop setprop net.dns1 $DNS_1" >> $dns_stored
	echo "setprop setprop net.dns2 $DNS_2" >> $dns_stored
	echo "setprop net.ppp0.dns1 $DNS_1" >> $dns_stored
	echo "setprop net.ppp0.dns2 $DNS_2" >> $dns_stored
	echo "setprop net.rmnet0.dns1 $DNS_1" >> $dns_stored
	echo "setprop net.rmnet0.dns2 $DNS_2" >> $dns_stored
	echo "setprop net.pdpbr1.dns1 $DNS_1" >> $dns_stored
	echo "setprop net.pdpbr1.dns2 $DNS_2" >> $dns_stored
	echo "iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination $DNS_1:53" >> $dns_stored
	echo "iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination $DNS_2:53" >> $dns_stored
}
apply_dns() {
	DNS_line_remover
	DNS_line_adder
}
save_choice() {
	clear
	echo -e $W'Would you lkke to save this address for later use?(y/n)'$N
	read -r SAVE_CHOICE
	case $SAVE_CHOICE in
		y)
			if [ -f $DNSLIST ]
			then
				if grep -q $DNS_1 $DNSLIST || grep -q $DNS_2 $DNSLIST
				then
					echo -e $C'This DNS is already saved!'$N
				else
					dnsCount="$( cat $DNSLIST | wc -l )"
					newDnsC=$((dnsCount + 1))
					echo -e $G'Please name this DNS:'$N
					read -r dnsname
					echo -e $P'Saving DNS...'$N
					sleep 2
					echo "$newDnsC) $dnsname:$DNS_1:$DNS_2" >> $DNSLIST
					echo -e $G"DNS saved!"$N
				fi
			else
				touch $DNSLIST
				echo -e $G'Please name this DNS:'$N
				read -r dnsname
				echo -e $P'Saving DNS...'$N
				echo "1) $dnsname:$DNS_1:$DNS_2" >> $DNSLIST
				echo -e $G"$dnsname saved!"$N
				sleep 3
			fi
			;;
		n)
			;;
		*)
			;;
	esac
}
checkDNS() {
	if grep -q 'iptables' $dns_stored
	then
		dnName="$( grep tcp $dns_stored | cut -d ' ' -f 13 )"
		dnName2="$( echo $dnName | cut -d ':' -f 1 )"
		if [ -f $DNSLIST ]
		then
			dnName3="$( grep $dnName2 $DNSLIST | cut -d ':' -f 1 )"
			dnName4="$( echo $dnName3 | cut -d ' ' -f 2 )"
			current_dns=$dnName4
		else
			current_dns='Unknown'
		fi
	else
		current_dns='Default'
	fi
}
while true
do
checkDNS
clear
echo -e $Y"$divider"$N
echo -e $G" MidnightDNS: By OldMidnight "$N
echo -e $Y"$divider"$N
echo -e $W'CURRENT :'$N $G"$current_dns"$N
echo -e $B'1. Set DNS address'$N
echo -e $B'2. Choose from list'$N
echo -e $W'3. Restore Default DNS'$N
echo -e $W'0. Exit'$N
echo -e $Y"$divider"$N
echo -e -n $W'[CHOOSE] : '$N
read -r DNS_CHOICE
case $DNS_CHOICE in
	1)
		mount_magisk_img
		set_dns
		apply_dns
		save_choice
		;;
	2)
		if [ ! -e $DNSLIST ]
		then
			echo -e $R'You have no saved DNS addresses. Please save one before using this feature.'$N
		else
			loop="$( cat $DNSLIST | wc -l )"
			var=0
			while [ $var != $loop ]
			do
				var=$((var + 1))
				catdns="$( cat $DNSLIST | xargs | cut -d ' ' -f $var )"
				ds="$( echo $catdns | cut -d ':' -f 1 )"
				echo -e $G"$ds"$N
			done
		fi
		echo -e -n $W'[CHOOSE] : '$N
		read -r OPTION
		case $OPTION in
			$OPTION)
				catdns="$( cat $DNSLIST | xargs | cut -d ' ' -f $OPTION )"
				DNS_1="$( echo $catdns | cut -d ':' -f 2 )"
				DNS_2="$( echo $catdns | cut -d ':' -f 3 )"
				mount_magisk_img
				apply_dns
				;;
		esac
		;;
	3)
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
	exit
	;;
esac
done