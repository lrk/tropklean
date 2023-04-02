#!/usr/bin/env bash

echo "ASLR: " && cat  /proc/sys/kernel/randomize_va_space

while true; do
    socat TCP-LISTEN:1337,fork,reuseaddr EXEC:"/service/tropklean",stderr
    sleep 0.5
done