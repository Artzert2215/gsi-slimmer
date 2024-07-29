#!/bin/bash

#Usage:
#sudo bash securize.sh [/path/to/system/image]

#cleanups
umount d
set -ex
origin="$(readlink -f -- "$0")"
origin="$(dirname "$origin")"

if [ -f "$1" ];then
    srcFile="$1"
fi

if [ ! -f "$srcFile" ];then
	echo "Usage: sudo bash securize.sh [/path/to/system/image]"
	exit 1
fi

"$origin"/simg2img "$srcFile" slimmed.img || cp "$srcFile" slimmed.img

rm -Rf tmp
mkdir -p d tmp
e2fsck -y -f slimmed.img
resize2fs slimmed.img 3500M
e2fsck -E unshare_blocks -y -f slimmed.img
mount -o loop,rw slimmed.img d

touch d/system/phh/secure
rm d/system/xbin/su
rm d/system/bin/phh-su
rm d/system/etc/init/su.rc
rm d/system/bin/phh-securize.sh
rm -Rf d/system/{app,priv-app}/me.phh.superuser/

sleep 1

umount d

e2fsck -f -y slimmed.img || true
resize2fs -M slimmed.img
