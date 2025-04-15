#ifndef PAL_STUBS_H
#define PAL_STUBS_H

#include <vector>
#include <string>
#include <memory>

// Define missing types
typedef void (*PeripheralStateCB)(uint32_t peripheral, int state);

typedef void* (*vui_dmgr_init_t)(void);
typedef void (*vui_dmgr_deinit_t)(void*);

typedef struct {
    int dummy;
} vui_dmgr_param_restart_usecases_t;

typedef void* (*afs_init_t)(void);
typedef void (*afs_deinit_t)(void*);

// VUI interface structure
struct vui_intf_t {
    void* dummy;
};

// ACD Stream Config
class ACDStreamConfig {
public:
    ACDStreamConfig() {}
    ~ACDStreamConfig() {}
};

namespace pal {
// Fix the get_registered_peripherals function
std::vector<std::string> get_registered_peripherals();
}

#endif // PAL_STUBS_H
