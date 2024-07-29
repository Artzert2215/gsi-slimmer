#!/bin/bash

umount d

e2fsck -f -y slimmed.img || true
resize2fs -M slimmed.img
