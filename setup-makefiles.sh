#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -ex  # Enable debugging (-x) and exit on errors (-e)

export DEVICE=pdx245
export DEVICE_COMMON=sm8650-common
export VENDOR=sony

# Use flags to prevent the scripts from being called more than once
if [ -z "${SETUP_MAKEFILES_DONE}" ]; then
    export SETUP_MAKEFILES_DONE=true

    # Debugging: Print environment variables
    echo "DEVICE: ${DEVICE}"
    echo "DEVICE_COMMON: ${DEVICE_COMMON}"
    echo "VENDOR: ${VENDOR}"
    echo "SETUP_MAKEFILES_DONE: ${SETUP_MAKEFILES_DONE}"

    # Clean up old versions of specific generated files only
    echo "Cleaning up old versions of generated files..."
    rm -fv /home/ubuntu/crDroid/vendor/sony/${DEVICE_COMMON}/Android.bp
    rm -fv /home/ubuntu/crDroid/vendor/sony/${DEVICE_COMMON}/Android.mk
    rm -fv /home/ubuntu/crDroid/vendor/sony/${DEVICE_COMMON}/BoardConfigVendor.mk
    rm -fv /home/ubuntu/crDroid/vendor/sony/${DEVICE_COMMON}/sm8650-common-vendor.mk

    rm -fv /home/ubuntu/crDroid/vendor/sony/${DEVICE}/Android.bp
    rm -fv /home/ubuntu/crDroid/vendor/sony/${DEVICE}/Android.mk
    rm -fv /home/ubuntu/crDroid/vendor/sony/${DEVICE}/BoardConfigVendor.mk
    rm -fv /home/ubuntu/crDroid/vendor/sony/${DEVICE}/pdx245-vendor.mk

    # Run setup-makefiles for common if not already done
    if [ "${DEVICE}" != "${DEVICE_COMMON}" ]; then
        echo "Running setup-makefiles for common device: ${DEVICE_COMMON}"
        if [ -f "./../../${VENDOR}/${DEVICE_COMMON}/setup-makefiles.sh" ]; then
            "./../../${VENDOR}/${DEVICE_COMMON}/setup-makefiles.sh" "$@"
        fi
    fi

    # Run setup-makefiles for the device
    echo "Running setup-makefiles for device: ${DEVICE}"
    if [ -f "./../../${VENDOR}/${DEVICE}/setup-makefiles.sh" ]; then
        "./../../${VENDOR}/${DEVICE}/setup-makefiles.sh" "$@"
    fi
else
    echo "Setup-makefiles already done, skipping to prevent recursion."
fi
