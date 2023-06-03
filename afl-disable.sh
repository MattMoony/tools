#!/bin/bash

cat /mnt/d/hacking/tools/scripts/tmp/core_pattern > /proc/sys/kernel/core_pattern 

for d in /sys/devices/system/cpu/cpu*/cpufreq; do
    c=`echo $d | cut -d'/' -f6`
    cat /mnt/d/hacking/tools/scripts/tmp/$c/scaling_governor > /sys/devices/system/cpu/$c/cpufreq/scaling_governor
done
