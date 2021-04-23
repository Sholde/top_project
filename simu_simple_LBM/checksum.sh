#!/bin/bash

# If nothing is printed, then it is ok

#
if [ $# != 3 ] ; then
    echo "Usage: checksum.sh [FILE] [FILE] [INTEGER]"
fi

#
file1=$1
file2=$2
frame=$3

# Check if files are valid
if [ ! -f $file1 ] ; then
    echo "Error: $file1 is not a valide file"
    return
fi

if [ ! -f $file2 ] ; then
    echo "Error: $file2 is not a valide file"
    return
fi

# Check if integer is valid
re="^[0-9]*$"

if ! [[ $frame =~ $re ]] ; then
    echo "Error: $frame is not a valide integer"
    return
fi

for i in $(seq 0 $frame) ; do
    ./display --checksum $file1 $i > __tmp_file1.sum
    ./display --checksum $file2 $i > __tmp_file2.sum
    diff __tmp_file1.sum __tmp_file2.sum
done

#
rm -Rf __tmp_file1.sum __tmp_file2.sum
