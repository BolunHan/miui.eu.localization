MIUI.eu 本地化

---

2024-10-21 经测试，HyperOS 1.0 模块依然可用，工作正常。

自己动手构建完全可信任的 Magisk 本地化模块，无需编程。

以下以 Mipay Module 为例

---

# Requirements

- Windows 10+ x64 (wsl support)
- [7z](https://www.7-zip.org/)
- [vs code](https://code.visualstudio.com/)

---

# 提取应用

## 下载 Rom

下载 CN 版 ROM 卡刷包。官方不再提供下载地址，使用[社区](https://web.vip.miui.com/page/info/mio/mio/detail?postId=37093637&app_version=dev.20051)提供的资源

## 下载 解包工具

从XDA下载 [CRB Kitchen](https://forum.xda-developers.com/t/tool-windows-kitchen-crb-v3-0-0-beta15.3947779/#post-85024807) 工具，需要提前配置WSL环境，解压下载好的文件 as $CRB_ROOT

## 解包

使用刚下载的CRB工具，运行 crb.exe -> "Create new project" -> 起个名"$YourProjectName" -> "Extract Rom (Selective)" -> 选择上边下载好的Rom进行解包

## 提取应用

等待解包完成后，system分区会位于 "$CRB_ROOT\Projects\$YourProjectName\ROM\system" 中

Mipay 模块需要提取的应用有 "Mipay", "NextPay", "TSMClient" 和 "UPTsmService"

---

# 构建 Magisk 模块

## 下载 Magisk Template

从 https://github.com/oasisfeng/magisk-module-template 中 下载/clone Magisk template zip package。不需要解压缩。

## Resolve lib softlink

将 "Mipay", "NextPay", "TSMClient" 和 "UPTsmService" 应用（文件夹）从 "$CRB_ROOT\Projects\YourProjectName\ROM\system\system\app" 复制出来。

在每个应用目录中，删除 ota 目录（如有）

在每个应用目录中，将 \lib\arm64 目录下的链接替换为 $CRB_ROOT\Projects\$YourProjectName\ROM\system\system\lib64 中对应的文件

## 编辑 install.sh

使用 vs code 编辑 install.sh

Mipay 模块需要修改系统的 prop，因此需要设置 
```
PROPFILE=true
```

MIUI.eu 系统内置了 NextPay 应用，为避免冲突，需要加入替换
```
REPLACE="
/system/app/NextPay
"
```

重置权限设置，在脚本最后 加入下述语句
```
rm -rf /data/misc_de/0/apexdata/com.android.permission/runtime-permissions.xml
```

## 编辑 \common\system.prop

加入
```
ro.se.type=HCE,UICC,eSE
```

使得设置中 "安全模块位置" 可以选择 "内置安全模块"
---

# 打包

由于未知的异常，直接使用 Windows 的 send to zip 会导致 Magisk 无法解压包。

我们通过 7z 打开 template.zip，加入/替换 所需要的文件，删除不需要的文件。

<bold> 请勿自行打包 </bold>

release 中提供已经打包好的模块，Mix4 12.5上通过测试。理论上适用其他机型和附近的版本。但不建议。

branch 中提供对应功能的模板，自行修改即可

---

# 刷入

安装 Magisk -> patch boot.img -> 刷入打包好的模块。这里不再赘述。

可以刷入多个模块，不限顺序，并无冲突。

---

# 请我喝杯奶茶吧

![image](https://github.com/BolunHan/miui.eu.localization/blob/main/docs/milk_tea.jpg)
