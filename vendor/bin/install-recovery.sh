#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):102760448:eb98b313aef5705f80e12fb08b7d593f949747f3; then
  applypatch  \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):33554432:d5484a3b12d013afe6ce2f6c9744e0c922905926 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):102760448:eb98b313aef5705f80e12fb08b7d593f949747f3 && \
      log -t recovery "Installing new recovery image: succeeded" && \
      setprop ro.boot.recovery.updated true || \
      log -t recovery "Installing new recovery image: failed" && \
      setprop ro.boot.recovery.updated false
else
  log -t recovery "Recovery image already installed"
  setprop ro.boot.recovery.updated true
fi
