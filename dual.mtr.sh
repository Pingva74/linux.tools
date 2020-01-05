#!/bin/bash

HOST_A=$1
HOST_B=$2
USER=alex.lanovoy

ssh $USER@$HOST_A "mtr -rnc 20 $HOST_B" > $HOST_A.$HOST_B.txt | ssh $USER@$HOST_B "mtr -rnc 20 $HOST_A" > $HOST_B.$HOST_A.txt

echo ===================== MTR from $HOST_A to $HOST_B =======================================

cat $HOST_A.$HOST_B.txt

echo ===================== MTR from $HOST_B to $HOST_A =======================================

cat $HOST_B.$HOST_A.txt


echo ===================================DONE================================================== 
