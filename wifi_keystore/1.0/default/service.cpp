#include <hidl/HidlTransportSupport.h>
#include <android/system/wifi/keystore/1.0/IKeystore.h>
#include <utils/Log.h>

using android::sp;
using android::hardware::configureRpcThreadpool;
using android::hardware::joinRpcThreadpool;
using android::hardware::hidl_string;
using android::hardware::hidl_vec;
using android::hardware::Return;
using android::hardware::Void;
using android::system::wifi::keystore::V1_0::IKeystore;

struct KeystoreService : public IKeystore {
    Return<void> getBlob(const hidl_string& key, getBlob_cb _hidl_cb) override {
        ALOGI("getBlob: %s", key.c_str());
        hidl_vec<uint8_t> result = {1, 2, 3};
        _hidl_cb(IKeystore::KeystoreStatusCode::SUCCESS, result);
        return Void();
    }

    Return<void> getPublicKey(const hidl_string& keyId, getPublicKey_cb _hidl_cb) override {
        ALOGI("getPublicKey: %s", keyId.c_str());
        hidl_vec<uint8_t> result = {4, 5, 6};
        _hidl_cb(IKeystore::KeystoreStatusCode::SUCCESS, result);
        return Void();
    }

    Return<void> sign(const hidl_string& keyId, const hidl_vec<uint8_t>& dataToSign, sign_cb _hidl_cb) override {
        ALOGI("sign: %s", keyId.c_str());
        _hidl_cb(IKeystore::KeystoreStatusCode::SUCCESS, dataToSign);
        return Void();
    }
};

int main() {
    sp<IKeystore> service = new KeystoreService();
    configureRpcThreadpool(1, true);
    android::status_t status = service->registerAsService("default");
    if (status != android::OK) {
        ALOGE("Failed to register service: %d", status);
        return -1;
    }
    ALOGI("Service registered successfully");
    joinRpcThreadpool();
    return 0;
}