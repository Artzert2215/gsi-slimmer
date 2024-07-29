#!/bin/bash

#Usage:
#sudo bash mountImage.sh [/path/to/system/image]

#cleanups
rm -Rf slimmed.img
umount d
set -ex
origin="$(readlink -f -- "$0")"
origin="$(dirname "$origin")"

if [ -f "$1" ];then
    srcFile="$1"
fi

if [ ! -f "$srcFile" ];then
	echo "Usage: sudo bash mountImage.sh [/path/to/system/image]"
	exit 1
fi

"$origin"/simg2img "$srcFile" slimmed.img || cp "$srcFile" slimmed.img

rm -Rf tmp
mkdir -p d tmp
e2fsck -y -f slimmed.img
resize2fs slimmed.img 6000M
e2fsck -E unshare_blocks -y -f slimmed.img
mount -o loop,rw slimmed.img d
