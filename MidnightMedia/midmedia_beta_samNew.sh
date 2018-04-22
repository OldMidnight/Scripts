#!/system/bin/sh
alias wget="/sbin/.core/busybox/wget"
alias unzip="/sbin/.core/busybox/unzip"
alias awk="/sbin/.core/busybox/awk"
alias timeout="/sbin/.core/busybox/timeout"

MDIR="/sdcard/MidnightMain/MidnightMedia"
TDIR=$MDIR/tmp_media
DIR=/sbin/.core/img/MidnightCore/system/media
LOGFILE=/cache/midmedia.log
LASTLOGFILE=/cache/midmedia_last.log
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
echo "******** MidnightCore: MidnightMedia(Samsung)********" >> $LOGFILE
echo "**************** By OldMidnight ***************" >> $LOGFILE
echo "***************************************************" >> $LOGFILE
log_handler "Log start."

. /sbin/.core/mirror/bin/util_functions.sh
if [ ! -d $DIR ]
then
	mount_magisk_img
	if [ $? == 0 ]
	then
		log_handler "Magisk img mounted"
	else
		log_handler "Magisk img not mounted!"
	fi
	cd /sbin/.core/img/MidnightCore/system
	mkdir media
	cd /
	unmount_magisk_img
	if [ $? == 0 ]
	then
		log_handler "Magisk img unmounted"
	else
		log_handler "Magisk img not unmounted!"
	fi
fi
clear
echo "Setting up environment..."
if [ ! -d "$MDIR/tmp_media" ]
then
	mkdir $MDIR/tmp_media
fi
log_handler "Setting up environment..."
wget -q -O $TDIR/MDONT-MDELETE-SAM "https://ncloud.zaclys.com/index.php/s/7RT2rJ7HL5g1YNt/download"
wget -q -O $TDIR/audio10 "https://ncloud.zaclys.com/index.php/s/DI7zN6jk0f5MWRT/download"
echo "Phase 1 complete..."
wget -q -O $TDIR/MDONT-MDELETE-2-SAM "https://ncloud.zaclys.com/index.php/s/aDiWK4VnEpj27EL/download"
wget -q -O $TDIR/audio20 "https://ncloud.zaclys.com/index.php/s/8vufQf9Wsu7NYaH/download"
if [ $? == 0 ]
then
	log_handler "Necessary files downloaded"
else
	log_handler "Necessary files not downloaded!"
fi
echo "Phase 2 complete..."
echo "done!"

dchoice_steps () {
	clear
	echo "Retrieving files..."
	log_handler "Downloading media zip..."
	wget -O $MDIR/$MED2.zip "$LINK"
	if [ $? == 0 ]
	then
		log_handler "Media zip downloaded"
	else
		log_handler "Media zip not downloaded!"
	fi
	echo "Completing step 1..."
  # THIS FUNCTION WILL MOUNT $IMG TO $MOUNTPATH, AND RESIZE THE IMAGE BASED ON $REQSIZEM
  mount_magisk_img
	if [ $? == 0 ]
	then
		log_handler "Magisk img mounted"
	else
		log_handler "Magisk img not mounted!"
	fi
	unzip $MDIR/$MED2.zip -d "$TDIR"
	if [ $? == 0 ]
	then
		log_handler "Media files unzipped"
	else
		log_handler "Media files not unzipped!"
	fi
	echo "Completing step 2..."
	echo "Finalizing..."
	log_handler "Sorting zip files..."
	sort_zip
	echo "Cleaning up..."
	log_handler "Cleaning up files..."
	rm -r $MDIR/$MED2.zip
	rm -r $TDIR
	echo "Done!"
	if [ -f "$MDIR/tmp2.txt" ]
		then
			rm -r $MDIR/tmp2.txt
			touch $MDIR/tmp2.txt
			echo "$MED" > $MDIR/tmp2.txt
		else
			touch $MDIR/tmp2.txt
			echo "$MED" > $MDIR/tmp2.txt
		fi
	echo " "
	echo -e $Y"$divider"$N
	echo -e $R"	REBOOT TO APPLY CHANGES!! "$N
	echo -e $Y"$divider"$N
	unmount_magisk_img
	if [ $? == 0 ]
	then
		log_handler "Magisk img unmounted"
	else
		log_handler "Magisk img not unmounted!"
	fi
	main=$((main + 1))
}

sound_choice () {
	clear
	echo "Please select a device to get these files from"
	echo "Enter a corresponding number: "
	cat $TDIR/audio10
	if [ $? == 0 ]
	then
		log_handler "Audio files list displayed"
	else
		log_handler "Audio files list not displayed!"
	fi
	echo -e -n $W'[CHOOSE] : '$N
	echo " "
	read -r CHOICE
	case "$CHOICE" in
		$CHOICE)
			LINK="$( cat $TDIR/audio20 | xargs | cut -d " " -f $CHOICE )"
			MED="$( cat $TDIR/audio10 | xargs | cut -d "." -f $CHOICE)"
			MED2="$( echo $MED | cut -d ')' -f 2 | tr -d ' ' )"
			if [ "$INPUT" == "b" ]
			then
				dchoice_steps
			elif [ "$INPUT" == "s" ]
			then
				dchoice_steps
			elif [ "$INPUT" == "m" ]
			then
				dchoice_steps
			fi
			;;
	esac
}

device_choice () {
	clear
	echo "Please select a device to get these files from"
	echo "Enter a corresponding number: "
	cat $MDIR/tmp_media/MDONT-MDELETE-SAM
	if [ $? == 0 ]
	then
		log_handler "List of media files displayed"
	else
		log_handler "List of media files not displayed!"
	fi
	echo -e -n $W'[CHOOSE] : '$N
	echo " "
	read -r CHOICE
	case "$CHOICE" in
		$CHOICE)
			LINK="$( cat $TDIR/MDONT-MDELETE-2-SAM | xargs | cut -d " " -f $CHOICE )"
			MED="$( cat $TDIR/MDONT-MDELETE-SAM | xargs | cut -d "." -f $CHOICE)"
			MED2="$( echo $MED | cut -d ')' -f 2 | tr -d ' ' )"
			if [ "$INPUT" == "b" ]
			then
				dchoice_steps
			elif [ "$INPUT" == "s" ]
			then
				dchoice_steps
			elif [ "$INPUT" == "m" ]
			then
				dchoice_steps
			fi
			;;
	esac
}

sort_zip () {
	if [ "$INPUT" == "b" ]
	then
		cp -rf $TDIR/system/media/bootsamsung.qmg $DIR
		cp -rf $TDIR/system/media/bootsamsungloop.qmg $DIR
		cp -rf $TDIR/system/media/shutdown.qmg $DIR 2>/sdcard/mm.log
		if [ $? == 0 ]
		then
			log_handler "bootanimation copied to module directory"
		else
			log_handler "bootanimation not copied!"
		fi
		chmod 644 $DIR/*
		if [ $? == 0 ]
		then
			log_handler "bootanimation permissions set"
		else
			log_handler "Permissions not set!"
		fi
	elif [ "$INPUT" == "s" ]
	then
		log_handler "Sorting duplicate audio files..."
		if [ -d $DIR/audio ]; then
			rm -rf $DIR/audio
		fi
		mkdir $DIR/audio
		cp -r $TDIR/audio $DIR
		touch $DIR/audio/.replace
		if [ $? == 0 ]
		then
			log_handler "Duplicated files sorted"
		else
			log_handler "Duplicates not sorted!"
		fi
		chmod 755 $DIR/audio
		chmod 755 $DIR/audio/*
		chmod 777 $DIR/audio/ui/*
		chmod 777 $DIR/audio/notifications/*
		chmod 777 $DIR/audio/alarms/*
		chmod 777 $DIR/audio/ringtones/*
		if [ $? == 0 ]
		then
			log_handler "Permissions set"
		else
			log_handler "Permissions not set!"
		fi
		if [ -f "$TDIR/bootanimation.zip" ]
		then
			rm -f $TDIR/bootanimation.zip
		fi
		if [ -f $TDIR/system/media/bootsamsung.qmg ] || [ -f $TDIR/system/media/bootsamsungloop.qmg ] || [ -f $TDIR/system/media/shutdown.qmg ]
		then
			rm -f $TDIR/system/media/bootsamsung.qmg 2>/sdcard/mm.log
			rm -f $TDIR/system/media/bootsamsungloop.qmg 2>/sdcard/mm.log
			rm -f $TDIR/system/media/shutdown.qmg 2>/sdcard/mm.log
		fi
	fi
}

. $MDIR/med_functions.sh
log_handler "Removing main script..."
rm -f $MDIR/med_functions.sh
if [ $? == 0 ]
		then
			log_handler "File removed"
		else
			log_handler "File not removed!"
		fi
exit