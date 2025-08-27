# manual_vbmeta.py - Manually construct vbmeta.img with hashtree descriptors

import struct

# AVB constants from avbtool
AVB_HASHTREE_DESCRIPTOR_TAG = 4

# Corrected format for avb_hashtree_descriptor_t
def pack_hashtree_descriptor(dm_verity_version, image_size, tree_offset, tree_size, data_block_size, hash_block_size, fec_num_roots, fec_offset, fec_size, hash_algorithm, partition_name, salt, root_digest, flags):
    hash_algorithm_bytes = hash_algorithm.encode('utf-8').ljust(32, b'\0')
    partition_name_bytes = partition_name.encode('utf-8')
    salt_bytes = bytes.fromhex(salt)
    root_digest_bytes = bytes.fromhex(root_digest)
    reserved = b'\0' * 60

    descriptor = struct.pack(
        '<QQQQIIIQQ32sI%dsI%dsI%dsI60s' % (len(partition_name_bytes), len(salt_bytes), len(root_digest_bytes)),
        dm_verity_version,
        image_size,
        tree_offset,
        tree_size,
        data_block_size,
        hash_block_size,
        fec_num_roots,
        fec_offset,
        fec_size,
        hash_algorithm_bytes,
        len(partition_name_bytes),
        partition_name_bytes,
        len(salt_bytes),
        salt_bytes,
        len(root_digest_bytes),
        root_digest_bytes,
        flags,
        reserved
    )
    return descriptor

# Update the partitions list to include dm_verity_version (1) and remove the flags if default 0
partitions = [
    ('vendor', 1, 375300096, 375300096, 2961408, 4096, 4096, 2, 378261504, 2998272, 'sha256', 'b4efccb2212519f3a27397c925a2a2feac2d2a066a10c0c3c89702aacff4d51d', '76a340507e7cf6f283d49208a9f58c4a0ba5a407befc3422ad640994b299adc4', 0),
    ('odm', 1, 1851392, 1851392, 20480, 4096, 4096, 2, 1871872, 16384, 'sha256', 'b4efccb2212519f3a27397c925a2a2feac2d2a066a10c0c3c89702aacff4d51d', '07cbffc913e890b97eac7e7c0fb1bdc65b1dbaa287be2822de497951a6e62d46', 0),
    ('vendor_dlkm', 1, 68861952, 68861952, 552960, 4096, 4096, 2, 69414912, 548864, 'sha256', 'b4efccb2212519f3a27397c925a2a2feac2d2a066a10c0c3c89702aacff4d51d', '1c2877756f9089ecb740a5337942b5e93dd3903aecec27adfed71e1a71d215a8', 0)
]

descriptors = b''
for p in partitions:
    descriptors += pack_hashtree_descriptor(*p)

# For a full vbmeta, we need to add header, authentication, etc. This is a starting point.
with open('out/target/product/pdx245/vbmeta_manual.img', 'wb') as f:
    f.write(descriptors)

print("Manual vbmeta descriptors generated!")
