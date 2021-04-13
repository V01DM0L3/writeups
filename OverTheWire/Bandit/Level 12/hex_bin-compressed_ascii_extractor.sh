#!/bin/bash

if [[ $# -lt 1 ]]; then
    echo "Too few arguments, Use pattern like: bash script.sh [txt_file_with_hexdump_inside]  Exiting script..."
    exit -1
fi

mkdir output
cd ./output
cp ../$1 .
file_name=$1
xxd -r $file_name $file_name.bin
file_name=$1.bin

while true; do
	if [[ $(file $file_name | grep -i " gzip") ]]; then
		echo "gzip archive!"
		mv $file_name $file_name.gz
		gzip -d $file_name.gz
	elif [[ $(file $file_name | grep -i " bzip2") ]]; then
		echo "bzip2 archive!"
		mv $file_name $file_name.bzip2
		bzip2 -d $file_name.bzip2
	elif [[ $(file $file_name | grep -i " tar") ]]; then
		echo "tar archive!"
		mv $file_name $file_name.tar
		tar --extract -f $file_name.tar
	elif [[ $(file $file_name | grep -i " ASCII") ]]; then
		echo "ASCII file!!!"
		cat $file_name
		break
	else
		echo "can't operate on $file_name, unknown condition!"
		cat $file_name
		break
	fi
	
	file_name=$(ls -l | awk {'print $8, $9'} | sort -k 1 -r | head -n 1 | awk {'print $2'})
	
done
