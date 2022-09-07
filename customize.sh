MODID=miui.mipay

ui_print "*******************************"
ui_print "      Mipay Module v0.1.1      "
ui_print "*******************************"
ui_print "                               "
ui_print "钱包如果能调出刷卡界面但是刷卡无反应"
ui_print "在系统设置中将默认钱包改为HCE再改回小米钱包。"

REPLACE="
/system/app/NextPay
"

ui_print "- Reset permission"
rm -rf /data/misc_de/0/apexdata/com.android.permission/runtime-permissions.xml
ui_print "- Extracting module files"
unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2