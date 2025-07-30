#!/system/bin/sh

# Copy active slot to inactive (sync A/B)
CURRENT_SLOT=$(getprop ro.boot.slot_suffix)
if [ "$CURRENT_SLOT" = "_a" ]; then
  OTHER_SLOT="_b"
else
  OTHER_SLOT="_a"
fi

PARTITIONS="boot dtbo vendor_boot vbmeta vbmeta_system"
for PART in $PARTITIONS; do
  dd if=/dev/block/by-name/${PART}${CURRENT_SLOT} of=/dev/block/by-name/${PART}${OTHER_SLOT}
done

echo "Partitions copied from $CURRENT_SLOT to $OTHER_SLOT" > /tmp/copy_log
touch /tmp/copy_done 

echo "Patching vbmeta to disable AVB" >> /tmp/copy_log
/system/bin/avbtool make_vbmeta_image --output /tmp/patched_vbmeta.img --flags 3 --set_hashtree_disabled_flag
dd if=/tmp/patched_vbmeta.img of=/dev/block/by-name/vbmeta 