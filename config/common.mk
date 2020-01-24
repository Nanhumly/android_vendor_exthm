#
# Copyright (C) 2022 The exTHmUI Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit vendor submodules
$(call inherit-product, vendor/exthm/overlay/overlay.mk)

# exTHmUI version
-include vendor/exthm/config/version.mk

# Sounds
include vendor/exthm/config/sounds.mk

$(call inherit-product-if-exists, vendor/gms/config.mk)

# Bootanimation
TARGET_SCREEN_WIDTH ?= 1080
TARGET_SCREEN_HEIGHT ?= 1920
PRODUCT_PACKAGES += \
    bootanimation.zip \
    bootanimation-dark.zip

# Charger mode images
PRODUCT_PACKAGES += \
    charger_res_images \
    product_charger_res_images

# Required packages
PRODUCT_PACKAGES += \
    LatinIME \
    ThemePicker \
    ViaBrowser

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.ntfs \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Tethering - allow without requiring a provisioning app
# (for devices that check this)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    net.tethering.noprovisioning=true

# Only logging privapp-permissions whitelist
PRODUCT_PRODUCT_PROPERTIES += \
    ro.control_privapp_permissions=log

# ADB authentication
ifeq ($(TARGET_BUILD_VARIANT),eng)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Set GMS client ID base
ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Override undesired Google defaults
PRODUCT_PRODUCT_PROPERTIES += \
    keyguard.no_require_sim=true \
    ro.setupwizard.enterprise_mode=1 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true
