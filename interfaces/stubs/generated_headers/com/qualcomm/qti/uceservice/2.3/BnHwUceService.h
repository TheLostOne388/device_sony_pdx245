#ifndef HIDL_GENERATED_COM_QUALCOMM_QTI_UCESERVICE_V2_3_BNHWUCESERVICE_H
#define HIDL_GENERATED_COM_QUALCOMM_QTI_UCESERVICE_V2_3_BNHWUCESERVICE_H

#include <com/qualcomm/qti/uceservice/2.3/IHwUceService.h>

namespace com {
namespace qualcomm {
namespace qti {
namespace uceservice {
namespace V2_3 {

struct BnHwUceService : public ::android::hidl::base::V1_0::BnHwBase {
    explicit BnHwUceService(const ::android::sp<IUceService> &_hidl_impl);
    explicit BnHwUceService(const ::android::sp<IUceService> &_hidl_impl, const std::string& HidlInstrumentor_package, const std::string& HidlInstrumentor_interface);

    virtual ~BnHwUceService();

    ::android::status_t onTransact(
            uint32_t _hidl_code,
            const ::android::hardware::Parcel &_hidl_data,
            ::android::hardware::Parcel *_hidl_reply,
            uint32_t _hidl_flags = 0,
            TransactCallback _hidl_cb = nullptr) override;


    /**
     * The pure class is what this class wraps.
     */
    typedef IUceService Pure;

    /**
     * Type tag for use in template logic that indicates this is a 'native' class.
     */
    typedef ::android::hardware::details::bnhw_tag _hidl_tag;

    ::android::sp<IUceService> getImpl() { return _hidl_mImpl; }

private:
    // Methods from ::android::hidl::base::V1_0::IBase follow.
    ::android::hardware::Return<void> ping();
    using getDebugInfo_cb = ::android::hidl::base::V1_0::IBase::getDebugInfo_cb;
    ::android::hardware::Return<void> getDebugInfo(getDebugInfo_cb _hidl_cb);

    ::android::sp<IUceService> _hidl_mImpl;
};

}  // namespace V2_3
}  // namespace uceservice
}  // namespace qti
}  // namespace qualcomm
}  // namespace com

#endif  // HIDL_GENERATED_COM_QUALCOMM_QTI_UCESERVICE_V2_3_BNHWUCESERVICE_H
