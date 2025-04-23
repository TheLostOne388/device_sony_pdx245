#ifndef HIDL_GENERATED_VENDOR_QTI_HARDWARE_AGMIPC_V1_0_BNHWAGM_H
#define HIDL_GENERATED_VENDOR_QTI_HARDWARE_AGMIPC_V1_0_BNHWAGM_H

#include <vendor/qti/hardware/AGMIPC/1.0/IHwAGM.h>

namespace vendor {
namespace qti {
namespace hardware {
namespace AGMIPC {
namespace V1_0 {

struct BnHwAGM : public ::android::hidl::base::V1_0::BnHwBase {
    explicit BnHwAGM(const ::android::sp<IAGM> &_hidl_impl);
    explicit BnHwAGM(const ::android::sp<IAGM> &_hidl_impl, const std::string& HidlInstrumentor_package, const std::string& HidlInstrumentor_interface);

    virtual ~BnHwAGM();

    ::android::status_t onTransact(
            uint32_t _hidl_code,
            const ::android::hardware::Parcel &_hidl_data,
            ::android::hardware::Parcel *_hidl_reply,
            uint32_t _hidl_flags = 0,
            TransactCallback _hidl_cb = nullptr) override;


    /**
     * The pure class is what this class wraps.
     */
    typedef IAGM Pure;

    /**
     * Type tag for use in template logic that indicates this is a 'native' class.
     */
    typedef ::android::hardware::details::bnhw_tag _hidl_tag;

    ::android::sp<IAGM> getImpl() { return _hidl_mImpl; }

private:
    // Methods from ::android::hidl::base::V1_0::IBase follow.
    ::android::hardware::Return<void> ping();
    using getDebugInfo_cb = ::android::hidl::base::V1_0::IBase::getDebugInfo_cb;
    ::android::hardware::Return<void> getDebugInfo(getDebugInfo_cb _hidl_cb);

    ::android::sp<IAGM> _hidl_mImpl;
};

}  // namespace V1_0
}  // namespace AGMIPC
}  // namespace hardware
}  // namespace qti
}  // namespace vendor

#endif  // HIDL_GENERATED_VENDOR_QTI_HARDWARE_AGMIPC_V1_0_BNHWAGM_H
