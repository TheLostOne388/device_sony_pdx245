/**
 * @file vi_r0t0_cfg.h
 * @brief Definitions for Speaker Protection configurations
 */

#ifndef VI_R0T0_CFG_H
#define VI_R0T0_CFG_H

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief VI r0t0 configuration structure
 */
typedef struct vi_r0t0_cfg {
    int32_t r0_cali_q24;
    int32_t t0_cali_q6;
} vi_r0t0_cfg_t;

/**
 * @brief Speaker Protection thermal VI r0t0 configuration
 */
typedef struct param_id_sp_th_vi_r0t0_cfg {
    uint32_t num_ch;
    vi_r0t0_cfg_t r0t0_cfg[2]; // Support for up to 2 channels
} param_id_sp_th_vi_r0t0_cfg_t;

/**
 * @brief Speaker Protection extended VI mode configuration
 */
typedef struct param_id_sp_ex_vi_mode_cfg {
    uint32_t ex_FTM_mode_enable_flag;
} param_id_sp_ex_vi_mode_cfg_t;

#ifdef __cplusplus
}
#endif

#endif /* VI_R0T0_CFG_H */ 