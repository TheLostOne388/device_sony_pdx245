#ifndef HIDL_GENERATED_VENDOR_SOMC_HARDWARE_RADIO_V1_0_BNHWSOMCHOOK_H
#define HIDL_GENERATED_VENDOR_SOMC_HARDWARE_RADIO_V1_0_BNHWSOMCHOOK_H

#include <vendor/somc/hardware/radio/1.0/IHwSomcHook.h>

namespace vendor {
namespace somc {
namespace hardware {
namespace radio {
namespace V1_0 {

struct BnHwSomcHook : public ::android::hidl::base::V1_0::BnHwBase {
    explicit BnHwSomcHook(const ::android::sp<ISomcHook> &_hidl_impl);
    explicit BnHwSomcHook(const ::android::sp<ISomcHook> &_hidl_impl, const std::string& HidlInstrumentor_package, const std::string& HidlInstrumentor_interface);

    virtual ~BnHwSomcHook();

    ::android::status_t onTransact(
            uint32_t _hidl_code,
            const ::android::hardware::Parcel &_hidl_data,
            ::android::hardware::Parcel *_hidl_reply,
            uint32_t _hidl_flags = 0,
            TransactCallback _hidl_cb = nullptr) override;


    /**
     * The pure class is what this class wraps.
     */
    typedef ISomcHook Pure;

    /**
     * Type tag for use in template logic that indicates this is a 'native' class.
     */
    typedef ::android::hardware::details::bnhw_tag _hidl_tag;

    ::android::sp<ISomcHook> getImpl() { return _hidl_mImpl; }

private:
    // Methods from ::android::hidl::base::V1_0::IBase follow.
    ::android::hardware::Return<void> ping();
    using getDebugInfo_cb = ::android::hidl::base::V1_0::IBase::getDebugInfo_cb;
    ::android::hardware::Return<void> getDebugInfo(getDebugInfo_cb _hidl_cb);

    ::android::sp<ISomcHook> _hidl_mImpl;
};

}  // namespace V1_0
}  // namespace radio
}  // namespace hardware
}  // namespace somc
}  // namespace vendor

#endif  // HIDL_GENERATED_VENDOR_SOMC_HARDWARE_RADIO_V1_0_BNHWSOMCHOOK_H
