#include <android-base/file.h>
#include <android-base/properties.h>
#include <liblp/liblp.h>
#include <iostream>
#include <string>

static int SlotNumber() {
    std::string suf = android::base::GetProperty("ro.boot.slot_suffix", "_a");
    return (suf == "_b") ? 1 : 0;
}

int main(int argc, char** argv) {
    if (argc != 2) {
        std::cerr << "usage: lptodm <super_blk_device>\n";
        return 1;
    }
    const char* super_dev = argv[1];

    auto metadata = android::fs_mgr::ReadMetadata(super_dev, SlotNumber());
    if (!metadata) {
        std::cerr << "Cannot read metadata\n";
        return 1;
    }

    /* Print a standard dm-linear table:
       create <name> <start> <length> linear <blkdev> <physical_start>
       One per partition that has extents.
    */
    for (const auto& part : metadata->partitions) {
        if (!(part.attributes & LP_PARTITION_ATTR_DISABLED)) {
            // Get extents for this partition
            uint32_t extent_idx = part.first_extent_index;
            for (uint32_t i = 0; i < part.num_extents; i++) {
                const auto& ext = metadata->extents[extent_idx + i];
                if (ext.target_type == LP_TARGET_TYPE_LINEAR) {
                    printf("create %s linear 0 %llu %s %llu\n",
                           part.name,
                           (unsigned long long)ext.num_sectors,
                           super_dev,
                           (unsigned long long)ext.target_data);
                }
            }
        }
    }
    return 0;
} 