> [!CAUTION]
> Project is not finished, DO NOT USE

## About
> [!CAUTION]
> This only supports arm64 a/b non vndklite images

This repo contains a python file made to aid in the removal of unneeded apps from GSI images.\
It will mount the image and then iterate over all installed priv-apps providing context, app names and sizes.\
You can then choose to keep or remove the app.\
After you are done picking it will ask if you want to securize, this will remove the built in superuser and tell the rom to securize.

> [!WARNING]  
> Not all roms support securization and implementations may vary, devices may stop booting when securized.

> [!IMPORTANT]  
> If you use this tool and experience issues, don't pester builders with issues possibly caused by using this tool, run unmodified vanilla versions first.

> [!NOTE]  
> This tool is built for my personal use, this means I probably wont be there to fix any bugs you experience, feel free to contribute if you want to fix those bugs yourself.

## Usage on Linux
Requires linux and the `git`, `xattr`, `python3` and `python3-pip` packages.\
Requires the `pyaxmlparser` python module, you can install it using `pip install pyaxmlparser`. (used to get apk file details)\
First clone the repo and then cd to the repo.\
Then run the python file:
```
sudo -E python ./runme.py /path/to/system.img
```
The output should be `slimmed.img`.

## Usage on Windows
Install WSL (Windows Subsystem for Linux) and then follow linux instructions in your WSL environment.
