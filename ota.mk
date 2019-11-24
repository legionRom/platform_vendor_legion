ifeq ($(WITH_GAPPS), true)
LEGION_OTA_VERSION_CODE := q_gapps
else
LEGION_OTA_VERSION_CODE :=q

CUSTOM_PROPERTIES += \
    ro.legion.ota.version_code=$(LEGION_OTA_VERSION_CODE) \
    sys.ota.disable_uncrypt=1

PRODUCT_COPY_FILES += \
    vendor/legion/config/permissions/com.legion.ota.xml:system/etc/permissions/com.legion.ota.xml

endif
