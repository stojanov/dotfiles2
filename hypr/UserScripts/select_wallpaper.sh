wall_dir="$HOME/pics/wallpapers/"

rofi_command="rofi -show -dmenu -show-icons -config $HOME/.config/rofi/select-wallpaper.rasi"

PICS=($(ls "${wall_dir}" | grep -E ".jpg$|.jpeg$|.png$|.gif$"))

echo $PICS

set_property_value() {
    local property_name="$1"
    local new_value="$2"
    local file_path="$3"

    # Check if the property already exists in the file
    if grep -q "^${property_name}=" "$file_path"; then
        # If the property exists, update its value
        sed -i "s|^$property_name=\"[^\"]*\"|$property_name=\"$new_value\"|" "$file_path"
    else
        # If the property doesn't exist, append it to the end of the file
        echo "${property_name}=\"${new_value}\"" >> "$file_path"
    fi
}

# Example usage
config_file="/home/sto/.config/hypr/cache.txt"

menu() {
  for i in "${!PICS[@]}"; do
    # Displaying .gif to indicate animated images
    if [[ -z $(echo "${PICS[$i]}" | grep .gif$) ]]; then
      printf "$(echo "${PICS[$i]}" | cut -d. -f1)\x00icon\x1f${wall_dir}/${PICS[$i]}\n"
    else
      printf "${PICS[$i]}\n"
    fi
  done
}

main() {
    choice=$(menu | ${rofi_command})
  # No choice case
  if [[ -z $choice ]]; then
    exit 0
  fi

  # Find the index of the selected file
  pic_index=-1
  for i in "${!PICS[@]}"; do
    filename=$(basename "${PICS[$i]}")
    if [[ "$filename" == "$choice"* ]]; then
      pic_index=$i
      break
    fi
  done

  if [[ $pic_index -ne -1 ]]; then
      wall_path="${wall_dir}/${PICS[$pic_index]}"
      echo "WALL PATH: $wall_path"
        hyprctl hyprpaper reload , "$wall_path"
        wallust run "$wall_path"
        set_property_value "wallpaper" "$wall_path" "$config_file"
  else
    echo "Image not found."
    exit 1
  fi
}

main
