#include <aidl/android/hardware/sensors/ISensors.h>
#include <aidl/android/hardware/sensors/Event.h>
#include <aidl/android/hardware/sensors/SensorInfo.h>
#include <binder/IServiceManager.h>
#include <binder/ProcessState.h>
#include <binder/IPCThreadState.h>
#include <android-base/logging.h>
#include <android/binder_manager.h>

using ::aidl::android::hardware::sensors::ISensors;
using ::aidl::android::hardware::sensors::SensorInfo;
using ::aidl::android::hardware::sensors::Event;
using RateLevel = ::aidl::android::hardware::sensors::ISensors::RateLevel;        // Alias
using SharedMemInfo = ::aidl::android::hardware::sensors::ISensors::SharedMemInfo; // Alias
using OperationMode = ::aidl::android::hardware::sensors::ISensors::OperationMode; // Alias
using ::ndk::ScopedAStatus;
using ::ndk::SpAIBinder;
using ::android::ProcessState;
using ::android::defaultServiceManager;
using ::android::String16;

class Sensors : public ISensors {
public:
    Sensors() = default;

    SpAIBinder asBinder() override { return SpAIBinder(); }
    bool isRemote() override { return false; }

    ScopedAStatus getSensorsList(std::vector<SensorInfo>* _aidl_return) override {
        LOG(INFO) << "getSensorsList called";
        *_aidl_return = {};
        return ScopedAStatus::ok();
    }

    ScopedAStatus setOperationMode(OperationMode mode) override {
        LOG(INFO) << "setOperationMode: " << static_cast<int>(mode);
        return ScopedAStatus::ok();
    }

    ScopedAStatus activate(int32_t sensorHandle, bool enabled) override {
        LOG(INFO) << "activate: handle=" << sensorHandle << ", enabled=" << enabled;
        return ScopedAStatus::ok();
    }

    ScopedAStatus batch(int32_t sensorHandle, int64_t samplingPeriodNs, int64_t maxReportLatencyNs) override {
        LOG(INFO) << "batch: handle=" << sensorHandle << ", sampling=" << samplingPeriodNs;
        return ScopedAStatus::ok();
    }

    ScopedAStatus flush(int32_t sensorHandle) override {
        LOG(INFO) << "flush: handle=" << sensorHandle;
        return ScopedAStatus::ok();
    }

    ScopedAStatus injectSensorData(const Event& event) override {
        LOG(INFO) << "injectSensorData";
        return ScopedAStatus::ok();
    }

    ScopedAStatus registerDirectChannel(const SharedMemInfo& mem, int32_t* _aidl_return) override {
        LOG(INFO) << "registerDirectChannel";
        *_aidl_return = 0;
        return ScopedAStatus::ok();
    }

    ScopedAStatus unregisterDirectChannel(int32_t channelHandle) override {
        LOG(INFO) << "unregisterDirectChannel: handle=" << channelHandle;
        return ScopedAStatus::ok();
    }

    ScopedAStatus configDirectReport(int32_t sensorHandle, int32_t channelHandle, RateLevel rate, int32_t* _aidl_return) override {
        LOG(INFO) << "configDirectReport: sensor=" << sensorHandle << ", channel=" << channelHandle;
        *_aidl_return = 0;
        return ScopedAStatus::ok();
    }

    ScopedAStatus initialize(
        const ::aidl::android::hardware::common::fmq::MQDescriptor<::aidl::android::hardware::sensors::Event, ::aidl::android::hardware::common::fmq::SynchronizedReadWrite>& eventQueueDescriptor,
        const ::aidl::android::hardware::common::fmq::MQDescriptor<int32_t, ::aidl::android::hardware::common::fmq::SynchronizedReadWrite>& wakeLockDescriptor,
        const std::shared_ptr<::aidl::android::hardware::sensors::ISensorsCallback>& sensorsCallback) override {
        LOG(INFO) << "initialize called";
        return ScopedAStatus::ok();
    }

    ScopedAStatus getInterfaceVersion(int32_t* _aidl_return) override {
        *_aidl_return = ISensors::version;
        return ScopedAStatus::ok();
    }

    ScopedAStatus getInterfaceHash(std::string* _aidl_return) override {
        *_aidl_return = ISensors::hash;
        return ScopedAStatus::ok();
    }
};

int main() {
    LOG(INFO) << "Starting PDX245 sensors service";
    std::shared_ptr<Sensors> service = ndk::SharedRefBase::make<Sensors>();
    ProcessState::self()->startThreadPool();

    const std::string serviceName = std::string(ISensors::descriptor) + "/default";
    binder_status_t status = AServiceManager_addService(service->asBinder().get(), serviceName.c_str());
    if (status != STATUS_OK) {
        LOG(ERROR) << "Failed to register service: " << status;
        return -1;
    }
    LOG(INFO) << "Service registered successfully";

    android::IPCThreadState::self()->joinThreadPool();
    return 0;
}