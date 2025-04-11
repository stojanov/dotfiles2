#!/usr/bin/bash

echo 1 > /sys/class/hwmon/hwmon10/pwm4_enable
/usr/bin/kool /home/sto/.config/hypr/kool.toml
