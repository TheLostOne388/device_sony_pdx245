#ifndef STUB_VUI_H
#define STUB_VUI_H

#ifdef __cplusplus
extern "C" {
#endif

typedef void* (*vui_dmgr_init_t)(void);
typedef void (*vui_dmgr_deinit_t)(void*);

typedef struct {
    int dummy;
} vui_dmgr_param_restart_usecases_t;

typedef void* (*afs_init_t)(void);
typedef void (*afs_deinit_t)(void*);

#ifdef __cplusplus
}
#endif

#endif // STUB_VUI_H
