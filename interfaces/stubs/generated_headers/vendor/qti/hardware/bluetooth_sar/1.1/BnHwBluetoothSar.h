#ifndef HIDL_GENERATED_VENDOR_QTI_HARDWARE_BLUETOOTH_SAR_V1_1_BNHWBLUETOOTHSAR_H
#define HIDL_GENERATED_VENDOR_QTI_HARDWARE_BLUETOOTH_SAR_V1_1_BNHWBLUETOOTHSAR_H

#include <vendor/qti/hardware/bluetooth_sar/1.1/IHwBluetoothSar.h>

namespace vendor {
namespace qti {
namespace hardware {
namespace bluetooth_sar {
namespace V1_1 {

struct BnHwBluetoothSar : public ::android::hidl::base::V1_0::BnHwBase {
    explicit BnHwBluetoothSar(const ::android::sp<IBluetoothSar> &_hidl_impl);
    explicit BnHwBluetoothSar(const ::android::sp<IBluetoothSar> &_hidl_impl, const std::string& HidlInstrumentor_package, const std::string& HidlInstrumentor_interface);

    virtual ~BnHwBluetoothSar();

    ::android::status_t onTransact(
            uint32_t _hidl_code,
            const ::android::hardware::Parcel &_hidl_data,
            ::android::hardware::Parcel *_hidl_reply,
            uint32_t _hidl_flags = 0,
            TransactCallback _hidl_cb = nullptr) override;


    /**
     * The pure class is what this class wraps.
     */
    typedef IBluetoothSar Pure;

    /**
     * Type tag for use in template logic that indicates this is a 'native' class.
     */
    typedef ::android::hardware::details::bnhw_tag _hidl_tag;

    ::android::sp<IBluetoothSar> getImpl() { return _hidl_mImpl; }

private:
    // Methods from ::android::hidl::base::V1_0::IBase follow.
    ::android::hardware::Return<void> ping();
    using getDebugInfo_cb = ::android::hidl::base::V1_0::IBase::getDebugInfo_cb;
    ::android::hardware::Return<void> getDebugInfo(getDebugInfo_cb _hidl_cb);

    ::android::sp<IBluetoothSar> _hidl_mImpl;
};

}  // namespace V1_1
}  // namespace bluetooth_sar
}  // namespace hardware
}  // namespace qti
}  // namespace vendor

#endif  // HIDL_GENERATED_VENDOR_QTI_HARDWARE_BLUETOOTH_SAR_V1_1_BNHWBLUETOOTHSAR_H
