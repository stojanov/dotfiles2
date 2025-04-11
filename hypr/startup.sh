#!/bin/bash

get_property_value() {
    local property_name="$1"
    local file_path="$2"
    
    value=$(grep -oP "^${property_name}\s*=\s*\"[^\"]+\"" "$file_path" | sed 's/^.*=\s*"\([^"]*\)".*/\1/')
    
    echo "$value"
}

# Example usage
config_file="/home/sto/.config/hypr/cache.txt"
wallpaper_value=$(get_property_value "wallpaper" "$config_file")

# Run the commands if wallpaper value is found
if [ -n "$wallpaper_value" ]; then
    hyprctl hyprpaper reload ,"$wallpaper_value"
    wallust run "$wallpaper_value"
else
    echo "Wallpaper property not found"
fi
