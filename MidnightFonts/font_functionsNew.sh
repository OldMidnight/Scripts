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
if grep -q 'beta' $DIR/$bin/midnight
then
	FFUNC=/sdcard/'MidnightMain(Beta)'
else
	FFUNC=/sdcard/MidnightMain
fi
clear
if [ -f "$MIDFONT/tmp.txt" ]
then
	CURRENT=$G"$( cat $MIDFONT/tmp.txt | head -n 1 )"$N
else
	CURRENT=$R"Default"$N
fi
main=0
while [ $main -le 0 ]
do
	if grep -q 'beta' $DIR/$bin/midnight
	then
		echo -e $Y"$divider"$N
		echo -e $G"	MidnightFonts(Beta) By OldMidnight	"$N
		echo -e $Y"$divider"$N
		echo ""
		if [ -e "$MIDFONT/tmp.txt" ]
		then
			echo "Currently applied font: "$CURRENT
			echo ""
		fi
		echo "choose from the selection of fonts offered below"
		echo "enter the corresponding number to choose one"
		echo "Enter 'm' to enable "$G"MidnightMake"$N
		echo "Select 'r' to restore the default"
		echo " "
		cat $STOREFONT/DONT-DELETE
		echo " "
		echo "q) to quit"
		echo "m) "$G"MidnightMake"$N
		echo " "
		echo -e -n $W'[CHOOSE] : '$N
		read -r INPUT
		case "$INPUT" in
			"$INPUT")
				if [ "$INPUT" == "q" ]
				then
					if [ -d "$STOREFONT" ]
					then
						rm -r $STOREFONT
					fi
					main=$((main + 1))
				else
					LINK=$( cat $FFUNC/MidnightFonts/tmp_fonts/DONT-DELETE-2 | xargs | tr -s " " | cut -d " " -f $INPUT )
					FONT=$( cat $FFUNC/MidnightFonts/tmp_fonts/DONT-DELETE | xargs | cut -d "." -f $INPUT )
					FONT2=$( echo $FONT | cut -d ')' -f 2 | tr -d ' ' )
					check_stored
					font_steps
				fi
				;;
		esac
########################################
#stable
	else
########################################
		echo -e $Y"$divider"$N
		echo -e $G"	MidnightFonts By OldMidnight	"$N
		echo -e $Y"$divider"$N
		echo ""
		if [ -e "$MIDFONT/tmp.txt" ]
		then
			echo "Currently applied font: "$CURRENT
			echo ""
		fi
		echo "choose from the selection of fonts offered below"
		echo "enter the corresponding number to choose one"
		echo "Enter 'm' to enable "$G"MidnightMake"$N
		echo "Select 'r' to restore the default"
		echo " "
		cat $STOREFONT/DONT-DELETE
		echo " "
		echo "q) to quit"
		echo "m) "$G"MidnightMake"$N
		echo " "
		echo -e -n $W'[CHOOSE] : '$N
		read -r INPUT
		case "$INPUT" in
			"$INPUT")
				if [ "$INPUT" == "q" ]
				then
					if [ -d "$STOREFONT" ]
					then
						rm -r $STOREFONT
					fi
					main=$((main + 1))
				else
					LINK=$( cat $FFUNC/MidnightFonts/tmp_fonts/DONT-DELETE-2 | xargs | tr -s " " | cut -d " " -f $INPUT )
					FONT=$( cat $FFUNC/MidnightFonts/tmp_fonts/DONT-DELETE | xargs | cut -d "." -f $INPUT )
					FONT2=$( echo $FONT | cut -d ')' -f 2 | tr -d ' ' )
					check_stored
					font_steps
				fi
				;;
		esac
	fi
done
log_handler "Font_functions.sh finished running!====================================>"
