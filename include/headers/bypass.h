#ifndef PAL_BYPASS_H
#define PAL_BYPASS_H

// Define missing types to satisfy the compiler
typedef void (*PeripheralStateCB)(uint32_t peripheral, int state);
typedef void* (*vui_dmgr_init_t)(void);
typedef void (*vui_dmgr_deinit_t)(void*);
typedef struct { int dummy; } vui_dmgr_param_restart_usecases_t;
typedef void* (*afs_init_t)(void);
typedef void (*afs_deinit_t)(void*);

// Redefine the problematic function to not use C linkage
#define get_registered_peripherals _get_registered_peripherals_cpp_only

#endif // PAL_BYPASS_H
