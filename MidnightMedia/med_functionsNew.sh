#!/system/bin/sh
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
clear
if [ -d /system/xbin ]; then
	bin=xbin
else
	bin=bin
fi
if [ -f "$MDIR/tmp2.txt" ]
then
	CURRENT="$( cat $MDIR/tmp2.txt | head -n 1 )"
else
	CURRENT="Default"
fi
main=0
while [ $main -le 0 ]
do
	if grep -q 'beta' /sbin/.core/img/MidnightCore/system/$bin/midnight
	then
		echo -e $Y"$divider"$N
		echo -e $R"	MidnightMedia(Beta) By OldMidnight	"$N
		echo -e $Y"$divider"$N
		echo " "
		if [ -f "$MDIR/tmp2.txt" ]
		then
			echo "Currently applied file: "$G"$CURRENT"$N
			echo " "
		else
			echo "Currently applied file: "$R"Default"$N
			echo " "
		fi
		echo " "
		echo "Choose what type of media you would like to change."
		echo "If you want to change both boot animation and sounds, type m"
		echo " "
		echo "b) "$B"Bootanimation"$N
		echo "s) "$B"Sounds (UI, Ringtones etc)"$N
		echo "m) "$B"Both"$N
		echo "q) "$R"Quit"$N
		read -r INPUT
		case "$INPUT" in
			b)
				device_choice
				;;
			s)
				sound_choice
				;;
			m)
				device_choice
				;;
			q)
				main=$((main + 1))
				if [ -d "$MDIR/tmp" ]
				then
					rm -r $MDIR/tmp
				fi
				if [ -d "$MDIR/tmp_media" ]
				then
					rm -r $MDIR/tmp_media
				fi
				exit
				;;
			*)
				if [ -d "$MDIR/tmp" ]
				then
					rm -r $MDIR/tmp
					fi
				if [ -d "$MDIR/tmp_media" ]
				then
					rm -r $MDIR/tmp_media
				fi
				echo " "
				echo "Invalid Input."
				main=$((main + 1))
				exit
				;;
		esac
###########
#stable
	else
########
		echo -e $Y"$divider"$N
		echo -e $R"	MidnightMedia By OldMidnight	"$N
		echo -e $Y"$divider"$N
		echo " "
		if [ -f "$MDIR/tmp2.txt" ]
		then
			echo "Currently applied file: "$G"$CURRENT"$N
			echo " "
		else
			echo "Currently applied file: "$R"Default"$N
			echo " "
		fi
		echo " "
		echo "Choose what type of media you would like to change."
		echo "If you want to change both boot animation and sounds, type m"
		echo " "
		echo "b) "$B"Bootanimation"$N
		echo "s) "$B"Sounds (UI, Ringtones etc)"$N
		echo "m) "$B"Both"$N
		echo "q) "$R"Quit"$N
		read -r INPUT
		case "$INPUT" in
			b)
				device_choice
				;;
			s)
				sound_choice
				;;
			m)
				device_choice
				;;
			q)
				main=$((main + 1))
				if [ -d "$MDIR/tmp" ]
				then
					rm -r $MDIR/tmp
				fi
				if [ -d "$MDIR/tmp_media" ]
				then
					rm -r $MDIR/tmp_media
				fi
				exit
				;;
			*)
				if [ -d "$MDIR/tmp" ]
				then
					rm -r $MDIR/tmp
				fi
				if [ -d "$MDIR/tmp_media" ]
				then
					rm -r $MDIR/tmp_media
				fi
				echo " "
				echo "Invalid Input."
				main=$((main + 1))
				exit
				;;
		esac
	fi
done
log_handler "med_functions.sh finished running!====================================>"