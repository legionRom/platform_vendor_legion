# Copyright (C) 2018 LegionOS Project 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PRODUCT_GENERIC_PROPERTIES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.mode=OPTIONAL \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.setupwizard.rotation_locked=true \
    ro.opa.eligible_device=true\
    net.tethering.noprovisioning=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    ro.build.selinux=0 \
    persist.sys.dun.override=0 \
    ro.storage_manager.enabled=true \
    ro.substratum.verified=true \
    persist.sys.recovery_update=false \
    ro.com.google.ime.theme_id=5 \
    persist.sys.disable_rescue=true \
    ro.boot.vendor.overlay.theme=org.omnirom.theme.accent.spookedpurple;org.omnirom.theme.primary.almostblack;org.omnirom.theme.notification.primary;org.omnirom.theme.app.dialertheme;org.omnirom.theme.app.messagestheme


# Disable HDCP check
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.wfd.nohdcp=1

# Set cache location
ifeq ($(BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE),)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/data/cache
else
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/cache
endif

#Build Simple Gallery
  PRODUCT_PACKAGES += \
     Recorder \

# Some more permissions
PRODUCT_COPY_FILES += \
    vendor/legion/prebuilt/common/etc/permissions/privapp-permissions-recorder.xml:system/etc/permissions/privapp-permissions-recorder.xml \
    vendor/legion/prebuilt/common/etc/permissions/org.pixelexperience.recorder.xml:system/etc/permissions/org.pixelexperience.recorder.xml


# LegionOS OTA
$(call inherit-product-if-exists, vendor/legion/config/ota.mk)