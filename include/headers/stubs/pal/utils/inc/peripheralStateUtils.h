/**
 * @file peripheralStateUtils.h
 * @brief Stub header for peripheral state utilities
 */

#ifndef PERIPHERAL_STATE_UTILS_H
#define PERIPHERAL_STATE_UTILS_H

#include <string>
#include <vector>
#include <map>
#include "CPeripheralAccessControl.h"

namespace pal {

bool peripheral_state_init();
void peripheral_state_deinit();
bool is_peripheral_available(const std::string& peripheral_name);
bool register_peripheral(const std::string& peripheral_name, int state);
bool unregister_peripheral(const std::string& peripheral_name);
int get_peripheral_state(const std::string& peripheral_name);

} // namespace pal

// This needs C++ linkage but appears to have C linkage causing the error
#ifdef __cplusplus
extern "C++" {
#endif
namespace pal {
std::vector<std::string> get_registered_peripherals();
}
#ifdef __cplusplus
}
#endif

#endif // PERIPHERAL_STATE_UTILS_H
