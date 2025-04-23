#!/bin/bash

# This script generates stub HAL implementations for interfaces
# referenced in compatibility matrices that are missing from the build

DEVICE_DIR=$(dirname $(realpath $0))/..
INTERFACES_DIR=$DEVICE_DIR/vintf/interfaces

# Create directory structure for stubs
mkdir -p $INTERFACES_DIR/vendor/semc/hardware/aidlcharger
mkdir -p $INTERFACES_DIR/vendor/semc/hardware/aidldisplay
mkdir -p $INTERFACES_DIR/vendor/semc/hardware/aidlthermal
mkdir -p $INTERFACES_DIR/vendor/semc/hardware/extlight
mkdir -p $INTERFACES_DIR/vendor/semc/hardware/spc
mkdir -p $INTERFACES_DIR/vendor/semc/system/idd/aidl
mkdir -p $INTERFACES_DIR/vendor/somc/hardware/aidlifaa
mkdir -p $INTERFACES_DIR/vendor/somc/hardware/aidlmiscta
mkdir -p $INTERFACES_DIR/vendor/somc/hardware/aidlnfc
mkdir -p $INTERFACES_DIR/vendor/somc/hardware/aidlsensor
mkdir -p $INTERFACES_DIR/vendor/somc/hardware/aidlsuperstamina
mkdir -p $INTERFACES_DIR/vendor/somc/hardware/aidlwifidriver
mkdir -p $INTERFACES_DIR/vendor/somc/hardware/camera/provider
mkdir -p $INTERFACES_DIR/vendor/somc/hardware/perfagent
mkdir -p $INTERFACES_DIR/vendor/somc/hardware/radio/aidl
mkdir -p $INTERFACES_DIR/vendor/somc/hardware/security/aidlsecd
mkdir -p $INTERFACES_DIR/vendor/somc/hardware/videoeffect
mkdir -p $INTERFACES_DIR/vendor/somc/hardware/wifi/idd
mkdir -p $INTERFACES_DIR/vendor/hardware/biometrics/fingerprintRbs
mkdir -p $INTERFACES_DIR/android/hardware/fingerprint/aidl
mkdir -p $INTERFACES_DIR/vendor/semc/hardware/charger/aidl
mkdir -p $INTERFACES_DIR/vendor/semc/hardware/mmwavedirection/aidl

# Generate a master Android.bp file with all stub interfaces
cat > $INTERFACES_DIR/Android.bp << 'EOF'
// Auto-generated stub interfaces for VINTF compatibility

soong_namespace {
    // Use a unique namespace to avoid conflicts
    imports: [
        "hardware/interfaces",
        "system/libhidl/transport",
    ],
}

// Disable clang-format for this file
// clang-format off

// Add required package roots for HIDL interfaces
hidl_package_root {
    name: "vendor.semc.hardware.charger",
    path: "device/sony/pdx245/vintf/interfaces",
}

hidl_package_root {
    name: "vendor.semc.hardware.mmwavedirection",
    path: "device/sony/pdx245/vintf/interfaces",
}

hidl_package_root {
    name: "vendor.semc.system.idd",
    path: "device/sony/pdx245/vintf/interfaces",
}

hidl_package_root {
    name: "vendor.somc.hardware.radio",
    path: "device/sony/pdx245/vintf/interfaces",
}

hidl_package_root {
    name: "android.hardware.fingerprint",
    path: "device/sony/pdx245/vintf/interfaces",
}
EOF

# Add stubs for AIDL interfaces
declare -a AIDL_INTERFACES=(
    "vendor.semc.hardware.aidlcharger:ICharger"
    "vendor.semc.hardware.aidldisplay:IDisplay"
    "vendor.semc.hardware.aidlthermal:IThermal"
    "vendor.semc.hardware.extlight:IExtLight"
    "vendor.semc.hardware.spc:ISpc"
    "vendor.somc.hardware.aidlifaa:IIFAAManagerService"
    "vendor.somc.hardware.aidlmiscta:IMisctaGlobal"
    "vendor.somc.hardware.aidlnfc:ISomcNfc"
    "vendor.somc.hardware.aidlsensor:ISensorCalibration"
    "vendor.somc.hardware.aidlsuperstamina:ISuperStamina"
    "vendor.somc.hardware.aidlwifidriver:ISomcWifiDriver"
    "vendor.somc.hardware.camera.provider:ICameraProvider"
    "vendor.somc.hardware.perfagent:IPerfAgent"
    "vendor.somc.hardware.security.aidlsecd:IDeviceSecurity"
    "vendor.somc.hardware.videoeffect:IAidlSwiqi"
    "vendor.somc.hardware.wifi.idd:ISomcWifiIdd"
    "vendor.hardware.biometrics.fingerprintRbs:IFingerprintRbs"
    # Convert HIDL to AIDL - added these below to create AIDL versions
    "android.hardware.fingerprint.aidl:IBiometricsFingerprint"
    "vendor.semc.hardware.charger.aidl:ICharger"
    "vendor.semc.hardware.mmwavedirection.aidl:IMmwavedirection"
    "vendor.semc.system.idd.aidl:IIdd"
    "vendor.somc.hardware.radio.aidl:ISomcHook"
)

for aidl in "${AIDL_INTERFACES[@]}"; do
    IFS=: read -r package interface <<< "$aidl"
    dir_path=$(echo $package | tr . /)
    mkdir -p $INTERFACES_DIR/$dir_path
    
    # Create .aidl interface file
    cat > $INTERFACES_DIR/$dir_path/$interface.aidl << EOF
package $package;

@VintfStability
interface $interface {
    boolean isAlive();
}
EOF

    # Add aidl_interface to Android.bp - Adding a '_stub' suffix to avoid namespace conflicts
    cat >> $INTERFACES_DIR/Android.bp << EOF

aidl_interface {
    name: "${package}_stub",
    vendor: true,
    owner: "sony",
    srcs: ["$dir_path/$interface.aidl"],
    stability: "vintf",
    backend: {
        java: {
            enabled: false,
        },
        cpp: {
            enabled: true,
        },
    },
    versions: [],
}
EOF
done

echo "Stub HAL implementations have been generated in $INTERFACES_DIR" 