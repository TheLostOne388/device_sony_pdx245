#ifndef VI_STUBS_H
#define VI_STUBS_H

// VI R0T0 structure for speaker protection
typedef struct vi_r0t0_cfg_t {
    uint32_t r0_cali_q24;
    uint32_t t0_cali_q6;
} vi_r0t0_cfg_t;

typedef struct param_id_sp_th_vi_r0t0_cfg_t {
    uint32_t num_ch;
    vi_r0t0_cfg_t r0t0_cfg[8]; // Maximum 8 channels
} param_id_sp_th_vi_r0t0_cfg_t;

typedef struct param_id_sp_ex_vi_mode_cfg_t {
    uint32_t ex_FTM_mode_enable_flag;
} param_id_sp_ex_vi_mode_cfg_t;

// VUI interface structure
struct vui_intf_t {
    void* handle;
};

// Define missing types
typedef void (*PeripheralStateCB)(uint32_t peripheral, int state);
typedef void* (*vui_dmgr_init_t)(void);
typedef void (*vui_dmgr_deinit_t)(void*);
typedef struct { int dummy; } vui_dmgr_param_restart_usecases_t;
typedef void* (*afs_init_t)(void);
typedef void (*afs_deinit_t)(void*);

// ACD Stream Config
class ACDStreamConfig {
public:
    ACDStreamConfig() {}
    ~ACDStreamConfig() {}
};

#endif // VI_STUBS_H
