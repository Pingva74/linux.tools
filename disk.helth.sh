#!/bin/bash

#The script to check the status of the HDD.
#Just run the script and specify the target host with a space, for example: ./disk.helth.sh ssl45
#The result will be the 3 most important disk integrity settings (HDD only) for each device. If RAW_VALUE 
#is 0 then there is nothing to worry about. If RAW_VALUE approaches the value of WORST, notify the L2 team,
#perhaps it is time to change the drive.
#The utility does not work for disks located behind a hardware RAID controller and may not work correctly 
#with SSD and nvme drives.
#===============================================================================================================
#                                     And do not forget to change the username
#===============================================================================================================


USER=alex.lanovoy
HOST=$1

# main

ssh $USER@$HOST "lsblk | grep ^sd. | cut -d' ' -f1" > drlist.txt


for drive in $(cat ./drlist.txt ); do
echo ============================================== $drive =============================================== #> drive.helth.txt
ssh $USER@$HOST "sudo smartctl -a /dev/$drive | grep -e ATTRIBUTE_NAME -e Reallocated_Sector -e Current_Pending -e Offline_Uncorrectable; DRIVE_TYPE=$(cat /sys/block/sda/queue/rotational)" #>> drive.helth.txt

done
echo $DRIVE_TYPE
