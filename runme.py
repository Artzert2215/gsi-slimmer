#!/bin/env python

import sys
import os
import time

from pyaxmlparser import APK

os.chdir(sys.path[0]) #run in folder containing script


if len(sys.argv) < 2:
    print("You must provide a path to your system image.")
    print("Usage: sudo python runme.py /path/to/system_image.img")
    exit()

if not os.path.isfile(sys.argv[1]):
    print("Invalid argument.")

os.system(f'sudo bash ./mountImage.sh {sys.argv[1]}')


for appfolder in ["d/system/product/priv-app", "d/system/product/app"]:
    #check if apps folder exists

    if not os.path.isdir(appfolder):
        print("cant find priv app folder.")

    privapps = [name for name in os.listdir(appfolder)]

    for privapp in privapps:
        app_package = "Unable to locate apk, so no info :("
        app_name = "Unable to locate apk, so no info :("
        app_version = "Unable to locate apk, so no info :("
        if os.path.isfile(f"{appfolder}/{privapp}/{privapp}.apk"):
            apk = APK(f"{appfolder}/{privapp}/{privapp}.apk")
            
            try:
                app_package = apk.package
            except:
                app_package = "An exception occurred getting the package"
            
            try:
                app_name = apk.application
            except:
                app_name = "An exception occurred getting the name"
            
            try:
                app_version = apk.version_name
            except:
                app_version = "An exception occurred getting the version"
            
        os.system('clear')
        print(f"=== Processing app: {privapp}")
        print("Size:")
        os.system(f"du -sh {appfolder}/{privapp}/")
        print("App info:")
        print(f"Package: {app_package}")
        print(f"Name: {app_name}")
        print(f"Version: {app_version}")

        response = ""
        while not (response == "d" or response == "k"):
            print('What to do with this app?')
            print('d = delete')
            print('k = keep')
            response = input()

        if response == "d":
            os.system(f'sudo rm -rf {appfolder}/{privapp}/')

#ask to securize
os.system('clear')
response = ""
while not (response == "y" or response == "n"):
    print('Do you want to securize the rom?')
    print('y = yes')
    print('n = no')
    response = input()

if response == "y":
    os.system(f'sudo bash ./securize.sh')

print("you must now manually run: sudo bash ./unmountImage.sh")
print("then you're ready to flash slimmer.img to your device")