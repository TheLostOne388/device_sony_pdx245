/**
 * @file vui_dmgr_audio_intf.h
 * @brief Stub header for Voice UI interface definitions
 */

#ifndef VUI_DMGR_AUDIO_INTF_H
#define VUI_DMGR_AUDIO_INTF_H

#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

/* VUI audio interface structure used by StreamSoundTrigger */
struct vui_intf_t {
    uint32_t dummy;          /* Placeholder to make this a non-empty struct */
    void* handle;            /* Handle to the VUI interface implementation */
    uint32_t session_id;     /* Session ID for the VUI interface */
    uint32_t stream_id;      /* Stream ID for the VUI interface */
    
    /* Function pointers for VUI interface operations */
    int (*init)(struct vui_intf_t* intf, uint32_t session_id);
    int (*deinit)(struct vui_intf_t* intf);
    int (*start)(struct vui_intf_t* intf);
    int (*stop)(struct vui_intf_t* intf);
    int (*pause)(struct vui_intf_t* intf);
    int (*resume)(struct vui_intf_t* intf);
};

#ifdef __cplusplus
}  /* extern "C" */
#endif

#endif /* VUI_DMGR_AUDIO_INTF_H */
