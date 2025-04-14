/**
 * @file vui_dmgr_types.h
 * @brief Stub header for Voice UI Data Manager types
 */

#ifndef VUI_DMGR_TYPES_H
#define VUI_DMGR_TYPES_H

#ifdef __cplusplus
extern "C" {
#endif

// Callback function type for peripheral state change notification
typedef void (*PeripheralStateCB)(uint32_t peripheral, uint32_t state);

// VUI Data Manager use cases info structure
typedef struct vui_dmgr_param_restart_usecases {
    uint32_t param1;
    uint32_t param2;
    void* data;
} vui_dmgr_param_restart_usecases_t;

// Function pointer types for VUI service
typedef void* (*vui_dmgr_init_t)();
typedef void (*vui_dmgr_deinit_t)(void*);

// Function pointer types for Audio Feature Stats service
typedef void* (*afs_init_t)();
typedef void (*afs_deinit_t)(void*);

#ifdef __cplusplus
}
#endif

#endif /* VUI_DMGR_TYPES_H */ 