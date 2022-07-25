# Extract Mipay from MIUI.cn Rom and Install it to MIUI.eu Rom

## Extraction:

- requirement: Windows 10+, wsl, ubuntu distr
- download [CRB Kitchen](https://forum.xda-developers.com/t/tool-windows-kitchen-crb-v3-0-0-beta15.3947779/#post-85024807), unzip it as $CRB_ROOT
- install WSL and a linux distr
- Download CN rom for your device from [miui forum](https://web.vip.miui.com/page/info/mio/mio/detail?postId=37093637&app_version=dev.20051)
- Run crb.exe, "Create new project" -> "Extract Rom (Selective)" -> select the Rom you just downloaded
- wait until extraction complete, the extracted should in "$CRB_ROOT/Projects/$ProjectName/ROM"
- $ROM_SYSTEM="$CRB_ROOT/Projects/$ProjectName/ROM/system/system"

## Build Module

- $PROJECT_ROOT=where the project is cloned
- rm -rf $PROJECT_ROOT/system/*; mkdir $PROJECT_ROOT/system/app
- cp "Mipay", "NextPay", "TSMClient" and "UPTsmService" to system/app</br>

```bash
cp -r $ROM_SYSTEM/app/Mipay $PROJECT_ROOT/system/app
cp -r $ROM_SYSTEM/app/NextPay $PROJECT_ROOT/system/app
cp -r $ROM_SYSTEM/app/TSMClient $PROJECT_ROOT/system/app
cp -r $ROM_SYSTEM/app/UPTsmService $PROJECT_ROOT/system/app
```

- resolve broken softlink, rm .so files in "$AppName/lib/arm64/*" and place the actual file there</br>for NextPay

```bash
rm $PROJECT_ROOT/system/app/NextPay/lib/arm64/*
cp $ROM_SYSTEM/lib64/libentryexpro.so $PROJECT_ROOT/system/app/lib/arm64
cp $ROM_SYSTEM/lib64/libuptsmaddonmi.so $PROJECT_ROOT/system/app/lib/arm64
```

- do the same procedure for the reset apps
- add replace entry: `/system/app/NextPay
- add reload prop `ro.se.type=HCE,UICC,eSE`
