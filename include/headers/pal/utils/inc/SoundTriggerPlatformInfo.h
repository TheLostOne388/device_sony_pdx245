/*
 * Copyright (c) 2019-2021, The Linux Foundation. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above
 *       copyright notice, this list of conditions and the following
 *       disclaimer in the documentation and/or other materials provided
 *       with the distribution.
 *     * Neither the name of The Linux Foundation nor the names of its
 *       contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
 * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Changes from Qualcomm Innovation Center are provided under the following license:
 * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause-Clear
 */

#ifndef SOUND_TRIGGER_PLATFORM_INFO_H
#define SOUND_TRIGGER_PLATFORM_INFO_H

#include <errno.h>
#include <stdint.h>
#include <map>
#include <vector>
#include <memory>
#include <string>
#include "PalDefs.h"
#include "kvh2xml.h"

// Include SoundTriggerXmlParser.h first to prevent class/enum redefinitions
#include "SoundTriggerXmlParser.h"
#include "SoundTriggerUtils.h"

// Define UUID type
using UUID = SoundTriggerUUID;
// Define st_cap_profile_map_t and st_op_modes_t 
using st_cap_profile_map_t = std::map<std::string, std::shared_ptr<CaptureProfile>>;
using st_op_modes_t = std::map<std::pair<StOperatingModes, StInputModes>, std::shared_ptr<CaptureProfile>>;

#define MAX_MODULE_CHANNELS 4

#define CAPTURE_PROFILE_PRIORITY_HIGH 1
#define CAPTURE_PROFILE_PRIORITY_LOW -1
#define CAPTURE_PROFILE_PRIORITY_SAME 0

// Use definitions from SoundTriggerXmlParser.h
// Instead of redefining StOperatingModes, StInputModes, SoundTriggerXml, and CaptureProfile

class SoundTriggerPlatformInfo : public SoundTriggerXml {
public:
    SoundTriggerPlatformInfo() {}
    static std::shared_ptr<SoundTriggerPlatformInfo> GetInstance();
    std::shared_ptr<CaptureProfile> GetCaptureProfile(const UUID& uuid) const;
    std::shared_ptr<CaptureProfile> GetCaptureProfile(const StOperatingModes& op_mode, 
                                                     const StInputModes& in_mode) const;
protected:
    void HandleStartTag(const char* tag, const char** attribs) override {}
    void HandleEndTag(struct xml_userdata* data, const char* tag) override {}

private:
    SoundTriggerPlatformInfo(SoundTriggerPlatformInfo&) = delete;
    SoundTriggerPlatformInfo& operator=(SoundTriggerPlatformInfo&) = delete;
    
    std::map<UUID, st_cap_profile_map_t> st_cap_profile_map_;
    std::map<UUID, st_op_modes_t> st_op_modes_map_;

    bool AddOperatingMode(UUID uuid, StOperatingModes op_mode_type, 
                         StInputModes input_mode_type,
                         std::shared_ptr<CaptureProfile> cap_prof) {
        return true;
    }
};

#endif
