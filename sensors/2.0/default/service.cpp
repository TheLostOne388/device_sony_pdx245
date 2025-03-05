#include <android/hardware/sensors/2.0/ISensors.h>
#include <hidl/HidlTransportSupport.h>
#include <hidl/LegacySupport.h>

using ::android::hardware::configureRpcThreadpool;
using ::android::hardware::joinRpcThreadpool;
using ::android::hardware::sensors::V2_0::ISensors;
using ::android::hardware::sensors::V1_0::OperationMode;
using ::android::hardware::sensors::V1_0::Result;
using ::android::hardware::sensors::V1_0::Event;
using ::android::hardware::sensors::V1_0::SharedMemInfo;
using ::android::hardware::sensors::V1_0::RateLevel;
using ::android::hardware::Return;
using ::android::hardware::Void;
using ::android::sp;

struct Sensors : public ISensors {
    Return<void> getSensorsList(getSensorsList_cb _hidl_cb) override {
        _hidl_cb({});
        return Void();
    }

    Return<Result> setOperationMode(OperationMode mode) override {
        return Result::OK;
    }

    Return<Result> activate(int32_t sensorHandle, bool enabled) override {
        return Result::OK;
    }

    Return<Result> initialize(const ::android::hardware::MQDescriptorSync<Event>& eventQueueDescriptor,
                              const ::android::hardware::MQDescriptorSync<uint32_t>& wakeLockDescriptor,
                              const sp<::android::hardware::sensors::V2_0::ISensorsCallback>& sensorsCallback) override {
        return Result::OK;
    }

    Return<Result> batch(int32_t sensorHandle, int64_t samplingPeriodNs, int64_t maxReportLatencyNs) override {
        return Result::OK;
    }

    Return<Result> flush(int32_t sensorHandle) override {
        return Result::OK;
    }

    Return<Result> injectSensorData(const Event& event) override {
        return Result::OK;
    }

    Return<void> registerDirectChannel(const SharedMemInfo& mem, registerDirectChannel_cb _hidl_cb) override {
        _hidl_cb(Result::OK, 0);
        return Void();
    }

    Return<Result> unregisterDirectChannel(int32_t channelHandle) override {
        return Result::OK;
    }

    Return<void> configDirectReport(int32_t sensorHandle, int32_t channelHandle, RateLevel rate, configDirectReport_cb _hidl_cb) override {
        _hidl_cb(Result::OK, 0);
        return Void();
    }
};

int main() {
    sp<ISensors> service = new Sensors();
    configureRpcThreadpool(1, true);
    android::status_t status = service->registerAsService("default");
    if (status != android::OK) {
        return -1;
    }
    joinRpcThreadpool();
    return 0;
}