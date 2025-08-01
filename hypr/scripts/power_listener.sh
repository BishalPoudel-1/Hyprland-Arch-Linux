#!/bin/bash

# Get the primary battery
BATTERY=$(ls /sys/class/power_supply | grep 'BAT' | head -n 1)

# Exit if no battery is found
if [ -z "$BATTERY" ]; then
    exit 0
fi

# Store the initial status
PREVIOUS_STATUS=$(cat "/sys/class/power_supply/$BATTERY/status")

while true; do
    CURRENT_STATUS=$(cat "/sys/class/power_supply/$BATTERY/status")

    if [ "$CURRENT_STATUS" != "$PREVIOUS_STATUS" ]; then
        if [ "$CURRENT_STATUS" = "Discharging" ]; then
            notify-send "Power Unplugged" "Running on battery" -i "󰁹" -u "critical" -t 5000
        elif [ "$CURRENT_STATUS" = "Charging" ]; then
            notify-send "Power Plugged In" "Charging..." -i "󰂄" -u "low" -t 5000
        fi
        PREVIOUS_STATUS="$CURRENT_STATUS"
    fi
    sleep 2
done