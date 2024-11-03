#!/bin/sh
if [ ! -f folder-list ]; then
    echo "folder-list not found. This file is required because it contains the names and categories of the folders to be created."
    exit 1
fi

folder_path=()
folder_name=()
folder_categories=()

source ./folder-list

if [[ ${#folder_path[@]} != ${#folder_name[@]} || ${#folder_path[@]} != ${#folder_categories[@]} ]]; then
   echo "folder-list has an invalid structure. Perhaps in some field you used = instead of +=."
   exit 1
fi

arr_to_fmt_str() {
   str=$@
   str=${str// /\',\'}
   str="['${str}']"
   echo $str
}

GS_SCHEMA=org.gnome.desktop.app-folders
GS_PATH=/org/gnome/desktop/app-folders/folders

remove_folders() {
   gsettings reset-recursively $GS_SCHEMA
   dconf reset -f $GS_PATH/
}

create_folders() {
   for i in ${!folder_path[@]}; do
      gsettings set $GS_SCHEMA.folder:$GS_PATH/${folder_path[$i]}/ name "${folder_name[$i]}"
      gsettings set $GS_SCHEMA.folder:$GS_PATH/${folder_path[$i]}/ categories "${folder_categories[$i]}"
   done

   gsettings set $GS_SCHEMA folder-children "$(arr_to_fmt_str "${folder_path[@]}")"
}

print_help() {
   echo -e 'Usage:\n   create-folders.sh\t\t\tdelete existing folders and create new ones\n   create-folders.sh clean\t\tdelete existing folders without creating new ones'
}

if [ "$#" -eq 0 ]; then
   remove_folders
   create_folders
elif [ $1 == 'clean' ]; then
   remove_folders
elif [ $1 == 'help' ]; then
   print_help
else
   echo -e "Invalid option!\n"
   print_help
fi
