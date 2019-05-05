# Generic product
PRODUCT_NAME := legion
PRODUCT_BRAND := legion
PRODUCT_DEVICE := generic

EXCLUDE_SYSTEMUI_TESTS := true

# version
include vendor/legion/config/version.mk

# Props
include vendor/legion/config/legion_props.mk

# Packages
include vendor/legion/config/packages.mk

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/legion/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/legion/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/legion/prebuilt/common/bin/50-legion.sh:system/addon.d/50-legion.sh \
    vendor/legion/prebuilt/common/bin/blacklist:system/addon.d/blacklist

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/legion/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/legion/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/legion/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# priv-app permissions
PRODUCT_COPY_FILES += \
    vendor/legion/prebuilt/common/etc/permissions/privapp-permissions-legion.xml:system/etc/permissions/privapp-permissions-legion.xml \
    vendor/legion/prebuilt/common/etc/permissions/privapp-permissions-elgoog.xml:system/etc/permissions/privapp-permissions-elgoog.xml

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    vendor/legion/overlay/common \
    vendor/legion/overlay/themes

# Bootanimation
$(call inherit-product, vendor/legion/config/bootanimation.mk)

# Substratum Key
PRODUCT_COPY_FILES += \
    vendor/legion/prebuilt/common/priv-app/SubstratumKey.apk:system/priv-app/SubstratumKey/SubstratumKey.apk

# Sensitive Phone Numbers list
PRODUCT_COPY_FILES += \
    vendor/legion/prebuilt/common/etc/sensitive_pn.xml:system/etc/sensitive_pn.xml

# World APN list
PRODUCT_COPY_FILES += \
    vendor/legion/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# LatinIME gesture typing
PRODUCT_COPY_FILES += \
    vendor/legion/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/legion/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so

# Versioning
include vendor/legion/config/version.mk

# Omni Poor Man Themes
PRODUCT_PACKAGES += \
    DocumentsUITheme \
    DialerTheme \
    PhonographTheme \
    TelecommTheme

PRODUCT_PACKAGES += \
    NotificationsXtended \
    NotificationsBlack \
    NotificationsDark \
    NotificationsLight \
    NotificationsPrimary

PRODUCT_PACKAGES += \
    AccentSluttyPink \
    AccentPixel \
    AccentGoldenShower \
    AccentDeepOrange \
    AccentMisticBrown \
    AccentOmni \
    AccentWhite \
    AccentTeal \
    AccentFromHell \
    AccentBlueMonday \
    AccentSmokingGreen \
    AccentDeadRed \
    AccentRottenOrange \
    AccentDeepPurple \
    AccentBlackMagic \
    AccentPurple \
    AccentCandyRed \
    AccentJadeGreen \
    AccentPaleBlue \
    AccentPaleRed \
    AccentObfusBleu \
    AccentNotImpPurple \
    AccentHolillusion \
    AccentMoveMint \
    AccentFootprintPurple \
    AccentBubblegumPink \
    AccentFrenchBleu \
    AccentManiaAmber \
    AccentSeasideMint \
    AccentDreamyPurple \
    AccentSpookedPurple \
    AccentHeirloomBleu \
    AccentTruFilPink \
    AccentWarmthOrange \
    AccentColdBleu \
    AccentDiffDayGreen \
    AccentDuskPurple \
    AccentBurningRed \
    AccentHazedPink \
    AccentColdYellow \
    AccentNewHouseOrange \
    AccentIllusionsPurple \
    AccentFlare \
    AccentSublime \
    AccentSincityRed \
    AccentOrangeCoral \
    AccentPureLust \
    AccentQuepal \
    AccentShadesOfGrey

 PRODUCT_PACKAGES += \
    PrimaryAlmostBlack \
    PrimaryBlack \
    PrimaryXtended \
    PrimaryXtendedClear \
    PrimaryEyeSoother \
    PrimaryOmni \
    PrimaryWhite \
    PrimaryColdWhite \
    PrimaryWarmWhite \
    PrimaryDarkBlue

# Props
include vendor/legion/config/legion_props.mk

# Sounds
include vendor/legion/config/sounds.mk

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.opa.eligible_device=true


