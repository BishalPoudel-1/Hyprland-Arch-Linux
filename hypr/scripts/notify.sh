#!/bin/bash

# A more advanced notification script for Hyprland

# --- Configuration ---
TIMEOUT=2000 # Milliseconds

# --- Icons (requires a Nerd Font) ---
ICON_BRIGHTNESS_HIGH='󰃠'
ICON_BRIGHTNESS_MED='󰃝'
ICON_BRIGHTNESS_LOW='󰃞'

ICON_VOL_HIGH='󰕾'
ICON_VOL_MED='󰖀'
ICON_VOL_LOW='󰕿'
ICON_VOL_MUTED='󰝟'

# --- Helper Functions ---
# Usage: send_notification "ID" "Icon" "Title" "Body" "Value" "Urgency"
send_notification() {
    local id="$1"
    local icon="$2"
    local title="$3"
    local body="$4"
    local value="$5"
    local urgency="$6"

    # Send the notification with hints for a progress bar, urgency, and transient display
    notify-send "$title" "$body" \
        -h "int:value:$value" \
        -h "string:x-canonical-private-synchronous:$id" \
        -u "$urgency" \
        -i "$icon" \
        -t "$TIMEOUT"
}

# --- Main Functions ---
brightness_notification() {
    local -i current_brightness=$(brightnessctl -d amdgpu_bl0 get)
    local -i max_brightness=$(brightnessctl -d amdgpu_bl0 max)
    local -i brightness_percentage=$((current_brightness * 100 / max_brightness))

    local icon
    if ((brightness_percentage >= 66)); then
        icon="$ICON_BRIGHTNESS_HIGH"
    elif ((brightness_percentage >= 33)); then
        icon="$ICON_BRIGHTNESS_MED"
    else
        icon="$ICON_BRIGHTNESS_LOW"
    fi

    local body="Current level: $brightness_percentage%"
    send_notification "brightness_notification" "$icon" "Brightness" "$body" "$brightness_percentage" "low"
}

volume_notification() {
    local is_muted=$(pamixer --get-mute)
    local -i volume=$(pamixer --get-volume)

    if [ "$is_muted" = "true" ]; then
        local body="Volume is muted"
        send_notification "volume_notification" "$ICON_VOL_MUTED" "Volume Muted" "$body" 0 "low"
    else
        local icon
        if ((volume >= 66)); then
            icon="$ICON_VOL_HIGH"
        elif ((volume >= 33)); then
            icon="$ICON_VOL_MED"
        else
            icon="$ICON_VOL_LOW"
        fi
        
        local body="Current level: $volume%"
        send_notification "volume_notification" "$icon" "Volume" "$body" "$volume" "low"
    fi
}

# --- Main Logic ---
case "$1" in
    brightness_up)
        brightnessctl -d amdgpu_bl0 set 5%+
        brightness_notification
        ;;
    brightness_down)
        brightnessctl -d amdgpu_bl0 set 5%-
        brightness_notification
        ;;
    volume_up)
        pamixer -i 5
        volume_notification
        ;;
    volume_down)
        pamixer -d 5
        volume_notification
        ;;
    volume_mute)
        pamixer -t
        volume_notification
        ;;
    *)
        echo "Usage: $0 {brightness_up|brightness_down|volume_up|volume_down|volume_mute}"
        exit 1
        ;;
esac
