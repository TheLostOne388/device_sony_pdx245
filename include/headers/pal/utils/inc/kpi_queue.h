/**
 * @file kpi_queue.h
 * @brief Stub header for KPI queue utility
 */

#ifndef KPI_QUEUE_H
#define KPI_QUEUE_H

#include <memory>
#include <mutex>
#include <queue>
#include <string>
#include <chrono>

namespace pal {

/**
 * @brief KPI entry structure
 */
struct KpiEntry {
    std::string name;
    std::chrono::time_point<std::chrono::steady_clock> timestamp;
    uint64_t value;
    std::string category;
    
    KpiEntry() = default;
    KpiEntry(const std::string& name, uint64_t value, const std::string& category = "")
        : name(name), timestamp(std::chrono::steady_clock::now()), value(value), category(category) {}
};

/**
 * @brief A queue for tracking KPI metrics
 */
class KpiQueue {
public:
    KpiQueue() = default;
    ~KpiQueue() = default;
    
    void push(const KpiEntry& entry) {
        std::lock_guard<std::mutex> lock(mutex_);
        queue_.push(entry);
    }
    
    bool pop(KpiEntry& entry) {
        std::lock_guard<std::mutex> lock(mutex_);
        if (queue_.empty()) {
            return false;
        }
        entry = queue_.front();
        queue_.pop();
        return true;
    }
    
    bool empty() const {
        std::lock_guard<std::mutex> lock(mutex_);
        return queue_.empty();
    }
    
    size_t size() const {
        std::lock_guard<std::mutex> lock(mutex_);
        return queue_.size();
    }
    
    void clear() {
        std::lock_guard<std::mutex> lock(mutex_);
        while (!queue_.empty()) {
            queue_.pop();
        }
    }
    
private:
    mutable std::mutex mutex_;
    std::queue<KpiEntry> queue_;
};

// Global KPI queue instance if needed
extern KpiQueue g_kpi_queue;

} // namespace pal

#endif // KPI_QUEUE_H
