#!/usr/bin/bash

echo 1 > /sys/class/hwmon/hwmon4/pwm4_enable
/usr/bin/kool /home/sto/.config/hypr/kool.toml
