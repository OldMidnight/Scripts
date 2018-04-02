#!/system/bin/sh
alias fstrim="/sbin/.core/busybox/fstrim"
alias timeout="/sbin/.core/busybox/timeout"
MISC="/sdcard/MidnightMain/MidnightMisc"
MISCLOG=$MISC/logs
MISCDUMP=$MISC/dumps
LOGDATE="$( date | cut -d ' ' -f 1,2,3 | tr " " )"
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

if [ ! -d $MISCLOG ]
then
	mkdir $MISCLOG
fi
if [ ! -d $MISCDUMP ]
then
	mkdir $MISCDUMP
fi
clear
echo -e $Y"$divider"$N
echo -e $R"MidnightMisc: By OldMidnight"$N
echo -e $Y"$divider"$N
echo ""
echo "Below is a collection of different Miscellaneous tools and things we all use but either at odd times"
echo "Or are hard to come by, all in a nice convenient place!"
echo "Please enter a Number to select an option"
echo ""
echo -e $B"1) Fstrim"$N
echo -e $B"2) Logcat"$N
echo -e $B"3) Dumpsys"$N
echo -e $C"q) Quit"$N
echo ""
echo -e -n $W'[CHOOSE] : '$N
read -r INPUT
case $INPUT in
	1)
		clear
		echo -e $Y"$divider"$N
		echo "Reduce Lag and improve the performance of your device!"
		echo "(Android 4.3+ natively supports trimming but may not do it as frequently as you may like. This tool allows you to do it manually!)"
		echo "This tool will allow you to trim your /data, /cache and /system partitions"
		echo "Enter any of the following letters in any combination or alone to trim the selected partition/s"
		echo "Example: dcs or cds or sdc = trim all three partitions. cd or ds = trim only 2 specified partitions."
		echo "Example c or d or s = trim specified partition."
		echo -e $Y"$divider"$N
		echo -e $B"d) /data"$N
		echo -e $B"c) /cache"$N
		echo -e $B"s) /system"$N
		echo -e $C"q) Quit"$N
		echo ""
		echo -e -n $W'[CHOOSE] : '$N
		read -r FTRIM
		case "$FTRIM" in
			d)
				echo "Trimming /data..."
				fstrim -v /data
				echo "Done!"
				;;
			c)
				echo "Trimming /cache..."
				fstrim -v /cache
				echo "Done!"
				;;
			s)
				echo "Trimming /system..."
				fstrim -v /system
				echo "Done!"
				;;
			dc|cd)
				echo "Trimming /data and /cache..."
				fstrim -v /data
				fstrim -v /cache
				echo "Done!"
				;;
			ds|sd)
				echo "Trimming /data and /system..."
				fstrim -v /data
				fstrim -v /system
				echo "Done!"
				;;
			cs|sc)
				echo "Trimming /cache and /system..."
				fstrim -v /cacahe
				fstrim -v /system
				echo "Done!"
				;;
			dcs|dsc|cds|csd|sdc|scd)
				echo "Trimming /data, /cache and /system..."
				fstrim -v /data
				fstrim -v /cache
				fstrim -v /system
				echo "Done!"
				;;
			q)
				exit
				;;
			*)
				echo ""
				echo "Invalid Input."
				exit
		esac
		;;
	2)
		clear
		echo "Would you like a full device logcat or a Magisk module Logcat?"
		echo -e $B"1) Full device"$N
		echo -e $B"2) Self specified"$N
		echo -e $C"q) Quit"$N
		echo ""
		echo -e -n $W'[CHOOSE] : '$N
		read -r LOG
		case $LOG in
			1)
				echo "Performing a full device logcat will take a long time"
				echo "Are you sure you want to Continue?"
				echo "y/n"
				echo -e -n $W'[CHOOSE] : '$N
				read -r LOGCHOICE
				if [ "$LOGCHOICE" = y ]
				then
					echo "The logs will actively be written to a file in $MISCLOG"
					echo "Type ctrl+c or wait 20 seconds to exit"
					echo "Wait at least 10 to 20 seconds for the logs to populate"
					echo "Creating logcat..."
					timeout -t 20 logcat > "$MISCLOG"/"DevLog$LOGDATE.log"
					echo "Done!"
					echo "Log saved to $MISCLOG"
					exit
				elif [ "$LOGCHOICE" = n ]
				then
					exit
				fi
				;;
			2)
				clear
				echo "Here you can enter a term and the script will retrieve logs of all entries that contain that term"
				echo "The entered term does not have to be Case sensitive so 'midnight' is the same as 'MidNight'"
				echo "Please enter a term: "
				read -r SELFLOG
				echo ""
				echo "The logs will actively be written to a file in $MISCLOG"
				echo "Type ctrl+c or wait 20 seconds to exit"
				echo "Wait at least 10 to 20 seconds for the logs to populate"
				echo "Retrieving logs..."
				timeout -t 20 logcat | grep -i "$SELFLOG" > "$MISCLOG"/"SpecLog$LOGDATE.log"
				exit
				;;
			q)
				exit
				;;
			*)
				echo ""
				echo "Invalid Input."
				exit
				;;
		esac
		;;
	3)
		clear
		echo -e $Y"$divider"$N
		echo "The dumpsys tool allows you to get 'dumps' of interesting information about your"
		echo "device. This information is useful for debugging and testing purposes."
		echo "I have included certain presets of dumps for you to access for easy access."
		echo "You can also specify something else you want a dump of."
		echo "Type in a number to access that info, or 's' to specify your own."
		echo -e $Y"$divider"$N
		echo -e $B"1) Wifi"$N
		echo -e $B"2) Battery"$N
		echo -e $B"3) CPU Info"$N
		echo -e $B"s) Self Specified"$N
		echo -e $C"q) Quit"$N
		echo -e -n $W'[CHOOSE] : '$N
		read -r DUMP
		case $DUMP in
			1)
				clear
				echo "Obtaining Wifi dump..."
				timeout -t 20 dumpsys wifi > "$MISCDUMP"/"WifiDump$LOGDATE.txt"
				echo "Done!"
				echo "Dump saved to $MISCDUMP"
				exit
				;;
			2)
				clear
				echo "Obtaining Battery dump..."
				timeout -t 20 dumpsys battery > "$MISCDUMP"/"BatteryDump$LOGDATE.txt"
				echo "Done!"
				echo "Dump saved to $MISCDUMP"
				exit
				;;
			3)
				clear
				echo "Obtaining CPU Info dump..."
				timeout -t 20 dumpsys cpuinfo > "$MISCDUMP"/"CPUDump$LOGDATE.txt"
				echo "Done!"
				echo "Dump saved to $MISCDUMP"
				exit
				;;
			s)
				clear
				echo "You can either: "
				echo "1) Enter an option parameter for the the dumpsys"
				echo "2) Enter a word to find related info from the dump"
				echo -e -n $W'[CHOOSE] : '$N
				read -r SSDUMP
				case $SSDUMP in
					1)
						echo "Enter the option: "
						read -r OPTION
						echo "Collecting dump..."
						dumpsys "$OPTION" > "$MISCDUMP"/"$OPTION"Dump"$LOGDATE".txt
						echo "Done!"
						echo "Dump saved to $MISCDUMP"
						exit
						;;
					2)
						echo "Enter keyword: "
						read -r OPTION
						echo "Collecting dump..."
						dumpsys | grep -i "$OPTION" > "$MISCDUMP"/"$OPTION"Dump"$LOGDATE".txt
						echo "Done!"
						echo "Dump saved to $MISCDUMP"
						exit
						;;
					*)
						echo ""
						echo "Invalid Input."
						exit
						;;
				esac
		esac
		;;
	q)
		exit
		;;
esac