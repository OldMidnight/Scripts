#!/system/bin/sh

#Set up necessary busysbox utils
alias wget="sbin/.core/busybox/wget"
alias rev="sbin/.core/busybox/rev"
alias unzip="sbin/.core/busybox/unzip"
alias awk="sbin/.core/busybox/awk"

#Set Directory variables
DIR="/sbin/.core/img/MidnightCore/system"
MIDFONT="/sdcard/MidnightMain/MidnightFonts"
STOREFONT=$MIDFONT/tmp_fonts
FONTBACK=$MIDFONT/Backup
LOGFILE=/cache/midfonts.log
LASTLOGFILE=/cache/midfonts_last.log
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
log_handler() {
	echo -e "$(date +"%m-%d-%Y %H:%M:%S") - $1" >> $LOGFILE
}

if [ -f "$LOGFILE" ]; then
	mv -f $LOGFILE $LASTLOGFILE
fi
touch $LOGFILE
echo "***************************************************" >> $LOGFILE
echo "******** MidnightCore: MidnightFonts********" >> $LOGFILE
echo "**************** By OldMidnight ***************" >> $LOGFILE
echo "***************************************************" >> $LOGFILE
log_handler "Log start."

#Set up main environment
. /sbin/.core/mirror/bin/util_functions.sh
if [ ! -d "$STOREFONT" ]
then
mkdir $STOREFONT
fi
if [ ! -d "$DIR" ]
then
	mkdir $DIR
fi
if [ ! -d "$FONTBACK" ]
then
	mkdir $FONTBACK
fi
clear
echo "Setting up environment..."
wget -q -O $STOREFONT/DONT-DELETE "https://ncloud.zaclys.com/index.php/s/jWG7VgSePf30Dat/download"
log_handler "Fontslist downloaded"
wget -q -O $STOREFONT/DONT-DELETE-2 "https://ncloud.zaclys.com/index.php/s/HQpbpeNKYp5crlz/download"
log_handler "Linkslist downloaded"

#Main functions
get_font () {
	clear
	echo "Retrieving font..."
	if [ -f "$STOREFONT/$FONT2.zip" ]; then
		chmod 777 $STOREFONT/$FONT2.zip
		echo "completing step 1..."
		log_handler "Font zip permissions set"
	else
		log_handler "Font zip permissions not set!"
	fi
}
zip_sort_no_store () {
	clear
	if [ -d "$STOREFONT/system" ]
	then
		echo "completing step 2..."
		if [ ! -d $DIR/fonts ]
		then
			mkdir $DIR/fonts
			log_handler "Module folder updated"
		else
			log_handler "Module folder not updated!"
		fi
		cp -f $STOREFONT/system/fonts/* $DIR/fonts
		if [ $? == 0 ]
		then
			log_handler "Font files copied to module directory"
		else
			log_handler "Font files not copied!"
		fi
		chmod 644 $DIR/fonts/*
		if [ $? == 0 ]
		then
			log_handler "Fonts permissions set to 644"
		else
			log_handler "Fonts permissions not set!"
		fi
		echo "cleaning up..."
		rm -r "$STOREFONT"
		if [ -f "$MIDFONT/tmp.txt" ]
		then
			rm -r $MIDFONT/tmp.txt
			touch $MIDFONT/tmp.txt
			echo "$FONT" > $MIDFONT/tmp.txt
		else
			touch $MIDFONT/tmp.txt
			echo "$FONT" > $MIDFONT/tmp.txt
		fi
		echo -e $G"Font applied!"$N
		echo -e $Y"$divider"$N
		echo -e $R"Reboot for changes to take effect!!!!"$N
		echo -e $Y"$divider"$N
		unmount_magisk_img
		log_handler "Magisk img unmounted"
		main=$((main + 1))
	else
		echo -e $R"Wrong zip format, please try another font"$N
		log_handler "Font zip not correctly configured. File: $FONT"
		unmount_magisk_img
		log_handler "Magisk img unmounted"
	fi
}
zip_sort_store () {
	clear
	if [ -d $STOREFONT/system ]
	then
		echo "completing step 2..."
		echo "Font being saved to $FONTBACK..."
		log_handler "Saving font to $FONTBACK..."
		if [ ! -d $DIR/fonts ]
		then
			mkdir $DIR/fonts
			log_handler "Module folder updated"
		else
			log_handler "Module folder not updated!"
		fi
		cp -f $STOREFONT/system/fonts/* $DIR/fonts
		if [ $? == 0 ]
		then
			log_handler "Font files copied to module directory"
		else
			log_handler "Font files not copied!"
		fi
		chmod 644 $DIR/fonts/*
		if [ $? == 0 ]
		then
			log_handler "Fonts permissions set to 644"
		else
			log_handler "Fonts permissions not set!"
		fi
		cd $FONTBACK/ || log_handler "Unable to change directory's" && exit
		tar -cf "$FONT2.tar" $DIR/fonts
		if [ $? == 0 ]
		then
			log_handler "Tar file created"
		else
			log_handler "Tar file not created!"
		fi
		cd / || exit
		rm -r $STOREFONT
		echo "Font has been stored Locally"
		if [ -f "$MIDFONT/tmp.txt" ]
		then
			rm -r $MIDFONT/tmp.txt
			touch $MIDFONT/tmp.txt
			echo "$FONT" > $MIDFONT/tmp.txt
		else
			touch $MIDFONT/tmp.txt
			echo "$FONT" > $MIDFONT/tmp.txt
		fi
		echo -e $G"Font applied!"$N
		echo -e $Y"$divider"$N
		echo -e $R"Reboot for changes to take effect!!!!"$N
		echo -e $Y"$divider"$N
		unmount_magisk_img
		log_handler "Magisk img unmounted"
		main=$((main + 1))
	else
		echo -e $R"Wrong zip format, please try another font"$N
		log_handler "Font zip not correctly configured. File: $FONT"
		unmount_magisk_img
		log_handler "Magisk img unmounted"
	fi
}
other_steps () {
	clear
	wget -O $STOREFONT/$FONT2.zip "$LINK"
	if [ $? == 0 ]
		then
			log_handler "Font zip downloaded"
		else
			log_handler "Font zip not downloaded!"
		fi
	get_font
	# GET THE VARIABLE REQSIZEM
  request_zip_size_check "$STOREFONT/$FONT2.zip"
  # THIS FUNCTION WILL MOUNT $IMG TO $MOUNTPATH, AND RESIZE THE IMAGE BASED ON $REQSIZEM
  mount_magisk_img
	if [ $? == 0 ]
		then
			log_handler "Magisk img mounted"
		else
			log_handler "Magisk img not successfully mounted!"
		fi
	unzip $STOREFONT/$FONT2.zip -d "$STOREFONT"
	if [ $? == 0 ]
		then
			log_handler "Font zip unzipped"
		else
			log_handler "Font zip not unzipped!"
		fi
	if [ "$LOCALCHOICE" == "y" ]
	then
		log_handler "Option to store font selected"
		zip_sort_store
		if [ $? == 0 ]
		then
			log_handler "Font successfully stored and applied"
		else
			log_handler "Font not successfully stored and not applied!"
		fi
	else
		log_handler "Font will not be stored..."
		zip_sort_no_store
		if [ $? == 0 ]
		then
			log_handler "Font applied!"
		else
			log_handler "Font not applied!"
		fi
	fi
}

font_steps () {
	echo " "
	echo "Would you like to save this font on your device?"
	echo "All this would do is remove the need for an internet connection"
	echo "when applying this font in the future"
	echo "DISCLAIMER: Space on your device will be used!!"
	echo "(y/n)"
	echo -e -n $W'[CHOOSE] : '$N
	read -r LOCALCHOICE
	case "$LOCALCHOICE" in
		y)
			other_steps
			;;
		n)
			other_steps
			;;
		*)
			echo ""
			echo "Invald Input."
			if [ -d "$STOREFONT" ]
			then
				rm -r "$STOREFONT"
			fi
	esac
}
check_stored () {
	clear
	echo "Checking for locally saved version..."
	log_handler "Looking for locally saved font..."
	if [ -f "$FONTBACK/$FONT2.tar" ]
	then
		log_handler "Font file found in local storage"
  	# THIS FUNCTION WILL MOUNT $IMG TO $MOUNTPATH, AND RESIZE THE IMAGE BASED ON $REQSIZEM
  	mount_magisk_img
		if [ $? == 0 ]
		then
			log_handler "Magisk img mounted"
		else
			log_handler "Magisk img not mounted!"
		fi
		echo "Detected locally saved version!"
		log_handler "Locally saved font found"
		echo "Applying font..."
		cd $FONTBACK
		tar -xf "$FONT2.tar" sbin/.core/img/MidnightCore/system/fonts
		if [ ! -d "/sbin/.core/img/MidnightCore/system/fonts" ]
		then
			mkdir /sbin/.core/img/MidnightCore/system/fonts
		fi
		if [ ! -d $DIR/fonts ]
		then
			mkdir $DIR/fonts
		fi
		cp -f /sbin/.core/img/MidnightCore/system/fonts/* $DIR/fonts
		chmod 644 $DIR/fonts/*
		rm -r $FONTBACK/fonts
		cd /
		if [ -f "$MIDFONT/tmp.txt" ]
		then
			rm -r $MIDFONT/tmp.txt
			touch $MIDFONT/tmp.txt
			echo "$FONT" > $MIDFONT/tmp.txt
		else
			touch $MIDFONT/tmp.txt
			echo "$FONT" > $MIDFONT/tmp.txt
		fi
		rm -r $STOREFONT
		echo -e $G"Font applied!"$N
		echo -e $Y"$divider"$N
		echo -e $R"Reboot for changes to take effect!!!!"$N
		echo -e $Y"$divider"$N
		unmount_magisk_img
		main=$((main + 1))
		exit
	else
		echo "This Font was not found in your local Repo."
		echo "Resuming Process..."
		log_handler "Font not found in local storage..."
		sleep 1
	fi
}

#Start Script
. $MIDFONT/font_functions.sh
log_handler "Removing main script..."
rm -f $MIDFONT/font_functions.sh
if [ $? == 0 ]
		then
			log_handler "File removed"
		else
			log_handler "File not removed!"
		fi
exit