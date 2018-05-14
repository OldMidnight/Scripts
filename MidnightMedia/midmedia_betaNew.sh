#!/system/bin/sh

ID='MidnightCore'

alias wget="/sbin/.core/busybox/wget"
alias unzip="/sbin/.core/busybox/unzip"
alias awk="/sbin/.core/busybox/awk"
alias df="/sbin/.core/busybox/df"
alias mount="/sbin/.core/busybox/mount"

MDIR="/sdcard/MidnightMain(Beta)/MidnightMedia"
TDIR="$MDIR/tmp_media"
DIR=/sbin/.core/img/MidnightCore/system/media
LOGFILE=/cache/midmedia.log
LASTLOGFILE=/cache/midmedia_last.log
# Magisk Mod Directory
MOUNTPATH=/magisk
if [ ! -d $MOUNTPATH ]; then
	if [ -d /sbin/.core/img ]; then
		MOUNTPATH=/sbin/.core/img
	fi
fi
MODDIR="$MOUNTPATH/$ID"
if [ ! -d $MODDIR ]; then
	if [ -d /sbin/.core/img/$ID ]; then
		MODDIR=/sbin/.core/img/$ID
	else
		echo "Module not detected!"
		exit 1
	fi
fi

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
echo "******** MidnightCore: MidnightMedia(Beta)********" >> $LOGFILE
echo "**************** By OldMidnight ***************" >> $LOGFILE
echo "***************************************************" >> $LOGFILE
log_handler "Log start."

# Import util_functions.sh
[ -f /data/adb/magisk/util_functions.sh ] && . /data/adb/magisk/util_functions.sh || exit 1

mount -o remount,rw $MOUNTPATH
mount -o rw,remount $MOUNTPATH
mount -o remount,rw /cache
mount -o rw,remount /cache

free_space="$(df -m $MOUNTPATH | tail -n1 | awk '{print $4}')"
total_space="$(df -m $MOUNTPATH | tail -n1 | awk '{print $2}')"

chk_file_size() {
  dir_file=$(echo $1)
  if [ $(du -m $dir_file | awk '{print $1}') -gt $free_space ]; then
    echo " Checking file size"
    echo " - Insufficient $MOUNTPATH space!"
    echo " - Using magisk_merge.img to merge images..."
    merge_img ${dir_file}
  else
    echo " Checking file size - ${W}$(du -m $dir_file | awk '{print $1}')M${N}"
  fi
}

# Merge
merge_img() {
  file_size=$(($(du -m $1 | awk '{print $1}')+2))
  if [ "$(grep_prop minMagisk $MODDIR/module.prop)" -ge "1500" ]; then
    IMG=/data/adb/magisk_merge.img
  else
    IMG=/data/magisk_merge.img
  fi
  install_dir=/dev/tmp/${ID}
  path=/dev/magisk_merge
  tmpmodpath=$path/${ID}
  mkdir -p $install_dir
  reqSizeM=$file_size
  MOUNTPATH=$path
  mount_magisk_img  
  cp -af $MODDIR/. $tmpmodpath
  MODDIR=$tmpmodpath
}


if [ ! -d $DIR ]
then
	cd /sbin/.core/img/MidnightCore/system
	mkdir media
	cd /
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

sort_zip () {
	if [ "$INPUT" == "b" ]
	then
		chk_file_size "$TDIR"/bootanimation.zip
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
		if [ -d $DIR/audio ]; then
			rm -rf $DIR/audio
		fi
		mkdir $DIR/audio
		chk_file_size $TDIR/audio
		cp -r $TDIR/audio $DIR
		touch $DIR/audio/.replace
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
			chk_file_size "$TDIR"/bootanimation.zip
			cp -f $TDIR/bootanimation.zip $DIR
			chmod 644 $DIR/bootanimation.zip
			if [ $? == 0 ]
			then
				log_handler "Bootanimation copied to module directory and permissions set"
			else
				log_handler "Bootanimation not copied! Permissions not set!"
			fi
			log_handler "Sorting duplicate audio files..."
			if [ -d $DIR/audio ]; then
				rm -rf $DIR/audio
			fi
			mkdir $DIR/audio
			chk_file_size $TDIR/audio
			cp -r $TDIR/audio $DIR
			touch $DIR/audio/.replace
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
					chk_file_size "$TDIR"/bootanimation.zip
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
					if [ -d $DIR/audio ]; then
						rm -rf $DIR/audio
					fi
					mkdir $DIR/audio
					chk_file_size $TDIR/audio
					cp -r $TDIR/audio $DIR
					touch $DIR/audio/.replace
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