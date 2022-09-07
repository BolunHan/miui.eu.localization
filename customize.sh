MODID=miui.future

ui_print "*******************************"
ui_print "    Mi.Future Module v0.2.0    "
ui_print "*******************************"

REPLACE="
/system/priv-app/MiuiHome
/system/priv-app/QuickSearchBox
/system/priv-app/PersonalAssistant
/system/priv-app/Calendar
/system/priv-app/MiSettings
/system/priv-app/Weather
/system/priv-app/MiuiGallery
/system/app/MIUISystemUIPlugin
"

ui_print "- Reset permission"
rm -rf /data/misc_de/0/apexdata/com.android.permission/runtime-permissions.xml
ui_print "- Extracting module files"
unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2