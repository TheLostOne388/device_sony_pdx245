#ifndef HIDL_GENERATED_COM_QUALCOMM_QTI_DPM_API_V1_0_BNHWDPMQMI_H
#define HIDL_GENERATED_COM_QUALCOMM_QTI_DPM_API_V1_0_BNHWDPMQMI_H

#include <com/qualcomm/qti/dpm/api/1.0/IHwdpmQmi.h>

namespace com {
namespace qualcomm {
namespace qti {
namespace dpm {
namespace api {
namespace V1_0 {

struct BnHwdpmQmi : public ::android::hidl::base::V1_0::BnHwBase {
    explicit BnHwdpmQmi(const ::android::sp<IdpmQmi> &_hidl_impl);
    explicit BnHwdpmQmi(const ::android::sp<IdpmQmi> &_hidl_impl, const std::string& HidlInstrumentor_package, const std::string& HidlInstrumentor_interface);

    virtual ~BnHwdpmQmi();

    ::android::status_t onTransact(
            uint32_t _hidl_code,
            const ::android::hardware::Parcel &_hidl_data,
            ::android::hardware::Parcel *_hidl_reply,
            uint32_t _hidl_flags = 0,
            TransactCallback _hidl_cb = nullptr) override;


    /**
     * The pure class is what this class wraps.
     */
    typedef IdpmQmi Pure;

    /**
     * Type tag for use in template logic that indicates this is a 'native' class.
     */
    typedef ::android::hardware::details::bnhw_tag _hidl_tag;

    ::android::sp<IdpmQmi> getImpl() { return _hidl_mImpl; }

private:
    // Methods from ::android::hidl::base::V1_0::IBase follow.
    ::android::hardware::Return<void> ping();
    using getDebugInfo_cb = ::android::hidl::base::V1_0::IBase::getDebugInfo_cb;
    ::android::hardware::Return<void> getDebugInfo(getDebugInfo_cb _hidl_cb);

    ::android::sp<IdpmQmi> _hidl_mImpl;
};

}  // namespace V1_0
}  // namespace api
}  // namespace dpm
}  // namespace qti
}  // namespace qualcomm
}  // namespace com

#endif  // HIDL_GENERATED_COM_QUALCOMM_QTI_DPM_API_V1_0_BNHWDPMQMI_H
