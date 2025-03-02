#ifndef _LINUX_NFCINFO_H
#define _LINUX_NFCINFO_H

#include <linux/types.h>
#include <linux/ioctl.h>

/* NFC Info Constants */
#define NFC_MAX_SIZE 256

/* NFC Info Commands */
#define NFCC_GET_INFO  _IOR('N', 0x20, unsigned int)
#define NFCC_RESET     _IO('N', 0x21)

/* NFC Info Structure */
struct nfcinfo {
    unsigned int chip_type;
    unsigned int rom_version;
    unsigned int fw_major;
    unsigned int fw_minor;
    char nfc_device_type[NFC_MAX_SIZE];
};

/* Union structure for IOCTL return value */
typedef union {
    unsigned int i;
    struct nfcinfo info;
} nqx_uinfo;

#endif /* _LINUX_NFCINFO_H */ 