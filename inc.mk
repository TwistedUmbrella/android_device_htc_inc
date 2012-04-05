#
# Copyright (C) 2009 The Android Open Source Project
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
#

## (1) Device GPS Properties
PRODUCT_COPY_FILES += \
    device/htc/common/system/etc/gps.conf:system/etc/gps.conf

PRODUCT_COPY_FILES += \
    device/htc/inc/prebuilt/root/init.inc.rc:root/init.inc.rc \
    device/htc/inc/prebuilt/root/ueventd.inc.rc:root/ueventd.inc.rc

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/htc/inc/inc-vendor.mk)

## (3)  Finally, the least specific parts, i.e. the non-GSM-specific aspects
PRODUCT_PROPERTY_OVERRIDES += \
	ro.error.receiver.system.apps=com.google.android.feedback \
	ro.setupwizard.enterprise_mode=1 \
	ro.com.google.clientidbase=android-verizon \
	ro.com.google.locationfeatures=1 \
	ro.cdma.home.operator.alpha=Verizon \
	ro.cdma.home.operator.numeric=310012 \
	ro.cdma.homesystem=64,65,76,77,78,79,80,81,82,83 \
	ro.cdma.data_retry_config=default_randomization=2000,0,0,120000,180000,540000,960000 \
	ro.config.vc_call_vol_steps=7 \
	ro.cdma.otaspnumschema=SELC,1,80,99 \
	ro.telephony.call_ring.multiple=false \
	ro.telephony.call_ring.delay=3000 \
	ro.setupwizard.enable_bypass=1 \
	ro.media.dec.jpeg.memcap=20000000 \
	ro.media.enc.jpeg.quality=95,85,70

DEVICE_PACKAGE_OVERLAYS += device/htc/inc/overlay

# Dalvik properties
# dexop-flags: "v=" n|r|a, "o=" n|v|a|f, "m=y" register map
# v=verify o=optimize: n=none r=remote a=all f=full v=verified
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dexopt-flags=m=y \
    dalvik.vm.checkjni=false

# Default heap settings for 512mb device
include frameworks/base/build/phone-hdpi-512-dalvik-heap.mk

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# High-density art, but English locale
PRODUCT_LOCALES += en
PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/base/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

# Touchscreen
PRODUCT_COPY_FILES += \
    device/htc/inc/prebuilt/usr/idc/atmel-touchscreen.idc:system/usr/idc/atmel-touchscreen.idc

# Optical trackball
PRODUCT_COPY_FILES += \
    device/htc/inc/prebuilt/usr/idc/curcial-oj.idc:system/usr/idc/curcial-oj.idc

# Keylayouts
PRODUCT_COPY_FILES += \
    device/htc/inc/prebuilt/usr/keylayout/incrediblec-keypad.kl:system/usr/keylayout/incrediblec-keypad.kl \
    device/htc/inc/prebuilt/usr/keylayout/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl

# Keymap
PRODUCT_COPY_FILES += \
    device/htc/inc/prebuilt/usr/keychars/incrediblec-keypad.kcm.bin:system/usr/keychars/incrediblec-keypad.kcm.bin

# sysctl parameters
PRODUCT_COPY_FILES += \
    device/htc/inc/prebuilt/etc/sysctl.conf:system/etc/sysctl.conf

# non-rotational init.d script
PRODUCT_COPY_FILES += \
    device/htc/inc/prebuilt/etc/init.d/02nonrot:system/etc/init.d/02nonrot

# media config xml file
PRODUCT_COPY_FILES += \
    device/htc/inc/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml

# APN list
PRODUCT_COPY_FILES += \
    device/htc/inc/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

# Firmware
PRODUCT_COPY_FILES += \
    device/htc/inc/prebuilt/etc/firmware/bcm4329.hcd:system/etc/firmware/bcm4329.hcd \
    device/htc/inc/prebuilt/etc/firmware/fw_bcm4329.bin:system/etc/firmware/fw_bcm4329.bin \
    device/htc/inc/prebuilt/etc/firmware/fw_bcm4329_apsta.bin:system/etc/firmware/fw_bcm4329_apsta.bin

PRODUCT_COPY_FILES += \
    device/htc/inc/prebuilt/etc/vold.fstab:system/etc/vold.fstab

# Kernel Modules
PRODUCT_COPY_FILES += $(shell \
    find device/htc/inc/prebuilt/lib/modules -name '*.ko' \
    | sed -r 's/^\/?(.*\/)([^/ ]+)$$/\1\2:system\/lib\/modules\/\2/' \
    | tr '\n' ' ')

# Sensors
PRODUCT_PACKAGES += \
    gps.inc \
    lights.inc \
    sensors.inc

# Temporary hack
ADDITIONAL_DEFAULT_PROPERTIES += \
    persist.service.adb.enable=1

# Enable GPU composition (0: cpu, 1: gpu)
# Note: must be 1 for composition.type to work
PRODUCT_PROPERTY_OVERRIDES += debug.sf.hw=1

# Enable copybit composition
PRODUCT_PROPERTY_OVERRIDES += debug.composition.type=mdp

# Force 2 buffers since gralloc defaults to 3 (we only have 2)
PRODUCT_PROPERTY_OVERRIDES += debug.gr.numframebuffers=2

# HardwareRenderer properties
# dirty regions: "false" disables partial invalidates (override if enabletr=true)
PRODUCT_PROPERTY_OVERRIDES += \
    hwui.render_dirty_regions=false \
    hwui.disable_vsync=true \
    hwui.print_config=choice \
    debug.enabletr=false

# Set dirty_ratio for UMS
PRODUCT_PROPERTY_OVERRIDES += ro.vold.umsdirtyratio=20

ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := device/htc/inc/prebuilt/root/kernel
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Script to signal boot completion for init.d
PRODUCT_COPY_FILES += \
    device/htc/speedy/prebuilt/system/etc/init.d/100complete:system/etc/init.d/100complete

# common qsd8k configs
$(call inherit-product, device/htc/qsd8k-common/qsd8k.mk)

# stuff common to all HTC phones
$(call inherit-product, device/htc/common/common.mk)

$(call inherit-product, build/target/product/full_base.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := htc_inc
PRODUCT_DEVICE := inc
PRODUCT_MODEL := Droid Incredible
PRODUCT_MANUFACTURER := HTC
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_FINGERPRINT=verizon_wwe/inc/inc/inc:2.3.4/GRJ22/185897.2:user/release-keys PRIVATE_BUILD_DESC="4.08.605.2 CL185897 release-keys"

# USB
ADDITIONAL_DEFAULT_PROPERTIES += persist.sys.usb.config=mass_storage
