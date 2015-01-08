#!/bin/bash
#lib-installer
#This is the installer library. The backend for the gui and the cli interface.
#All the main work will be done here.

##### Load Libraries #####
. ./lib-logging.sh
. ./installer-file-locations.sh

system_bit=$(getconf LONG_BIT);

if [ -d /sys/firmware/efi ]; then
    firmware_type='efi';
else
    firmware_type='bios';
fi

read -p "What disk would you like to use (sda default)?" disk

if [ -z "$disk" ]; then 
    disk='sda';
else
    disk=$(echo $disk |cut -c 1-3)
fi

disk_size=$(cat /sys/block/$disk/size)
disk_size_b=$(( $disk_size * 512 ))
disk_size_k=$(( $disk_size_b / 1000 ))
disk_size_m=$(( $disk_size_b / (1000 ** 2) ))
disk_size_g=$(( $disk_size_b / (1000 ** 3) ))

size_buffer=2
swap_size=$((1024 + $size_buffer))
if [ "$disk_size_g" -lt 85 ]; then
    root_size=$(($disk_size_m - $swap_size ))
    separate_home=false
else
    root_size=$((20480 + $size_buffer))
    home_size=$(($disk_size_m - $swap_size - $root_size))
    home_start=$(($root_finish + 1))
    home_finish=$(($home_start + $home_size))
    separate_home=true
fi

swap_start=0
swap_finish=1024
root_start=$(($swap_finish + 1))
root_finish=$(($root_start + $root_size))

say "OS Bit: $system_bit"
say "Firmware Type: $firmware_type"
say "Disk Sectors: $disk_size"
say "Disk Size: $disk_size_b"
say "Disk Size K: $disk_size_k"
say "Disk Size M: $disk_size_m"
say "Disk Size G: $disk_size_g"

say "swap:$swap_size  Start: $swap_start  Finish: $swap_finish"
say "root:$root_size  Start: $root_start  Finish: $root_finish"
if [ "$separate_home" = "true" ]; then
    say "home:$home_size  Start: $home_start  Finish: $home_finish"
else
    say "home: contained in root "
fi
