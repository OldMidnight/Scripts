#!/system/bin/sh
alias wget="/sbin/.core/busybox/wget"
alias unzip="/sbin/.core/busybox/unzip"
alias awk="/sbin/.core/busybox/awk"

MDIR="/sdcard/MidnightMain/MidnightMedia"
TDIR="$MDIR/tmp_media"
DIR="/sbin/.core/img/MidnightCore/system/media"
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
echo "******** MidnightCore: MidnightMedia********" >> $LOGFILE
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
if [ ! -d "$TDIR" ]
then
	mkdir $TDIR
fi
log_handler "Setting up environment..."
wget -q -O $TDIR/MDONT-MDELETE "https://ncloud.zaclys.com/index.php/s/qU9KDmCjAjeB35e/download"
wget -q -O $TDIR/audio10 "https://ncloud.zaclys.com/index.php/s/DI7zN6jk0f5MWRT/download"
echo "Phase 1 complete..."
wget -q -O $TDIR/MDONT-MDELETE-2 "https://ncloud.zaclys.com/index.php/s/gw69DEq0706VN03/download"
wget -q -O $TDIR/audio20 "https://ncloud.zaclys.com/index.php/s/8vufQf9Wsu7NYaH/download"
if [ $? == 0 ]
then
	log_handler "Necessary files downloaded"
else
	log_handler "Necessary files not downloaded!"
fi
echo "Phase 2 complete..."
echo "done!"
preview () {
	log_handler "Downloading preview animation..."
	wget -O $TDIR/$PRE2.zip "$LINK2"
	if [ $? == 0 ]
	then
		log_handler "Preview zip downloaded"
	else
		log_handler "Preview zip not downloaded!"
	fi
	unzip -o $TDIR/$PRE2.zip 'bootanimation.zip' -d "$TDIR"
	if [ $? == 0 ]
	then
		log_handler "Preview animation unzipped"
	else
		log_handler "Preview animation not unzipped"
	fi
	mount -o rw,remount -t auto /system
	if [ $? == 0 ]
	then
		log_handler "/system mounted as read/write"
	else
		log_handler "/system not mounted"
	fi
	if [ ! -d "$MDIR/tmp" ]
	then
		mkdir $MDIR/tmp
	fi
	mv -f /system/media/bootanimation.zip $MDIR/tmp 2>/sdcard/mm.log
	if [ $? == 0 ]
	then
		log_handler "System bootanimation moved to $MDIR/tmp"
	else
		log_handler "System bootanimation not moved!"
	fi
	cp -f $TDIR/bootanimation.zip /system/media 2>/sdcard/mm.log
	if [ $? == 0 ]
	then
		log_handler "Preview animation copied to /system/media"
	else
		log_handler "Preview animation not copied!"
	fi
	echo "Loading bootanimation..."
	sleep 1
	bootanimation
	if [ $? == 0 ]
	then
		log_handler "Preview animation played"
	else
		log_handler "Preview animation did not play!"
	fi
	sleep 1
	mv -f /system/media/bootanimation.zip $MDIR 2>/sdcard/mm.log
	if [ $? == 0 ]
	then
		log_handler "Preview animation moved back to $MDIR"
	else
		log_handler "Preview animation not copied back!"
	fi
	mv -f $MDIR/tmp/* /system/media 2>/sdcard/mm.log
	if [ $? == 0 ]
	then
		log_handler "System animation restored"
	else
		log_handler "System animation not restored!"
	fi
	rm /sdcard/mm.log
	mount -o ro,remount -t auto /system
	if [ $? == 0 ]
	then
		log_handler "/system remounted as read-only"
	else
		log_handler "/system not remounted!"
	fi
	rm /sdcard/mm.log
}
prev_choice () {
	pvar=0
	while [ $pvar -le 0 ]
	do
		echo "Setting up environment..."
		log_handler "Setting up preview environment..."
		wget -q -O $TDIR/prevs "https://ncloud.zaclys.com/index.php/s/uDvspasiZP0BLgc/download"
		wget -q -O $TDIR/prevs2 "https://ncloud.zaclys.com/index.php/s/cVpMs12WcuDQv8z/download"
		if [ $? == 0 ]
		then
			log_handler "Necessary files downloaded"
		else
			log_handler "Files not downloaded!"
		fi
		cat $TDIR/prevs
		if [ $? == 0 ]
		then
			log_handler "Preview choices displayed"
		else
			log_handler "Preview choices not displayed!"
		fi
		read -r PCHOICE
		case $PCHOICE in
			$PCHOICE)
				LINK2="$( cat $TDIR/prevs2 | xargs | cut -d " " -f $PCHOICE )"
				PRE="$( cat $TDIR/prevs | xargs | cut -d "." -f $PCHOICE)"
				PRE2="$( echo $PRE | cut -d ')' -f 2 | tr -d ' ' )"
				log_handler "Running preview sequence..."
				preview
				echo "Would you like to apply this animation or keep previewing?"
				echo -e "1) "$B"Apply"$N
				echo -e "2) "$B"Keep previewing"$N
				echo -e "3) "$B"Return to menu"$N
				echo -e -n $W'[CHOOSE] : '$N
				read -r CH
				case $CH in
					1)
						log_handler "Option to apply files selected..."
						echo "Applying files..."
						mount_magisk_img
						if [ $? == 0 ]
						then
							log_handler "Mounted magisk img"
						else
							log_handler "Did not mount magisk img!"
						fi
						mv -f $MDIR/bootanimation.zip $DIR
						if [ $? == 0 ]
						then
							log_handler "Selected animation moved to module directory"
						else
							log_handler "bootanimation not moved to module directory!"
						fi
						echo "done!"
						unmount_magisk_img
						if [ $? == 0 ]
						then
							log_handler "Unmounted magisk img"
						else
							log_handler "Did not unmount magisk img!"
						fi
						rm -r $MDIR/tmp
						pvar=$((pvar + 1))
						exit
						;;
					2)
						log_handler "Rerunning previews..."
						clear
						;;
					3)
						log_handler "Returning to menu..."
						clear
						pvar=$((pvar + 1))
						hvar=$((hvar + 1))
						;;
				esac
				;;
		esac
	done
}
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
	# GET THE VARIABLE REQSIZEM
  request_zip_size_check "$MDIR/$MED2.zip"
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
	echo -e $Y"$divider"$B
	echo -e $R"	REBOOT TO APPLY CHANGES!! "$N
	echo -e $Y"$divider"$B
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
	cat $MDIR/tmp_media/MDONT-MDELETE
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
			LINK="$( cat $TDIR/MDONT-MDELETE-2 | xargs | cut -d " " -f $CHOICE )"
			MED="$( cat $TDIR/MDONT-MDELETE | xargs | cut -d "." -f $CHOICE)"
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
sort_duplicates () {
	if [ ! -d $DIR/audio ]
	then
		mkdir $DIR/audio
	fi
	echo "Sorting Duplicate alarm files..."
	if [ ! -d $DIR/audio/alarms ]
	then
		mkdir $DIR/audio/alarms
	fi
	orig_alarms=/system/media/audio/alarms
	for orig_file in $orig_alarms/*
	do
		echo $orig_file >> $DIR/audio/alarms/.replace
	done
	echo "Done!"
	echo "Sorting Duplicate notification files..."
	if [ ! -d $DIR/audio/notifications ]
	then
		mkdir $DIR/audio/notifications
	fi
	orig_notifs=/system/media/audio/notifications
	for orig_file in $orig_notifs/*
	do
		echo $orig_file >> $DIR/audio/notifications/.replace
	done
	echo "Done!"
	echo "Sorting Duplicate ringtone files..."
	if [ ! -d $DIR/audio/ringtones ]
	then
		mkdir $DIR/audio/ringtones
	fi
	orig_rings=/system/media/audio/ringtones
	for orig_file in $orig_rings/*
	do
		echo $orig_file >> $DIR/audio/ringtones/.replace
	done
	echo "Done!"
	echo "Sorting Duplicate UI files..."
	if [ ! -d $DIR/audio/ui ]
	then
		mkdir $DIR/audio/ui
	fi
	orig_ui=/system/media/audio/ui
	for orig_file in $orig_ui/*
	do
		echo $orig_file >> $DIR/audio/ui/.replace
	done
	echo "Done!"
}
sort_zip () {
	if [ "$INPUT" == "b" ]
	then
		cp -f "$TDIR"/bootanimation.zip "$DIR"
		if [ $? == 0 ]
		then
			log_handler "bootanimation copied to module directory"
		else
			log_handler "bootanimation not copied!"
		fi
		chmod 644 $DIR/bootanimation.zip
		if [ $? == 0 ]
		then
			log_handler "bootanimation permissions set"
		else
			log_handler "Permissions not set!"
		fi
	elif [ "$INPUT" == "s" ]
	then
		log_handler "Sorting duplicate audio files..."
		sort_duplicates
		if [ $? == 0 ]
		then
			log_handler "Duplicated files sorted"
		else
			log_handler "Duplicates not sorted!"
		fi
		log_handler "Setting permissions..."
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
			rm $TDIR/bootanimation.zip
		fi
	elif [ "$INPUT" == "m" ]
	then
		if [ -d "$TDIR/audio" ]
		then
			log_handler "Sorting bootanimation amd audio files..."
			cp -f $TDIR/bootanimation.zip $DIR
			chmod 644 $DIR/bootanimation.zip
			if [ $? == 0 ]
			then
				log_handler "Bootanimation copied to module directory and permissions set"
			else
				log_handler "Bootanimation not copied! Permissions not set!"
			fi
			log_handler "Sorting duplicate audio files..."
			sort_duplicates
			if [ $? == 0 ]
			then
				log_handler "Duplicated files sorted"
			else
				log_handler "Duplicates not sorted!"
			fi
			log_handler "Setting permissions..."
			chmod 644 $DIR/bootanimation.zip
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
		elif [ ! -d "$TDIR/audio" ]
		then
			log_handler "Only bootanimation detected..."
			echo "This option only contains a bootanimation folder."
			echo "Would you like to continue anyways?"
			echo "y/n"
			read -r BOTH
			case "$BOTH" in
				y)
					cp -f "$TDIR"/bootanimation.zip "$DIR"
					if [ $? == 0 ]
					then
						log_handler "bootanimation copied to module directory"
					else
						log_handler "bootanimation not copied!"
					fi
					chmod 644 $DIR/bootanimation.zip
					if [ $? == 0 ]
					then
						log_handler "bootanimation permissions set"
					else
						log_handler "Permissions not set!"
					fi
					;;
				n)
					;;
			esac
		elif [ ! -f "$TDIR/bootanimation.zip" ]
		then
			echo "This option only contains an audio folder."
			echo "Would you like to continue anyways?"
			echo "y/n"
			read -r BOTH
			case "$BOTH" in
				y)
					sort_duplicates
					chmod 755 $DIR/audio
					chmod 755 $DIR/audio/*
					chmod 777 $DIR/audio/ui/*
					chmod 777 $DIR/audio/notifications/*
					chmod 777 $DIR/audio/alarms/*
					chmod 777 $DIR/audio/ringtones/*
					;;
				n)
					;;
			esac
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