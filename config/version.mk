# Copyright (C) 2018 LegionOS Project
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

LEGION_VERSION := v2.3

# LEGION RELEASE VERSION
ifndef LEGION_BUILD_TYPE
    LEGION_BUILD_TYPE := Unofficial
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

LEGION_DATE := $(shell date -u +%Y%m%d-%H%M)

LEGION_FINGERPRINT := LEGIONOS/$|(LEGION_VERSION)/$(PLATFORM_VERSION)/$(BUILD_ID)/$(LEGION_DATE) 

LEGION_BUILD_VERSION := LEGIONOS-$(LEGION_VERSION)-$(CURRENT_DEVICE)-$(LEGION_BUILD_TYPE)-$(LEGION_DATE)
