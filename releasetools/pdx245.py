import common

def FullOTA_InstallBegin(info):
  """
  Custom script to prepare /metadata partition before OTA installation.
  This function is called at the beginning of a full OTA installation.
  """
  info.script.Print("PDX245: Preparing /metadata partition...")
  
  # Unmount metadata first to ensure it's in a clean state in case it was
  # already mounted. This is a safe operation.
  info.script.Unmount("/metadata")
  
  # Mount /metadata so we can work with it.
  info.script.Mount("f2fs", "EMMC", "/dev/block/by-name/metadata", "/metadata")
  
  # Create /metadata/ota directory. The -p flag ensures it doesn't fail
  # if the directory already exists. This makes the step idempotent.
  info.script.AppendExtra('run_program("/system/bin/mkdir", "-p", "/metadata/ota");')
  
  # Set the correct ownership, permissions, and SELinux context.
  info.script.AppendExtra('run_program("/system/bin/chown", "system:system", "/metadata/ota");')
  info.script.AppendExtra('run_program("/system/bin/chmod", "0770", "/metadata/ota");')
  info.script.AppendExtra('run_program("/system/bin/restorecon", "-R", "/metadata");')
  
  info.script.Print("PDX245: /metadata partition prepared successfully.")
  
  # We leave /metadata mounted, as the rest of the update script expects it. 