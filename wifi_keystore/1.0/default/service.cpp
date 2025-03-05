#include <android/system/wifi/keystore/1.0/IKeystore.h>
#include <hidl/HidlTransportSupport.h>
#include <hidl/LegacySupport.h>

using ::android::hardware::configureRpcThreadpool;
using ::android::hardware::joinRpcThreadpool;
using ::android::system::wifi::keystore::V1_0::IKeystore;
using KeystoreStatusCode = ::android::system::wifi::keystore::V1_0::IKeystore::KeystoreStatusCode;
using ::android::hardware::Return;
using ::android::hardware::Void;
using ::android::sp;

struct Keystore : public IKeystore {
    Return<void> ping() override {
        return Void();
    }

    Return<void> getBlob(const ::android::hardware::hidl_string& key, IKeystore::getBlob_cb _hidl_cb) override {
        _hidl_cb(KeystoreStatusCode::SUCCESS, {});
        return Void();
    }

    Return<void> getPublicKey(const ::android::hardware::hidl_string& keyId, IKeystore::getPublicKey_cb _hidl_cb) override {
        _hidl_cb(KeystoreStatusCode::SUCCESS, {});
        return Void();
    }

    Return<void> sign(const ::android::hardware::hidl_string& keyId, const ::android::hardware::hidl_vec<uint8_t>& dataToSign, IKeystore::sign_cb _hidl_cb) override {
        _hidl_cb(KeystoreStatusCode::SUCCESS, {});
        return Void();
    }
};

int main() {
    sp<IKeystore> service = new Keystore();
    configureRpcThreadpool(1, true);
    android::status_t status = service->registerAsService("default");
    if (status != android::OK) {
        return -1;
    }
    joinRpcThreadpool();
    return 0;
}