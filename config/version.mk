# Copyright (C) 2016-2019 LEGION
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

# Versioning System
BUILD_DATE := $(shell date +%Y%m%d)
TARGET_PRODUCT_SHORT := $(subst legion_,,$(LEGION_BUILDTYPE))

LEGION_BUILDTYPE ?= stable
LEGION_BUILD_VERSION := 10
LEGION_VERSION := $(LEGION_BUILD_VERSION)-$(LEGION_BUILDTYPE)-$(LEGION_BUILD)-$(BUILD_DATE)
ROM_FINGERPRINT := Legion/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date -u +%H%M)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.legion.build.version=$(LEGION_BUILD_VERSION) \
  ro.legion.build.date=$(BUILD_DATE) \
  ro.legion.buildtype=$(LEGION_BUILDTYPE) \
  ro.legion.fingerprint=$(ROM_FINGERPRINT) \
  ro.legion.version=$(LEGION_VERSION) \
  ro.legion.device=$(LEGION_BUILD) \
  ro.modversion=$(LEGION_VERSION)

ifneq ($(OVERRIDE_OTA_CHANNEL),)
    PRODUCT_PROPERTY_OVERRIDES += \
        legion.updater.uri=$(OVERRIDE_OTA_CHANNEL)
endif
