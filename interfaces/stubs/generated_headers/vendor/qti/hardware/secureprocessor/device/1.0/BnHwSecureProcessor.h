#ifndef HIDL_GENERATED_VENDOR_QTI_HARDWARE_SECUREPROCESSOR_DEVICE_V1_0_BNHWSECUREPROCESSOR_H
#define HIDL_GENERATED_VENDOR_QTI_HARDWARE_SECUREPROCESSOR_DEVICE_V1_0_BNHWSECUREPROCESSOR_H

#include <vendor/qti/hardware/secureprocessor/device/1.0/IHwSecureProcessor.h>

namespace vendor {
namespace qti {
namespace hardware {
namespace secureprocessor {
namespace device {
namespace V1_0 {

struct BnHwSecureProcessor : public ::android::hidl::base::V1_0::BnHwBase {
    explicit BnHwSecureProcessor(const ::android::sp<ISecureProcessor> &_hidl_impl);
    explicit BnHwSecureProcessor(const ::android::sp<ISecureProcessor> &_hidl_impl, const std::string& HidlInstrumentor_package, const std::string& HidlInstrumentor_interface);

    virtual ~BnHwSecureProcessor();

    ::android::status_t onTransact(
            uint32_t _hidl_code,
            const ::android::hardware::Parcel &_hidl_data,
            ::android::hardware::Parcel *_hidl_reply,
            uint32_t _hidl_flags = 0,
            TransactCallback _hidl_cb = nullptr) override;


    /**
     * The pure class is what this class wraps.
     */
    typedef ISecureProcessor Pure;

    /**
     * Type tag for use in template logic that indicates this is a 'native' class.
     */
    typedef ::android::hardware::details::bnhw_tag _hidl_tag;

    ::android::sp<ISecureProcessor> getImpl() { return _hidl_mImpl; }

private:
    // Methods from ::android::hidl::base::V1_0::IBase follow.
    ::android::hardware::Return<void> ping();
    using getDebugInfo_cb = ::android::hidl::base::V1_0::IBase::getDebugInfo_cb;
    ::android::hardware::Return<void> getDebugInfo(getDebugInfo_cb _hidl_cb);

    ::android::sp<ISecureProcessor> _hidl_mImpl;
};

}  // namespace V1_0
}  // namespace device
}  // namespace secureprocessor
}  // namespace hardware
}  // namespace qti
}  // namespace vendor

#endif  // HIDL_GENERATED_VENDOR_QTI_HARDWARE_SECUREPROCESSOR_DEVICE_V1_0_BNHWSECUREPROCESSOR_H
