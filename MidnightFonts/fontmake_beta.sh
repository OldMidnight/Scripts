#!/system/bin/sh
alias wget="/sbin/.core/busybox/wget"
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
MAKEFONT=/sdcard/'MidnightMain(Beta)'/MidnightFonts/MidnightMake
clear
echo "Setting up environment..."
echo "Completing phase 1..."
wget -q -O "$MAKEFONT"/DONT-DELETE "https://ncloud.zaclys.com/index.php/s/jWG7VgSePf30Dat/download"
echo "Completing phase 2..."
wget -q -O "$MAKEFONT"/DONT-DELETE-2 "https://ncloud.zaclys.com/index.php/s/HQpbpeNKYp5crlz/download" 
echo "Done!"
clear
echo ""
echo -e $Y"$divider"$N
echo -e $G"MidnightMake: MidnightFonts Add-On"$N
echo -e $G"By OldMidnight"$N
echo -e $Y"$divider"$N
echo " "
echo "Getting a list of all available fonts..."
echo " "
echo "Fonts"
echo " "
cat "$MAKEFONT"/DONT-DELETE
echo " "
echo -e -n $W'[CHOOSE] : '$N
read -r CHOICE
case "$CHOICE" in
	"$CHOICE")
		LINK="$( cat /sdcard/'MidnightMain(Beta)'/MidnightFonts/MidnightMake/'DONT-DELETE-2' | xargs | cut -d ' ' -f $CHOICE )"
		FONT2="$( cat /sdcard/'MidnightMain(Beta)'/MidnightFonts/MidnightMake/'DONT-DELETE' | xargs | cut -d '.' -f $CHOICE | xargs )"
		FONT=$( echo $FONT2 | cut -d ')' -f 2 | tr -d " "  )
		echo "Downloading Font..."
		wget -q -O "$MAKEFONT"/"$FONT".zip "$LINK"
		echo "zip downloaded and placed in $MAKEFONT!"
		;;
esac