#ifndef _MSM_AUDIO_CALIBRATION_H
#define _MSM_AUDIO_CALIBRATION_H

#include <linux/types.h>

/* Audio calibration related types */
#define AUDIO_CORE_METAINFO_CAL_TYPE 0x00000003

struct audio_cal_info_metainfo {
    uint32_t nKey;
};

/* Add any other structs/defines needed based on build errors */

#endif /* _MSM_AUDIO_CALIBRATION_H */ 