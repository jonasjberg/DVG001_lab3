# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# / was on /dev/sda1 during installation
# swap was on /dev/sda5 during installation
#
# <file system>                           <mount point>         <type>      <options>         <dump> <pass>
UUID=28a0fd25-2311-4e94-90e6-f4033e778aee /                     ext4        errors=remount-ro 0      1
UUID=57d9f548-a496-4c1b-95f1-098967e9ad26 none                  swap        sw                0      0
/dev/sr0                                  /media/cdrom0         udf,iso9660 user,noauto       0      0
VirtualBoxShared                          /home/jonas/VBoxShare vboxsf      defaults          0      0
