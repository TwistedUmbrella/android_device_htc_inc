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
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# WARNING: This line must come *before* including the proprietary
# variant, so that it gets overwritten by the parent (which goes
# against the traditional rules of inheritance).
USE_CAMERA_STUB := false

# inherit from common qsd8k device
-include device/htc/qsd8k-common/BoardConfigCommon.mk

# inherit from the proprietary version
-include vendor/htc/supersonic/BoardConfigVendor.mk

TARGET_NO_BOOTLOADER := true

TARGET_BOARD_PLATFORM := qsd8k
TARGET_BOARD_PLATFORM_GPU := qcom-adreno200

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true

TARGET_BOOTLOADER_BOARD_NAME := inc
# TARGET_SPECIFIC_HEADER_PATH := device/htc/inc/include
TARGET_SPECIFIC_HEADER_PATH := device/htc/qsd8k-common/include

# Legacy support flags
BOARD_USE_LEGACY_TRACKPAD := true

BOARD_HAS_SCREEN_OFF_FLICKER := true

BOARD_KERNEL_CMDLINE := no_console_suspend=1
BOARD_KERNEL_BASE := 0x20000000
BOARD_KERNEL_NEW_PPPOX := true

BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true

BOARD_VENDOR_QCOM_AMSS_VERSION := 3200

BOARD_HAVE_HTC_FFC := true
BOARD_USE_REVERSE_FFC := true
BOARD_USE_FROYO_LIBCAMERA := true

BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := inc

BOARD_HAVE_SQN_WIMAX := true

TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/usb_mass_storage/lun0/file

# cat /proc/mtd
# dev:    size   erasesize  name
# mtd0: 000a0000 00020000 "misc"
# mtd1: 00480000 00020000 "recovery"
# mtd2: 00300000 00020000 "boot"
# mtd3: 0f800000 00020000 "system"
# mtd4: 000a0000 00020000 "local"
# mtd5: 02800000 00020000 "cache"
# mtd6: 09500000 00020000 "datadata"
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x00300000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x00480000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 0x0f800000   # limited so we enforce room to grow
BOARD_USERDATAIMAGE_PARTITION_SIZE := 0x09500000

BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_RELEASETOOLS_EXTENSIONS := device/htc/common
TARGET_PREBUILT_KERNEL := device/htc/inc/prebuilt/root/kernel

BOARD_HAS_DATADATA := true
BOARD_SDCARD_DEVICE_PRIMARY := /dev/block/mmcblk1p1
BOARD_SDCARD_DEVICE_SECONDARY := /dev/block/mmcblk1
BOARD_SDEXT_DEVICE := /dev/block/mmcblk1p2
BOARD_DATA_DEVICE := /dev/block/mmcblk0p1
BOARD_DATA_FILESYSTEM := auto
BOARD_CACHE_DEVICE := /dev/block/mmcblk0p2
BOARD_CACHE_FILESYSTEM := auto

# Make sure vold formats the proper sdcard partition
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
