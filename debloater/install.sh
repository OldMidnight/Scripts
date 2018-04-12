. $INSTALLER/common/unityfiles/util_functions.sh
if [ $update_status -eq 1 ]; then
  return 0
fi
#=========================== Determine if A/B OTA device
if [ -d /system_root ]; then
  isABDevice=true
  SYSTEM=/system_root/system
  SYSTEM2=/system
else
  isABDevice=false
  SYSTEM=/system
  SYSTEM2=/system
fi

chmod 755 $INSTALLER/common/aapt

list_system_app() {
  system_app="$( ls $SYSTEM/app )"
  for i in $system_app
  do
    app=$SYSTEM2/app/$i
    name=$i
    applist=$( $INSTALLER/common/aapt dump badging $app/$name.apk | grep 'application:' | cut -d "'" -f 2 | sed s/' '/'_'/g )
    app_label=$( $INSTALLER/common/aapt dump badging $app/$name.apk | grep 'package:' | cut -d "'" -f 2 )
    for aapp in $applist
    do
      if [ $aapp != '' ]
      then
        CHOICE=false
        check_key_status
        ui_print " "
        ui_print "$aapp"
        ui_print "Volume Up to UNINSTALL"
        ui_print "Volume Down to SKIP"
        if $FUNCTION; then
          CHOICE=false
        else
          CHOICE=true
        fi
        if $CHOICE; then
	        ui_print "- Skipped."
        else
          ui_print ""
          echo "Uninstalling $aapp"
          sleep 1
          mktouch $INSTALLER/custom/app/$aapp/.replace $aapp
          cp_ch $INSTALLER/custom/app/$aapp/.replace $UNITY/system/app/$aapp/.replace
          if [ "$app_label" ]; then
            find /data/app | grep -q $app_label
            if [ $? -eq 0 ]
            then
              CHOICE=false
              check_key_status
              ui_print " "
              ui_print "- APK stored in /data, delete? "
              ui_print "- Volume Up: DELETE"
              ui_print "- Volume Down: DON'T DELETE"
              if $FUNCTION; then
                CHOICE=false
              else
                CHOICE=true
              fi
              if $CHOICE; then
                ui_print "Done!"
              else
                data_apk=$( grep $app_label )
                rm -rf $data_apk
              fi
            fi
          else
            ui_print "done!"
          fi
        fi
      fi
    done
  done
}

list_system_priv_app() {
  system_privapp="$( ls $SYSTEM/priv-app )"
  for i in $system_privapp
  do
    app=$SYSTEM2/priv-app/$i
    name=$i
    applist=$( $INSTALLER/common/aapt dump badging $app/$name.apk | grep 'application:' | cut -d "'" -f 2 | sed s/' '/'_'/g )
    app_label=$( $INSTALLER/common/aapt dump badging $app/$name.apk | grep 'package:' | cut -d "'" -f 2 )
    for papp in $plist
    do
      if [ $papp != '' ]
      then
        CHOICE=false
        check_key_status
        ui_print " "
        ui_print "$papp"
        ui_print "Volume Up to UNINSTALL"
        ui_print "Volume Down to SKIP"
        if $FUNCTION; then
          CHOICE=false
        else
          CHOICE=true
        fi
        if $CHOICE; then
	        ui_print "- Skipped."
        else
          ui_print ""
          echo "Uninstalling $papp"
          sleep 1
          mktouch $INSTALLER/system/priv-app/$papp/.replace $papp
          if [ "$app_label" ]; then
            find /data/app | grep -q $app_label
            if [ $? -eq 0 ]
            then
              CHOICE=false
              check_key_status
              ui_print " "
              ui_print "- APK stored in /data, delete? "
              ui_print "- Volume Up: DELETE"
              ui_print "- Volume Down: DON'T DELETE"
              if $FUNCTION; then
                CHOICE=false
              else
                CHOICE=true
              fi
              if $CHOICE; then
                ui_print "Done!"
              else
                data_apk=$( grep $app_label )
                rm -rf $data_apk
              fi
            fi
          else
            ui_print "done!"
          fi
        fi
      fi
    done
  done
}

reinstall_app() {
  ui_print "- Retrieving list of de-bloated apps..."
  if [ -d /sbin/.core/img/$MODID/system/app ]; then
    ui_print "-System Apps-"
    sysapp_deb=$( ls /sbin/.core/img/$MODID/system/app )
    for mod_app in $sysapp_deb
    do
      CHOICE=false
      check_key_status
      ui_print " "
      ui_print "$mod_app"
      ui_print "Volume Up to REINSTALL"
      ui_print "Volume Down to SKIP"
      if $FUNCTION; then
        CHOICE=false
      else
        CHOICE=true
      fi
      if $CHOICE; then
        ui_print "- Skipped!"
      else
        ui_print "- Reinstalling $mod_app..."
        rm -rf /sbin/.core/img/$MODID/system/app/$mod_app
        ui_print "- Done!"
      fi
    done
  fi
  if [ -d /sbin/.core/img/$MODID/system/priv-app ]; then
    ui_print "-System priv-apps-"
    sysapp_deb=$( ls /sbin/.core/img/$MODID/system/priv-app )
    for mod_papp in $sysapp_deb
    do
      CHOICE=false
      check_key_status
      ui_print " "
      ui_print "$mod_papp"
      ui_print "Volume Up to REINSTALL"
      ui_print "Volume Down to SKIP"
      if $FUNCTION; then
        CHOICE=false
      else
        CHOICE=true
      fi
      if $CHOICE; then
        ui_print "- Skipped!"
      else
        ui_print "- Reinstalling $mod_papp..."
        rm -rf /sbin/.core/img/$MODID/system/app/$mod_papp
        ui_print "- Done!"
      fi
    done
  fi
}

unin_choice() {
  CHOICE=false
  check_key_status
  ui_print " "
  ui_print "- Use Volume Up to enter INSERT MODE"
  ui_print "- There you can make choices on all system apps."
  ui_print "- Once in Insert Mode, you must go through all apps"
  ui_print "before being able to exit the process."
  ui_print " "
  ui_print "- Use Volume Down to REINSTALL an app"
  if $FUNCTION; then
    CHOICE=false
  else
    CHOICE=true
  fi
  if $CHOICE; then
	  reinstall_app
  else
    ui_print "- Entering Insert Mode..."
    if [ $priv -eq 1 ]; then
      list_system_priv_app
    elif [ $ap -eq 1 ]; then
      list_system_app
    fi
  fi
}

# Keycheck binary by someone755 @Github, idea for code below by Zappo @xda-developers
chmod 755 $INSTALLER/common/keycheck

keytest() {
  ui_print "- Vol Key Test -"
  ui_print "   Press Vol Up:"
  ($SYSTEM/bin/getevent -lc 1 2>&1 | $SYSTEM/bin/grep VOLUME | $SYSTEM/bin/grep " DOWN" > $INSTALLER/events) || return 1
  return 0
}

chooseport() {
  #note from chainfire @xda-developers: getevent behaves weird when piped, and busybox grep likes that even less than toolbox/toybox grep
  while (true); do
    $SYSTEM/bin/getevent -lc 1 2>&1 | $SYSTEM/bin/grep VOLUME | $SYSTEM/bin/grep " DOWN" > $INSTALLER/events
    if (`cat $INSTALLER/events 2>/dev/null | $SYSTEM/bin/grep VOLUME >/dev/null`); then
      break
    fi
  done
  if (`cat $INSTALLER/events 2>/dev/null | $SYSTEM/bin/grep VOLUMEUP >/dev/null`); then
    return 0
  else
    return 1
  fi
}

chooseportold() {
  # Calling it first time detects previous input. Calling it second time will do what we want
  $INSTALLER/common/keycheck
  $INSTALLER/common/keycheck
  SEL=$?
  if [ "$1" == "UP" ]; then
    UP=$SEL
  elif [ "$1" == "DOWN" ]; then
    DOWN=$SEL
  elif [ $SEL -eq $UP ]; then
    return 0
  elif [ $SEL -eq $DOWN ]; then
    return 1
  else
    ui_print "   Vol key not detected!"
    abort "   Use name change method in TWRP"
  fi
}

check_key_status() {
  if [ $keytest_status -eq 0 ]
  then
    FUNCTION=chooseport
  else
    FUNCTION=chooseportold
    ui_print "   ! Legacy device detected! Using old keycheck method"
    ui_print " "
    ui_print "- Vol Key Programming -"
    ui_print "   Press Vol Up Again:"
    $FUNCTION "UP"
    ui_print "   Press Vol Down"
    $FUNCTION "DOWN"
  fi
}

if [ -z $CHOICE ]; then
  if keytest; then
    keytest_status=$?
  fi
  check_key_status
  ui_print " "
  ui_print "- Do you want to UNINSTALL the module?"
  ui_print "- Volume Up: UNINSTALL"
  ui_print "- Volume Down: DON'T UNINSTALL"
  if $FUNCTION; then
    CHOICE=false
  else
    CHOICE=true
  fi
fi
if $CHOICE; then
  ui_print "- Resuming Process..."
else
  unin_status=$((unin_status + 1))
fi

priv=0
ap=0
CHOICE=false
check_key_status
ui_print " "
ui_print "- App list -"
ui_print "   List System apps: Volume Up "
ui_print "   List System priv-apps: Volume Down "
ui_print " "
if $FUNCTION; then
  CHOICE=false
else
  CHOICE=true
fi
if $CHOICE; then
  priv=$((priv + 1))
	ui_print "- Retrieving system priv-apps..."
  unin_choice
else
  ap=$((ap + 1))
  ui_print "- Retrieving system apps..."
  unin_choice
fi