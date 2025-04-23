#ifndef HIDL_GENERATED_VENDOR_SEMC_HARDWARE_MMWAVEDIRECTION_V1_1_BNHWMMWAVEDIRECTION_H
#define HIDL_GENERATED_VENDOR_SEMC_HARDWARE_MMWAVEDIRECTION_V1_1_BNHWMMWAVEDIRECTION_H

#include <vendor/semc/hardware/mmwavedirection/1.1/IHwMmwavedirection.h>

namespace vendor {
namespace semc {
namespace hardware {
namespace mmwavedirection {
namespace V1_1 {

struct BnHwMmwavedirection : public ::android::hidl::base::V1_0::BnHwBase {
    explicit BnHwMmwavedirection(const ::android::sp<IMmwavedirection> &_hidl_impl);
    explicit BnHwMmwavedirection(const ::android::sp<IMmwavedirection> &_hidl_impl, const std::string& HidlInstrumentor_package, const std::string& HidlInstrumentor_interface);

    virtual ~BnHwMmwavedirection();

    ::android::status_t onTransact(
            uint32_t _hidl_code,
            const ::android::hardware::Parcel &_hidl_data,
            ::android::hardware::Parcel *_hidl_reply,
            uint32_t _hidl_flags = 0,
            TransactCallback _hidl_cb = nullptr) override;


    /**
     * The pure class is what this class wraps.
     */
    typedef IMmwavedirection Pure;

    /**
     * Type tag for use in template logic that indicates this is a 'native' class.
     */
    typedef ::android::hardware::details::bnhw_tag _hidl_tag;

    ::android::sp<IMmwavedirection> getImpl() { return _hidl_mImpl; }

private:
    // Methods from ::android::hidl::base::V1_0::IBase follow.
    ::android::hardware::Return<void> ping();
    using getDebugInfo_cb = ::android::hidl::base::V1_0::IBase::getDebugInfo_cb;
    ::android::hardware::Return<void> getDebugInfo(getDebugInfo_cb _hidl_cb);

    ::android::sp<IMmwavedirection> _hidl_mImpl;
};

}  // namespace V1_1
}  // namespace mmwavedirection
}  // namespace hardware
}  // namespace semc
}  // namespace vendor

#endif  // HIDL_GENERATED_VENDOR_SEMC_HARDWARE_MMWAVEDIRECTION_V1_1_BNHWMMWAVEDIRECTION_H
