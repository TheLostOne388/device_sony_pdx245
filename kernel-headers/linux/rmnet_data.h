#ifndef _RMNET_DATA_H_
#define _RMNET_DATA_H_

#include <linux/types.h>

/* RMNET Constants */
#define RMNET_MAX_STR_LEN 128  // Increased from 16 for safety

/* RMNET Netlink Protocol */
#define RMNET_NETLINK_PROTO 31

/* RMNET Netlink Message Types */
#define RMNET_NETLINK_MSG_COMMAND    0
#define RMNET_NETLINK_MSG_RETURNCODE 1
#define RMNET_NETLINK_MSG_RETURNDATA 2

/* RMNET Netlink Commands */
#define RMNET_NETLINK_ASSOCIATE_NETWORK_DEVICE        1
#define RMNET_NETLINK_UNASSOCIATE_NETWORK_DEVICE     2
#define RMNET_NETLINK_GET_NETWORK_DEVICE_ASSOCIATED  3
#define RMNET_NETLINK_SET_LINK_EGRESS_DATA_FORMAT    4
#define RMNET_NETLINK_GET_LINK_EGRESS_DATA_FORMAT    5
#define RMNET_NETLINK_SET_LINK_INGRESS_DATA_FORMAT   6
#define RMNET_NETLINK_GET_LINK_INGRESS_DATA_FORMAT   7
#define RMNET_NETLINK_SET_LOGICAL_EP_CONFIG          8
#define RMNET_NETLINK_UNSET_LOGICAL_EP_CONFIG        9
#define RMNET_NETLINK_GET_LOGICAL_EP_CONFIG          10
#define RMNET_NETLINK_NEW_VND                        11
#define RMNET_NETLINK_NEW_VND_WITH_PREFIX            12
#define RMNET_NETLINK_NEW_VND_WITH_NAME              13
#define RMNET_NETLINK_FREE_VND                       14
#define RMNET_NETLINK_GET_VND_NAME                   15
#define RMNET_NETLINK_ADD_VND_TC_FLOW                16
#define RMNET_NETLINK_DEL_VND_TC_FLOW                17

/* RMNET Config Status */
#define RMNET_CONFIG_OK 0

/* RMNET Egress Format Flags */
#define RMNET_EGRESS_FORMAT__RESERVED__     (1<<0)
#define RMNET_EGRESS_FORMAT_MAP             (1<<1)
#define RMNET_EGRESS_FORMAT_AGGREGATION     (1<<2)
#define RMNET_EGRESS_FORMAT_MUXING          (1<<3)
#define RMNET_EGRESS_FORMAT_MAP_CKSUMV3     (1<<4)
#define RMNET_EGRESS_FORMAT_MAP_CKSUMV4     (1<<5)

/* RMNET Ingress Format Flags */
#define RMNET_INGRESS_FIX_ETHERNET          (1<<0)
#define RMNET_INGRESS_FORMAT_MAP            (1<<1)
#define RMNET_INGRESS_FORMAT_DEAGGREGATION  (1<<2)
#define RMNET_INGRESS_FORMAT_DEMUXING       (1<<3)
#define RMNET_INGRESS_FORMAT_MAP_COMMANDS   (1<<4)
#define RMNET_INGRESS_FORMAT_MAP_CKSUMV3    (1<<5)
#define RMNET_INGRESS_FORMAT_MAP_CKSUMV4    (1<<6)

/* Endpoint Modes */
#define RMNET_EPMODE_LENGTH 4

struct rmnet_egress_data_format {
    char dev[RMNET_MAX_STR_LEN];
    uint32_t flags;
    uint32_t agg_size;
    uint32_t agg_count;
    uint32_t tail_spacing;
};

struct rmnet_logical_ep_config {
    char dev[RMNET_MAX_STR_LEN];
    char next_dev[RMNET_MAX_STR_LEN];
    uint32_t ep_id;
    uint32_t operating_mode;
};

struct rmnet_vnd_config {
    char vnd_name[RMNET_MAX_STR_LEN];
    uint32_t id;
};

struct rmnet_flow_control {
    uint32_t id;
    uint32_t map_flow_id;
    uint32_t tc_flow_id;
    uint32_t tc_handle;
    uint32_t qos_id;
};

struct rmnet_nl_msg_s {
    uint16_t message_type;
    uint16_t arg_length;
    uint16_t crd;
    uint16_t return_code;
    union {
        uint8_t data[RMNET_MAX_STR_LEN];
        struct rmnet_egress_data_format data_format;
        struct rmnet_logical_ep_config local_ep_config;
        struct rmnet_vnd_config vnd;
        struct rmnet_flow_control flow_control;
    } __attribute__((aligned(4)));
};

#endif /* _RMNET_DATA_H_ */ 