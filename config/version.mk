PRODUCT_VERSION_MAJOR = 3
PRODUCT_VERSION_MINOR = 0
GENESIS_VERSION_TAG := Utopia

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

GENESIS_BUILDTYPE := UNOFFICIAL

ifeq ($(GENESIS_OFFICIAL), true)
     GENESIS_BUILDTYPE := OFFICIAL
endif

GENESIS_MAINTAINER ?= UNKNOWN

GENESIS_VERSION := GenesisOS-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(GENESIS_VERSION_TAG)-$(CURRENT_DEVICE)-$(GENESIS_BUILDTYPE)-$(shell date -u +%Y%m%d-%H%M)

GENESIS_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(GENESIS_VERSION_TAG)

# GenesisOS version properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.genesis.display.version=$(GENESIS_DISPLAY_VERSION) \
    ro.genesis.maintainer=$(GENESIS_MAINTAINER) \
    ro.genesis.releasetype=$(GENESIS_BUILDTYPE)

# Signing
ifeq (user,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard .android-certs/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := .android-certs/releasekey
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
ifneq (,$(wildcard .android-certs/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := .android-certs/otakey.x509.pem
endif
endif
