#!/system/bin/sh
. /sbin/.core/mirror/bin/util_functions.sh
divider='======================================================' > /dev/null 2>&1
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
magisk=/sbin/.core/img
main_start () {
	echo ""
	echo -e $Y"$divider"$N
	echo -e $G"		MidnightCore(Beta): By OldMidnight"$N
	echo -e $Y"$divider"$N
	echo "Choose from one of the below aspects to modify and make your device yours"
	echo "Enter a corresponding number below"
	echo -e $G"1) MidnightFonts"$N
	echo -e $G"2) MidnightMedia"$N
	echo -e $G"3) MidnightMisc"$N
	echo -e $G"4) MidnightDNS"$N
	echo -e $C"r) Restore defaults"$N
	echo -e $R"q) Quit"$N
}
restore () {
	res=0
	while [ $res != 1 ]
	do
		echo "Select a package to restore to your system default"
		echo -e $G"1) MidnightFonts"$N
		echo -e $G"2) MidnightMedia"$N
		echo -e $C"q) Quit"$N
		echo -e -n $W'[CHOOSE] : '$N
		read -r RESTORE
		case $RESTORE in
			1)
				echo "Restoring defaults..."
				mount_magisk_img
				rm -r $magisk/MidnightCore/system/fonts
				unmount_magisk_img
				echo "Defaults restored!"
				res=$((res + 1))
				exit
				;;
			2)
				echo "Restoring defaults..."
				mount_magisk_img
				rm -r $magisk/MidnightCore/system/media
				unmount_magisk_img
				echo "Defaults restored!"
				res=$((res + 1))
				exit
				;;
			q)
				res=$((res + 1))
				exit
				;;
			*)
				echo "Invalid Input."
				clear
				;;
		esac
	done
}