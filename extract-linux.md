# Extracting and Replacing HyperOS / MIUI System APKs

This walkthrough documents how to extract system applications from a Xiaomi HyperOS fastboot ROM and replace the corresponding app on another device.

---

# Prerequisites

On Arch / Manjaro:

```bash
sudo pacman -S android-tools e2fsprogs
yay -S android-lpunpack erofs-utils
```

Required tools:

- `lpunpack`
- `dump.erofs`
- `adb`
- `aapt` (optional, for verifying package names)

---

# 1. Obtain the fastboot ROM

After extracting the downloaded ROM, locate:

```text
images/super.img
```

Example:

```text
odin_images_OS1.0.4.0.UKMCNXM_14.0_cn_chinatelecom/
└── images/
    └── super.img
```

---

# 2. Unpack the dynamic partitions

Create an output directory:

```bash
mkdir extracted
```

Extract logical partitions:

```bash
lpunpack super.img extracted
```

Result:

```text
extracted/
    product_a.img
    system_a.img
    system_ext_a.img
    vendor_a.img
    ...
```

---

# 3. Extract the filesystem

HyperOS uses EROFS for most read-only partitions.

Extract, for example, the Product partition:

```bash
mkdir product_fs

dump.erofs -x product_fs extracted/product_a.img
```

Likewise:

```bash
mkdir system_ext_fs
dump.erofs -x system_ext_fs extracted/system_ext_a.img
```

---

# 4. Locate APKs

Search all APKs:

```bash
find product_fs system_ext_fs -iname "*.apk"
```

Typical output:

```text
product_fs/priv-app/MiuiGallery/MiuiGallery.apk
product_fs/priv-app/MiuiWeather2/MiuiWeather2.apk
product_fs/app/MiuiVideoPlayer/MiuiVideoPlayer.apk
product_fs/priv-app/PersonalAssistant/PersonalAssistant.apk
```

If searching by filename is unsuccessful:

```bash
find product_fs system_ext_fs -type d
```

Many Xiaomi applications are named:

- MiuiGallery
- MiuiWeather2
- MiuiVideoPlayer
- PersonalAssistant

rather than simply "Gallery" or "Weather".

---

# 5. Copy the desired APKs

Example:

```bash
mkdir extracted_apks

cp product_fs/priv-app/MiuiGallery/MiuiGallery.apk extracted_apks/
cp product_fs/priv-app/MiuiWeather2/MiuiWeather2.apk extracted_apks/
cp product_fs/app/MiuiVideoPlayer/MiuiVideoPlayer.apk extracted_apks/
cp product_fs/priv-app/PersonalAssistant/PersonalAssistant.apk extracted_apks/
```

Result:

```text
extracted_apks/
├── MIUIGallery.apk
├── MIUIWeather.apk
├── MIUIVideo.apk
└── PersonalAssistant.apk
```

---

# 6. Determine the destination path on the target device

Query the installed package:

```bash
adb shell pm path <package>
```

Examples:

```bash
adb shell pm path com.miui.gallery
adb shell pm path com.miui.weather2
adb shell pm path com.miui.videoplayer
adb shell pm path com.miui.personalassistant
```

Typical output:

```text
package:/product/priv-app/MiuiGallery/MiuiGallery.apk
package:/product/priv-app/MiuiWeather2/MiuiWeather2.apk
package:/product/app/MiuiVideoPlayer/MiuiVideoPlayer.apk
package:/product/priv-app/PersonalAssistant/PersonalAssistant.apk
```

---

# 7. Replace using Magisk

Do **not** use:

```bash
adb install
```

or

```bash
pm install -r -d
```

System applications cannot be downgraded below the preloaded version, even with root.

Instead, create a Magisk module that mirrors the original path.

Example:

Original:

```text
/product/priv-app/MiuiGallery/MiuiGallery.apk
```

Magisk module:

```text
system/product/priv-app/MiuiGallery/MiuiGallery.apk
```

Reboot after flashing.

---

# Notes

- HyperOS fastboot ROMs package almost all system apps inside `super.img`.
- `lpunpack` extracts logical partitions from `super.img`.
- `dump.erofs` extracts files from EROFS partition images.
- Most Xiaomi apps reside under the `product` partition.
- Always use `adb shell pm path` to determine the exact destination path before creating the Magisk module.
