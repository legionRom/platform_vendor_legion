# Copyright (C) 2019 LegionROMs
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

LEGION_VERSION = 1.1

ifndef LEGION_BUILD_TYPE
    LEGION_BUILD_TYPE := UNOFFICIAL
endif

ifndef LEGION_MAINTAINER
    LEGION_MAINTAINER := None
endif

ifndef CPU_MODEL
    CPU_MODEL := random_625
endif
CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

ifeq ($(LEGION_OFFICIAL),true)
   LIST = $(shell curl -s https://raw.githubusercontent.com/legionRom/platform_vendor_legion/pie/legion.devices)
   FOUND_DEVICE = $(filter $(CURRENT_DEVICE), $(LIST))
    ifeq ($(FOUND_DEVICE),$(CURRENT_DEVICE))
      IS_OFFICIAL=true
      LEGION_BUILD_TYPE := OFFICIAL
    else
      LEGION_BUILD_TYPE := UNOFFICIAL
    endif
endif

DATE := $(shell date -u +%Y%m%d-%H%M)
TARGET_BACON_NAME := LEGIONOS-$(LEGION_VERSION)-$(CURRENT_DEVICE)-$(LEGION_BUILD_TYPE)-$(DATE)
LEGION_FINGERPRINT := LEGIONOS/$|(LEGION_VERSION)/$(PLATFORM_VERSION)/$(BUILD_ID)/$(DATE)
LEGION_DISPLAY_VERSION := LEGIONOS-$(LEGION_VERSION)-$(LEGION_BUILD_TYPE)

PRODUCT_PROPERTY_OVERRIDES += \
BUILD_DISPLAY_ID=$(BUILD_ID) \
com.legion.fingerpring=$(LEGION_FINGERPRINT) \
ro.legion.version=$(LEGION_VERSION) \
ro.legion.display.version=$(LEGION_DISPLAY_VERSION) \
ro.legion.releasetype=$(LEGION_BUILD_TYPE) \
ro.modversion=$(TARGET_BACON_NAME) \
ro.legion.maintainer = $(LEGION_MAINTAINER) \
ro.processor.model=$(CPU_MODEL)
