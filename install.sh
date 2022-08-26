MODID=miui.propreset

# Set to true if you need to enable Magic Mount
# Most mods would like it to be enabled
AUTOMOUNT=true

# Set to true if you need to load system.prop
PROPFILE=false

# Set to true if you need post-fs-data script
POSTFSDATA=false

# Set to true if you need late_start service script
LATESTARTSERVICE=false

##########################################################################################
# Installation Message
##########################################################################################

# Set what you want to show when installing your mod

print_modname() {
  ui_print "********************************"
  ui_print " MIUI PropReset Module v0.1.0 "
  ui_print "********************************"
}

##########################################################################################
# Replace list
##########################################################################################

REPLACE="
"

set_permissions() {
  # Default permissions, don't remove them
  set_perm_recursive  $MODPATH  0  0  0755  0644

  # Only some special files require specific permissions
  # The default permissions should be good enough for most cases

  # Some templates if you have no idea what to do:

  # set_perm_recursive  <dirname>                <owner> <group> <dirpermission> <filepermission> <contexts> (default: u:object_r:system_file:s0)
  # set_perm_recursive  $MODPATH/system/lib       0       0       0755            0644

  # set_perm  <filename>                         <owner> <group> <permission> <contexts> (default: u:object_r:system_file:s0)
  # set_perm  $MODPATH/system/bin/app_process32   0       2000    0755         u:object_r:zygote_exec:s0
  # set_perm  $MODPATH/system/bin/dex2oat         0       2000    0755         u:object_r:dex2oat_exec:s0
  # set_perm  $MODPATH/system/lib/libart.so       0       0       0644
}

ui_print "- overriding system.prop"
# echo "" >> $MODPATH/system.prop
# echo "ro.product.mod_device=xiaomieu" >> $MODPATH/system.prop
# echo "ro.miui.region=CN" >> $MODPATH/system.prop
# echo "ro.com.google.ime.theme_dir=" >> $MODPATH/system.prop
# echo "ro.com.google.ime.theme_file=" >> $MODPATH/system.prop
# echo "" >> $MODPATH/system.prop
unzip -p "$ZIPFILE" 'common/system.prop' >$MODPATH/system.prop