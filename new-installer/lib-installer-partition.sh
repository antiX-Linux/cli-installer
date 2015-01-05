#!/bin/bash
#lib-installer-partition
#Retrieves partition information and builds disk layout.

. ./lib-logging.sh
. ./lib-exec.sh
. ./installer-file-locations.sh
. $installer_instructions


partition(){
	command="parted $disk_disk mklabel $disk_disk_table ";
	partition_number=1;
	last_partition_end=1;
	while [ "$partition_number" -lt "$disk_number_of_partitions" ];
	do
	    command="$command P$partition_number $disk_partition_$partition_number_format $last_partition_end $(echo $last_partition_end + $disk_partition_\"$partition_number\"_size + 1)"
	    last_partition_end=$(echo $disk_partition_"$partition_number"_size + 1)
	    partition_number=$(echo $partition_number + 1)
	done
	say "$command"
}


warn "Review the following to ensure it is correct! Incorrect information could serriously hurt your system."
set_colors b 0 && set_colors f 6; 
say "Disk Information"
set_colors r;

for line in `set -o posix ; set |grep "^disk_"`
do
echo "$line"
done

set_colors b 0 && set_colors f 6; 
say "Grub Information"
set_colors r;

for line in `set -o posix ; set  |grep "^grub_"`
do
echo "$line"
done

set_colors b 0 && set_colors f 6; 
say "Host Information"
set_colors r;

for line in `set -o posix ; set  |grep "^host_"`
do
echo "$line"
done

set_colors b 4 && set_colors f7 ; 
read -p "Is the above information correct? (y/n)" ans
set_colors r; 

say $ans

if [ "$ans" = "y" ]; then
    partition
fi
