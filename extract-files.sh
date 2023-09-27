#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
    vendor/lib64/libvendor.goodix.hardware.biometrics.fingerprint@2.1.so | vendor/lib64/vendor.qti.hardware.fingerprint@1.0.so | vendor/lib64/libgoodixhwfingerprint.so)
        # fingerprint: use libhidlbase-v32 for goodix
        grep -q "libhidlbase-v32.so" "${2}" || "${PATCHELF}" --replace-needed "libhidlbase.so" "libhidlbase-v32.so" "${2}"
        ;;
    esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=heart
export DEVICE_COMMON=sm8150-common
export VENDOR=lenovo

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
