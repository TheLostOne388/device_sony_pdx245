#ifndef HIDL_GENERATED_VENDOR_SEMC_HARDWARE_CHARGER_V1_2_BNHWCHARGER_H
#define HIDL_GENERATED_VENDOR_SEMC_HARDWARE_CHARGER_V1_2_BNHWCHARGER_H

#include <vendor/semc/hardware/charger/1.2/IHwCharger.h>

namespace vendor {
namespace semc {
namespace hardware {
namespace charger {
namespace V1_2 {

struct BnHwCharger : public ::android::hidl::base::V1_0::BnHwBase {
    explicit BnHwCharger(const ::android::sp<ICharger> &_hidl_impl);
    explicit BnHwCharger(const ::android::sp<ICharger> &_hidl_impl, const std::string& HidlInstrumentor_package, const std::string& HidlInstrumentor_interface);

    virtual ~BnHwCharger();

    ::android::status_t onTransact(
            uint32_t _hidl_code,
            const ::android::hardware::Parcel &_hidl_data,
            ::android::hardware::Parcel *_hidl_reply,
            uint32_t _hidl_flags = 0,
            TransactCallback _hidl_cb = nullptr) override;


    /**
     * The pure class is what this class wraps.
     */
    typedef ICharger Pure;

    /**
     * Type tag for use in template logic that indicates this is a 'native' class.
     */
    typedef ::android::hardware::details::bnhw_tag _hidl_tag;

    ::android::sp<ICharger> getImpl() { return _hidl_mImpl; }

private:
    // Methods from ::android::hidl::base::V1_0::IBase follow.
    ::android::hardware::Return<void> ping();
    using getDebugInfo_cb = ::android::hidl::base::V1_0::IBase::getDebugInfo_cb;
    ::android::hardware::Return<void> getDebugInfo(getDebugInfo_cb _hidl_cb);

    ::android::sp<ICharger> _hidl_mImpl;
};

}  // namespace V1_2
}  // namespace charger
}  // namespace hardware
}  // namespace semc
}  // namespace vendor

#endif  // HIDL_GENERATED_VENDOR_SEMC_HARDWARE_CHARGER_V1_2_BNHWCHARGER_H
