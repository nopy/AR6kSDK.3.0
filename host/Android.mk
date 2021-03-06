#------------------------------------------------------------------------------
# <copyright file="makefile" company="Atheros">
#    Copyright (c) 2005-2010 Atheros Corporation.  All rights reserved.
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation;
#
# Software distributed under the License is distributed on an "AS
# IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
# implied. See the License for the specific language governing
# rights and limitations under the License.
#
#
#------------------------------------------------------------------------------
#==============================================================================
# Author(s): ="Atheros"
#==============================================================================

ifneq ($(TARGET_SIMULATOR),true)

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

#ATH_ANDROID_SRC_BASE:= $(BOARD_WLAN_ATHEROS_SDK)
ATH_ANDROID_SRC_BASE:= $(LOCAL_PATH)
export ATH_BSP_TYPE=Folio100
export  ATH_BUILD_TYPE=ANDROID_ARM_NATIVEMMC
export  ATH_BUS_TYPE=sdio
export  ATH_OS_SUB_TYPE=linux_2_6

ATH_ANDROID_ROOT:= $(CURDIR)
#export ATH_SRC_BASE:= ../$(ATH_ANDROID_SRC_BASE)/host
export ATH_SRC_BASE:=$(ATH_ANDROID_ROOT)/$(ATH_ANDROID_SRC_BASE)

#ATH_CROSS_COMPILE_TYPE:=$(ATH_ANDROID_ROOT)/$(TARGET_TOOLS_PREFIX)
ATH_CROSS_COMPILE_TYPE:=$(ATH_ANDROID_ROOT)/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-
ATH_FULL_TARGET_OUTPUT:= $(ATH_ANDROID_ROOT)/$(TARGET_OUT_INTERMEDIATES)/atheros
ATH_TARGET_OUTPUT:= $(TARGET_OUT_INTERMEDIATES)/atheros

#ifeq ($(TARGET_PRODUCT),$(filter $(TARGET_PRODUCT),qsd8250_surf qsd8250_ffa msm7627_surf msm7627_ffa msm7625_ffa msm7625_surf msm7630_surf))
#export  ATH_LINUXPATH=$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ
#else
# Comment out the following variable for your platform 
# Link your kernel into android SDK directory as 'kernel' directory
export  ATH_LINUXPATH=$(ATH_ANDROID_ROOT)/$(TARGET_OUT_INTERMEDIATES)/kernel
#endif 
export  ATH_ARCH_CPU_TYPE=arm
export  ATH_BUS_SUBTYPE=linux_sdio
export  ATH_BUILD_3RDPARTY=yes
export ATH_CFG80211_ENV=no
export ATH_BUILD_SYSTEM_TOOLS=no
export ATH_AR6K_HCI_PAL=yes
export ATH_AR6K_BUILTIN_HCI_PAL=yes
export ATH_AR6K_DEBUG_ALLOC=no
export ATH_AR6K_HCI_BRIDGE=yes
export ATH_AR6K_BUILTIN_HCI_TRANSPORT=yes
export ATH_ANDROID_ENV=yes
export ATH_SOFTMAC_FILE_USED=yes
export ATH_DEBUG_DRIVER=yes
export ATH_HTC_RAW_INT_ENV=yes
export ATH_AR6K_OTA_TEST_MODE=no
export ATH_BUILD_OUTPUT_OVERRIDE=$(ATH_FULL_TARGET_OUTPUT)


ATH_HIF_TYPE:=sdio

#Uncomment the following define in order to enable OTA mode
#ATH_ANDROID_BUILD_FLAGS += -DATH6K_CONFIG_OTA_MODE

export ATH_ANDROID_BUILD_FLAGS

mod_cleanup := $(ATH_TARGET_OUTPUT)

$(mod_cleanup) :
	mkdir -p  $(ATH_TARGET_OUTPUT)
	rm -f `find $(ATH_SRC_BASE) -name "*.o"`
	rm -f `find $(ATH_SRC_BASE) -name "*.ko"`
	rm -f `find $(ATH_SRC_BASE) -name "*.o.cmd"`
	mkdir -p $(TARGET_OUT)/wifi/ath6k/AR6003/hw2.0/
    
mod_file := $(ATH_ANDROID_SRC_BASE)/os/linux/ar6000.ko
$(mod_file) : $(mod_cleanup) $(INSTALLED_KERNEL_TARGET)  $(ACP)
	$(MAKE) ARCH=arm CROSS_COMPILE=$(ATH_CROSS_COMPILE_TYPE) -C $(ATH_LINUXPATH) ATH_BUILD_OUTPUT_OVERRIDE=$(ATH_FULL_TARGET_OUTPUT) O=$(ATH_FULL_TARGET_OUTPUT) ATH_HIF_TYPE=$(ATH_HIF_TYPE) SUBDIRS=$(ATH_SRC_BASE)/os/linux modules
	$(ATH_CROSS_COMPILE_TYPE)strip --strip-unneeded $(ATH_SRC_BASE)/os/linux/ar6000.ko

#$(TARGET_OUT)/wifi/ar6000.ko
include $(LOCAL_PATH)/tools/Android.mk

endif
