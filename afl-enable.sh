#!/bin/bash

cat /proc/sys/kernel/core_pattern > /mnt/d/hacking/tools/scripts/tmp/core_pattern
echo core > /proc/sys/kernel/core_pattern

for d in /sys/devices/system/cpu/cpu*/cpufreq; do
    c=`echo $d | cut -d'/' -f6`
    mkdir -p "/mnt/d/hacking/tools/scripts/tmp/$c"
    cat /sys/devices/system/cpu/$c/cpufreq/scaling_governor > /mnt/d/hacking/tools/scripts/tmp/$c/scaling_governor
    echo performance > /sys/devices/system/cpu/$c/cpufreq/scaling_governor
done
