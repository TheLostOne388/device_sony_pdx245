/**
 * @file vi_r0t0_cfg.h
 * @brief Header for VI R0T0 Configuration
 */

#ifndef VI_R0T0_CFG_H
#define VI_R0T0_CFG_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct vi_r0t0_cfg {
    int32_t r0_cali_q24;
    int32_t t0_cali_q6;
} vi_r0t0_cfg_t;

typedef struct param_id_sp_th_vi_r0t0_cfg {
    uint32_t num_ch;
    vi_r0t0_cfg_t r0t0_cfg[8]; // Support for up to 8 channels
} param_id_sp_th_vi_r0t0_cfg_t;

typedef struct param_id_sp_ex_vi_mode_cfg {
    uint32_t ex_FTM_mode_enable_flag;
} param_id_sp_ex_vi_mode_cfg_t;

typedef struct vi_th_ftm_cfg {
    uint32_t wait_time_ms;
    uint32_t ftm_time_ms;
} vi_th_ftm_cfg_t;

typedef struct param_id_sp_th_vi_ftm_cfg {
    uint32_t num_ch;
} param_id_sp_th_vi_ftm_cfg_t;

typedef struct vi_th_ftm_params {
    int32_t ftm_dc_res_q24;
    int32_t ftm_temp_q22;
    int32_t ftm_freq_q20;
    int32_t ftm_qmct_q23;
    int32_t ftm_rdc_q24;
    int32_t ftm_status;
} vi_th_ftm_params_t;

typedef struct param_id_sp_th_vi_ftm_params {
    uint32_t num_ch;
} param_id_sp_th_vi_ftm_params_t;

#ifdef __cplusplus
}
#endif

#endif /* VI_R0T0_CFG_H */ 