#ifndef __ATS_H__
#define __ATS_H__
/**
*=============================================================================
* \file ats.h
* \brief
*                  A T S  H E A D E R  F I L E
*
*     This header file contains all the definitions necessary for the QACT
*     Tuning Service to handle request buffer and operate ACDB
*
* \copyright
*     Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
*     SPDX-License-Identifier: BSD-3-Clause
*
*=============================================================================
*/
/*------------------------------------------
* Includes
*------------------------------------------*/
#include "ar_osal_error.h"
#include "ar_osal_types.h"

#ifdef __cplusplus
extern "C" {
#endif

/* ---------------------------------------------------------------------------
* Public API Definitions
*-------------------------------------------------------------------------- */

/**
* \brief ats_init
*		Initializes the QACT Tuning Service.
*
* \return 0 on success, non-zero on failure
*/
int32_t ats_init(void);

/**
* \brief ats_deinit
*		Resets the QACT Tuning Service.
*
* \return 0 on success, non-zero on failure
*/
int32_t ats_deinit(void);

#ifdef __cplusplus
}  /* extern "C" */
#endif

#endif /*__ATS_H__*/
