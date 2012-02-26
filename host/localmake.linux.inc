#
#  Local Makefile includes for tool and kernel source paths
# 
#  Copyright 2004-2010 Atheros Communications, Inc.
#
# When creating a new build type, use the following template:
#  	ifeq ($(ATH_BUILD_TYPE),<platform name>) 
#       ATH_ARCH_CPU_TYPE :=  < cpu architecture >
#       ATH_CROSS_COMPILE_TYPE := < cross compiler path >
#       ATH_LINUXPATH := < kernel source path >

ATH_BSP_TYPE=Folio100
#ATH_ANDROID_ROOT=< android sdk full path >

# Kernel path
ATH_LINUXPATH := /home/artem/bin/new-kernel/android-tegra-nv-3.1
#ATH_LINUXPATH := /home/artem/bin/new-kernel/android-tegra-nv-2.6.39
#ATH_LINUXPATH := /home/artem/bin/new-kernel/nvidia/linux-2.6

ifneq (0, $(shell test -d $(ATH_LINUXPATH) && echo $$?))
$(error $(ATH_LINUXPATH) does not exist)
endif

$(info *************************)
$(info PLATFORM: $(ATH_BUILD_TYPE))
$(info BSP:      $(ATH_BSP_TYPE))
$(info *************************)
# Some environment settings
#ATH_BUILD_TYPE=$(ATH_BSP_TYPE)_ARM_NATIVEMMC
ATH_BUILD_TYPE=ANDROID_ARM_NATIVEMMC
ATH_ANDROID_ENV:=yes
ATH_SOFTMAC_FILE_USED:=yes
ATH_DEBUG_DRIVER:=yes
ATH_HTC_RAW_INT_ENV:=yes
ATH_AR6K_OTA_TEST_MODE:=no

# Some common variable
ATH_ARCH_CPU_TYPE:=arm
ATH_CROSS_COMPILE_TYPE:=/home/artem/bin/cyanogen/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-
ATH_BUS_TYPE:=SDIO
ATH_OS_SUB_TYPE := linux_2_6
ATH_BUS_SUBTYPE := linux_sdio
ATH_BUILD_3RDPARTY := yes
ATH_CFG80211_ENV := no
ATH_BUILD_SYSTEM_TOOLS:=no
ATH_AR6K_HCI_PAL:=yes
ATH_AR6K_BUILTIN_HCI_PAL:=yes
ATH_AR6K_DEBUG_ALLOC:=no
ATH_AR6K_HCI_BRIDGE:=yes
ATH_AR6K_BUILTIN_HCI_TRANSPORT:=yes
