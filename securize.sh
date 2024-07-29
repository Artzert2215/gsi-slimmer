#!/bin/bash

#Usage:
#sudo bash securize.sh

touch d/system/phh/secure
rm d/system/xbin/su
rm d/system/bin/phh-su
rm d/system/etc/init/su.rc
rm d/system/bin/phh-securize.sh
rm -Rf d/system/{app,priv-app}/me.phh.superuser/

sleep 1
