#ifndef HIDL_GENERATED_COM_QUALCOMM_QTI_IMSCMSERVICE_V2_2_BNHWIMSCMSERVICE_H
#define HIDL_GENERATED_COM_QUALCOMM_QTI_IMSCMSERVICE_V2_2_BNHWIMSCMSERVICE_H

#include <com/qualcomm/qti/imscmservice/2.2/IHwImsCmService.h>

namespace com {
namespace qualcomm {
namespace qti {
namespace imscmservice {
namespace V2_2 {

struct BnHwImsCmService : public ::android::hidl::base::V1_0::BnHwBase {
    explicit BnHwImsCmService(const ::android::sp<IImsCmService> &_hidl_impl);
    explicit BnHwImsCmService(const ::android::sp<IImsCmService> &_hidl_impl, const std::string& HidlInstrumentor_package, const std::string& HidlInstrumentor_interface);

    virtual ~BnHwImsCmService();

    ::android::status_t onTransact(
            uint32_t _hidl_code,
            const ::android::hardware::Parcel &_hidl_data,
            ::android::hardware::Parcel *_hidl_reply,
            uint32_t _hidl_flags = 0,
            TransactCallback _hidl_cb = nullptr) override;


    /**
     * The pure class is what this class wraps.
     */
    typedef IImsCmService Pure;

    /**
     * Type tag for use in template logic that indicates this is a 'native' class.
     */
    typedef ::android::hardware::details::bnhw_tag _hidl_tag;

    ::android::sp<IImsCmService> getImpl() { return _hidl_mImpl; }

private:
    // Methods from ::android::hidl::base::V1_0::IBase follow.
    ::android::hardware::Return<void> ping();
    using getDebugInfo_cb = ::android::hidl::base::V1_0::IBase::getDebugInfo_cb;
    ::android::hardware::Return<void> getDebugInfo(getDebugInfo_cb _hidl_cb);

    ::android::sp<IImsCmService> _hidl_mImpl;
};

}  // namespace V2_2
}  // namespace imscmservice
}  // namespace qti
}  // namespace qualcomm
}  // namespace com

#endif  // HIDL_GENERATED_COM_QUALCOMM_QTI_IMSCMSERVICE_V2_2_BNHWIMSCMSERVICE_H
