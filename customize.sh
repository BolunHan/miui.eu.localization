MODID=miui.supermarket

ui_print "********************************"
ui_print " MIUI SuperMarket Module v0.1.1 "
ui_print "********************************"

REPLACE="
"

ui_print "- Extracting module files"
unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2