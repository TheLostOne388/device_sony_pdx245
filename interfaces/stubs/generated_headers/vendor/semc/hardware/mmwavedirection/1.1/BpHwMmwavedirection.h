#ifndef HIDL_GENERATED_VENDOR_SEMC_HARDWARE_MMWAVEDIRECTION_V1_1_BPHWMMWAVEDIRECTION_H
#define HIDL_GENERATED_VENDOR_SEMC_HARDWARE_MMWAVEDIRECTION_V1_1_BPHWMMWAVEDIRECTION_H

#include <hidl/HidlTransportSupport.h>

#include <vendor/semc/hardware/mmwavedirection/1.1/IHwMmwavedirection.h>

#include <mutex>
namespace vendor {
namespace semc {
namespace hardware {
namespace mmwavedirection {
namespace V1_1 {

struct BpHwMmwavedirection : public ::android::hardware::BpInterface<IMmwavedirection>, public ::android::hardware::details::HidlInstrumentor {
    explicit BpHwMmwavedirection(const ::android::sp<::android::hardware::IBinder> &_hidl_impl);

    /**
     * The pure class is what this class wraps.
     */
    typedef IMmwavedirection Pure;

    /**
     * Type tag for use in template logic that indicates this is a 'proxy' class.
     */
    typedef ::android::hardware::details::bphw_tag _hidl_tag;

    virtual bool isRemote() const override { return true; }

    void onLastStrongRef(const void* id) override;


    // Methods from ::android::hidl::base::V1_0::IBase follow.
    ::android::hardware::Return<void> interfaceChain(interfaceChain_cb _hidl_cb) override;
    ::android::hardware::Return<void> debug(const ::android::hardware::hidl_handle& fd, const ::android::hardware::hidl_vec<::android::hardware::hidl_string>& options) override;
    ::android::hardware::Return<void> interfaceDescriptor(interfaceDescriptor_cb _hidl_cb) override;
    ::android::hardware::Return<void> getHashChain(getHashChain_cb _hidl_cb) override;
    ::android::hardware::Return<void> setHALInstrumentation() override;
    ::android::hardware::Return<bool> linkToDeath(const ::android::sp<::android::hardware::hidl_death_recipient>& recipient, uint64_t cookie) override;
    ::android::hardware::Return<void> ping() override;
    ::android::hardware::Return<void> getDebugInfo(getDebugInfo_cb _hidl_cb) override;
    ::android::hardware::Return<void> notifySyspropsChanged() override;
    ::android::hardware::Return<bool> unlinkToDeath(const ::android::sp<::android::hardware::hidl_death_recipient>& recipient) override;

private:
    std::mutex _hidl_mMutex;
    std::vector<::android::sp<::android::hardware::hidl_binder_death_recipient>> _hidl_mDeathRecipients;
};

}  // namespace V1_1
}  // namespace mmwavedirection
}  // namespace hardware
}  // namespace semc
}  // namespace vendor

#endif  // HIDL_GENERATED_VENDOR_SEMC_HARDWARE_MMWAVEDIRECTION_V1_1_BPHWMMWAVEDIRECTION_H
