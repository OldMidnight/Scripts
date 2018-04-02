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
if [ -f "$MDIR/tmp2.txt" ]
then
	CURRENT="$( cat $MDIR/tmp2.txt | head -n 1 )"
else
	CURRENT="Default"
fi
main=0
while [ $main -le 0 ]
do
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
	echo "p) "$B"Previews"$N
	echo "s) "$B"Sounds (UI, Ringtones etc)"$N
	echo "m) "$B"Both"$N
	echo "q) "$R"Quit"$N
	read -r INPUT
	case "$INPUT" in
		p)
			clear
			echo "Some files available can be previewed here."
			echo "Please select a file you would like to preview: "
			hvar=0
			while [ $hvar -le 0 ]
			do
				prev_choice
			done
			;;
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
			if [ -e "$MDIR/tmp" ]
			then
				rm -r $MDIR/tmp
			fi
			if [ -e "$MDIR/tmp_media" ]
			then
				rm -r $MDIR/tmp_media
			fi
			exit
			;;
		*)
			echo " "
			echo "Invalid Input."
			main=$((main + 1))
			exit
			;;
	esac
done
log_handler "med_functions.sh finished running!====================================>"