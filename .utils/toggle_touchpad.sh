#!/bin/bash
device="ELAN0412:01 04F3:3240 Touchpad"
id=$(xinput list --id-only "$device")

if [ -z "$id" ]; then
    echo "Device not found"
    exit 1
fi

state=$(xinput list-props "$id" | grep "Device Enabled" | awk '{print $4}')
if [ "$state" -eq 1 ]; then
    xinput disable "$id"
else
    xinput enable "$id"
fi
