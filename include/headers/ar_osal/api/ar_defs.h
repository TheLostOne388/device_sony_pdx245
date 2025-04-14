/**
 * @file ar_defs.h
 * @brief Stub header for Audio Router definitions
 */

#ifndef AR_DEFS_H
#define AR_DEFS_H

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Basic type definitions required by amdb_api.h */
typedef uint32_t ar_result_t;
typedef uint32_t ar_module_id_t;
typedef uint32_t ar_graph_handle_t;
typedef uint32_t ar_session_handle_t;

/* Error codes */
#define AR_EOK                  0x00000000
#define AR_EFAILED              0x00000001
#define AR_EBADPARAM            0x00000002
#define AR_EUNSUPPORTED         0x00000003
#define AR_ENOMEMORY            0x00000004
#define AR_ENOTIMPL             0x00000005

/* Module states */
typedef enum {
    AR_MODULE_CREATED = 0,
    AR_MODULE_OPENED,
    AR_MODULE_STARTED,
    AR_MODULE_STOPPED,
    AR_MODULE_CLOSED,
    AR_MODULE_DESTROYED
} ar_module_state_t;

/* Module properties */
typedef struct {
    ar_module_id_t id;
    const char* name;
    uint32_t version;
} ar_module_props_t;

#ifdef __cplusplus
}  /* extern "C" */
#endif

#endif /* AR_DEFS_H */ 