/**
 * @file pal_state_queue.h
 * @brief Stub header for PAL state queue utility
 */

#ifndef PAL_STATE_QUEUE_H
#define PAL_STATE_QUEUE_H

#include <memory>
#include <mutex>
#include <condition_variable>
#include <deque>
#include <string>
#include <functional>

// Defined in global namespace to match MemLogBuilder.h expectations
enum class pal_state_queue_state {
    IDLE,
    INIT,
    STARTED,
    STOPPED,
    PAUSED,
    RESUMED,
    ERROR
};

// Union for stream info
union pal_mlog_str_info {
    uint64_t value;
    void* ptr;
    char str[8];
};

// ACD stream info
struct pal_mlog_acdstr_info {
    char model_id[32];
    uint32_t session_id;
};

namespace pal {

// Forward declaration of Stream class
class Stream;

// Queue item template
template <typename T>
class StateQueueItem {
public:
    StateQueueItem(const T& state) : state_(state) {}
    
    T getState() const { return state_; }
    
private:
    T state_;
};

/**
 * @brief A state queue for tracking PAL events
 */
template <typename T>
class StateQueue {
public:
    StateQueue() = default;
    ~StateQueue() = default;

    // Add a state to the queue
    void push(const T& state) {
        std::lock_guard<std::mutex> lock(mutex_);
        queue_.push_back(state);
    }

    // Get the next state from the queue
    bool pop(T& state) {
        std::lock_guard<std::mutex> lock(mutex_);
        if (queue_.empty()) {
            return false;
        }
        state = queue_.front();
        queue_.pop_front();
        return true;
    }

    // Check if the queue is empty
    bool empty() const {
        std::lock_guard<std::mutex> lock(mutex_);
        return queue_.empty();
    }

    // Clear the queue
    void clear() {
        std::lock_guard<std::mutex> lock(mutex_);
        queue_.clear();
    }

    // Get the size of the queue
    size_t size() const {
        std::lock_guard<std::mutex> lock(mutex_);
        return queue_.size();
    }

private:
    mutable std::mutex mutex_;
    std::deque<T> queue_;
};

// Typedef for common queue types
using StringStateQueue = StateQueue<std::string>;
using IntStateQueue = StateQueue<int>;

} // namespace pal

// Using pal's StateQueue for pal_state_queue
using pal_state_queue = pal::StateQueue<pal_state_queue_state>;

/* Add PAL state definitions */
typedef enum {
    PAL_STATE_OPENED = 0,
    PAL_STATE_STARTED,
    PAL_STATE_STOPPED,
    PAL_STATE_CLOSED,
} pal_state_t;

#endif // PAL_STATE_QUEUE_H
