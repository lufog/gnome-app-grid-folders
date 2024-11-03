#!/bin/sh
GS_SCHEMA=org.gnome.desktop.app-folders
GS_PATH=/org/gnome/desktop/app-folders/folders

folder_path=()
folder_name=()
folder_categories=()

source ./folder-list

# Helpers
arr_to_fmt_str() {
   str=$@
   str=${str// /\',\'}
   str="['${str}']"
   echo $str
}

# Remove existing folders
gsettings reset-recursively $GS_SCHEMA
dconf reset -f $GS_PATH/

# Create new folders
for i in ${!folder_path[@]}; do
   gsettings set $GS_SCHEMA.folder:$GS_PATH/${folder_path[$i]}/ name "${folder_name[$i]}"
   gsettings set $GS_SCHEMA.folder:$GS_PATH/${folder_path[$i]}/ categories "${folder_categories[$i]}"
done

gsettings set $GS_SCHEMA folder-children "$(arr_to_fmt_str "${folder_path[@]}")"
