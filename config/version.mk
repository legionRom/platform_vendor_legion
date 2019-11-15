# Copyright (C) 2017 LEGION ROM
#
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

#LEGION Versioning
LEGION_VERSION = v2.3

ifndef LEGION_BUILD_TYPE
    LEGION_BUILD_TYPE := Unofficial
endif

ifeq ($(LEGION_BUILD_TYPE), OFFICIAL)

# LegionOTA
$(call inherit-product-if-exists, vendor/legion/config/ota.mk)

endif

TARGET_PRODUCT_SHORT := $(subst legion_,,$(CUSTOM_BUILD))

LEGION_DATE_YEAR := $(shell date -u +%Y)
LEGION_DATE_MONTH := $(shell date -u +%m)
LEGION_DATE_DAY := $(shell date -u +%d)
LEGION_DATE_HOUR := $(shell date -u +%H)
LEGION_DATE_MINUTE := $(shell date -u +%M)
LEGION_BUILD_DATE_UTC := $(shell date -d '$(LEGION_DATE_YEAR)-$(LEGION_DATE_MONTH)-$(LEGION_DATE_DAY) $(LEGION_DATE_HOUR):$(LEGION_DATE_MINUTE) UTC' +%s)
LEGION_BUILD_DATE := $(LEGION_DATE_YEAR)$(LEGION_DATE_MONTH)$(LEGION_DATE_DAY)-$(LEGION_DATE_HOUR)$(LEGION_DATE_MINUTE)
LEGION_MOD_VERSION := LEGION-$(LEGION_VERSION)-$(LEGION_BUILD_DATE)-$(LEGION_BUILD_TYPE)
LEGION_FINGERPRINT := LEGION/$(LEGION_VERSION)/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(LEGION_BUILD_DATE)


PRODUCT_GENERIC_PROPERTIES += \
  ro.legion.version=$(LEGION_VERSION) \
  ro.legion.releasetype=$(LEGION_BUILD_TYPE) \
  ro.modversion=$(LEGION_MOD_VERSION)

LEGION_DISPLAY_VERSION := LEGION-$(LEGION_VERSION)-$(LEGION_BUILD_TYPE)

PRODUCT_GENERIC_PROPERTIES += \
  ro.legion.display.version=$(LEGION_DISPLAY_VERSION) \
  ro.legion.fingerprint=$(LEGION_FINGERPRINT) \
  ro.legion.build_date_utc=$(LEGION_BUILD_DATE_UTC)
