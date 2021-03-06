# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_NAME := legion
PRODUCT_BRAND := legion
PRODUCT_DEVICE := generic

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_DISPLAY_ID=$(TARGET_PRODUCT)-$(PLATFORM_VERSION)-$(BUILD_ID)

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Default notification/alarm sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Tethering - allow without requiring a provisioning app
# (for devices that check this)
PRODUCT_PROPERTY_OVERRIDES += \
    net.tethering.noprovisioning=true

# APN
PRODUCT_COPY_FILES += \
    vendor/legion/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/legion/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/legion/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/legion/prebuilt/common/bin/50-legion.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-legion.sh \
    vendor/legion/prebuilt/common/bin/blacklist:$(TARGET_COPY_OUT_SYSTEM)/addon.d/blacklist \
    vendor/legion/prebuilt/common/bin/system-mount.sh:install/bin/system-mount.sh

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/legion/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/legion/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/legion/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/legion/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Fonts
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/legion/prebuilt/fonts,$(TARGET_COPY_OUT_PRODUCT)/fonts) \
	vendor/legion/prebuilt/etc/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml

# Legion-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/legion/config/permissions/legion-sysconfig.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/legion-sysconfig.xml

# Copy all Legion-specific init rc files
$(foreach f,$(wildcard vendor/legion/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Extra packages
PRODUCT_PACKAGES += \
    Launcher3 \
    ExactCalculator \
    Exchange2 \
    Terminal

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/legion/prebuilt/common/lib/content-types.properties:$(TARGET_COPY_OUT_SYSTEM)/lib/content-types.properties

# Markup libs
PRODUCT_COPY_FILES += \
    vendor/legion/prebuilt/google/lib/libsketchology_native.so:system/product/lib/libsketchology_native.so \
    vendor/legion/prebuilt/google/lib64/libsketchology_native.so:system/product/lib64/libsketchology_native.so

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/legion/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl

# This is Legion!
PRODUCT_COPY_FILES += \
   vendor/legion/config/permissions/privapp-permissions-google_prebuilt.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-google_prebuilt.xml \
   vendor/legion/config/permissions/privapp-permissions-legion.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-legion.xml \
   vendor/legion/config/permissions/wallpaper_privapp-permissions.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/wallpaper_privapp-permissions.xml

# Hidden API whitelist
PRODUCT_COPY_FILES += \
    vendor/legion/config/permissions/legion-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/legion-hiddenapi-package-whitelist.xml

# Legion packages
PRODUCT_PACKAGES += \
    LPaper-v1.0.0-release \
    GalleryGoPrebuilt \
    ThemePicker \
    FontGoogleSansOverlay \
    Snap \
    Lawnchair \
    Sqlite3 \
    WallpaperPicker2 \
    SafetyHubPrebuilt \
    OmniStyle \
    OPScreenRecorder \
    StitchImage

# Lawnchair
PRODUCT_COPY_FILES += \
    vendor/legion/prebuilt/common/etc/permissions/privapp-permissions-lawnchair.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-lawnchair.xml \
    vendor/legion/prebuilt/common/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/legion/config/permissions/legion-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/legion-power-whitelist.xml

# Hidden api whitelisted apps
PRODUCT_COPY_FILES += \
    vendor/legion/prebuilt/common/etc/sysconfig/legion-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/legion-hiddenapi-package-whitelist.xml

# Include AOSP audio files
include vendor/legion/config/aosp_audio.mk

# Include Legion audio files
include vendor/legion/config/legion_audio.mk

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/legion/config/twrp.mk
endif

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Bootanimation
$(call inherit-product, vendor/legion/config/bootanimation.mk)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.network_required=false \
    ro.setupwizard.gservices_delay=-1 \
    ro.com.android.dataroaming=false \
    drm.service.enabled=true \
    net.tethering.noprovisioning=true \
    persist.sys.dun.override=0 \
    ro.build.selinux=1 \
    ro.adb.secure=0 \
    ro.setupwizard.rotation_locked=true \
    ro.opa.eligible_device=true \
    persist.sys.disable_rescue=true \
    ro.config.calibration_cad=/system/etc/calibration_cad.xml

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    org.legion.fingerprint=$(PLATFORM_VERSION)-$(BUILD_ID)-$(LEGION_BUILD_DATE)

# Extra tools in Legion
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Offline charger
PRODUCT_PACKAGES += \
    charger_res_images \
    product_charger_res_images

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

#Gvm
include vendor/legion/config/gvm.mk

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

# Conditionally build in su
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    adb_root
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/legion/overlay/common
#DEVICE_PACKAGE_OVERLAYS += vendor/legion/overlay/common

#Speed tuning
PRODUCT_DEXPREOPT_SPEED_APPS += \
    Settings \
    SystemUI

# Include Legion's theme files
include vendor/legion/themes/backgrounds/themes.mk

# Allow overlays to be excluded from enforcing RRO
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/legion/overlay

# Legion Stuff - Copy to System fonts
PRODUCT_COPY_FILES += \
    vendor/legion/prebuilt/fonts/gobold/Gobold.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Gobold.ttf \
    vendor/legion/prebuilt/fonts/gobold/Gobold-Italic.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Gobold-Italic.ttf \
    vendor/legion/prebuilt/fonts/gobold/GoboldBold.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/GoboldBold.ttf \
    vendor/legion/prebuilt/fonts/gobold/GoboldBold-Italic.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/GoboldBold-Italic.ttf \
    vendor/legion/prebuilt/fonts/gobold/GoboldThinLight.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/GoboldThinLight.ttf \
    vendor/legion/prebuilt/fonts/gobold/GoboldThinLight-Italic.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/GoboldThinLight-Italic.ttf \
    vendor/legion/prebuilt/fonts/roadrage/road_rage.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/RoadRage-Regular.ttf \
    vendor/legion/prebuilt/fonts/neoneon/neoneon.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Neoneon-Regular.ttf \
    vendor/legion/prebuilt/fonts/mexcellent/mexcellent.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Mexcellent-Regular.ttf \
    vendor/legion/prebuilt/fonts/burnstown/burnstown.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Burnstown-Regular.ttf \
    vendor/legion/prebuilt/fonts/dumbledor/dumbledor.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Dumbledor-Regular.ttf \
    vendor/legion/prebuilt/fonts/PhantomBold/PhantomBold.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/PhantomBold-Regular.ttf \
    vendor/legion/prebuilt/fonts/snowstorm/snowstorm.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Snowstorm-Regular.ttf \
    vendor/legion/prebuilt/fonts/vcrosd/vcr_osd_mono.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/ThemeableFont-Regular.ttf \
    vendor/legion/prebuilt/fonts/Shamshung/Shamshung.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Shamshung.ttf \
    vendor/legion/prebuilt/fonts/Aclonica/Aclonica.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Aclonica.ttf \
    vendor/legion/prebuilt/fonts/Amarante/Amarante.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Amarante.ttf \
    vendor/legion/prebuilt/common/fonts/AntipastoPro/AntipastoPro.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/AntipastoPro.ttf \
    vendor/legion/prebuilt/common/fonts/EvolveSans/EvolveSans.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/EvolveSans.ttf \
    vendor/legion/prebuilt/common/fonts/Fucek/Fucek.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Fucek.ttf \
    vendor/legion/prebuilt/common/fonts/LemonMilk/LemonMilk.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/LemonMilk.ttf \
    vendor/legion/prebuilt/common/fonts/Oduda/Oduda.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Oduda.ttf \
    vendor/legion/prebuilt/common/fonts/ReemKufi/ReemKufi.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/ReemKufi.ttf \
    vendor/legion/prebuilt/common/fonts/GoogleSansMedium/GoogleSansMedium.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/GoogleSansMedium.ttf \
    vendor/legion/prebuilt/common/fonts/SimpleDay/SimpleDay.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/SimpleDay.ttf \
    vendor/legion/prebuilt/fonts/Bariol/Bariol-Regular.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Bariol.ttf \
    vendor/legion/prebuilt/fonts/Cagliostro/Cagliostro-Regular.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Cagliostro-Regular.ttf \
    vendor/legion/prebuilt/fonts/Coolstory/Coolstory-Regular.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Coolstory-Regular.ttf \
    vendor/legion/prebuilt/fonts/Comic_Sans.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Comic_Sans.ttf \
    vendor/legion/prebuilt/fonts/LGSmartGothic/LGSmartGothic.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/LGSmartGothic.ttf \
    vendor/legion/prebuilt/fonts/Rosemary/Rosemary-Regular.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Rosemary-Regular.ttf \
    vendor/legion/prebuilt/fonts/SonySketch/SonySketch.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/SonySketch.ttf \
    vendor/legion/prebuilt/fonts/SamsungOne.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/SamsungOne.ttf \
    vendor/legion/prebuilt/fonts/SlateFromOP-Light.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/SlateFromOP-Light.ttf \
    vendor/legion/prebuilt/fonts/SlateFromOP-Regular.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/SlateFromOP-Regular.ttf \
    vendor/legion/prebuilt/fonts/Surfer/Surfer.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Surfer.ttf

-include vendor/legion/config/partner_gms.mk
-include vendor/legion/config/version.mk
-include vendor/legion/gapps.mk

# Enable ccache
USE_CCACHE := true

# Fod
DEVICE_PACKAGE_OVERLAYS += vendor/legion/overlay/common
ifeq ($(EXTRA_FOD_ANIMATIONS),true)
DEVICE_PACKAGE_OVERLAYS += vendor/legion/overlay/fod
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/legion/overlay/fod
endif

# Include Legion QS Style files
include vendor/legion/QS/qsstyle.mk
