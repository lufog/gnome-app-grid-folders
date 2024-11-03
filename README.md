A small script that creates folders in the Gnome App Grid, and sets categories for the created folders.

https://github.com/user-attachments/assets/08d522ab-f668-402c-885a-de70c867d53e

> [!WARNING]
> Before creating folders, the script resets all existing folders.
>
> Also, close all applications and save any unsaved work. As there is a possibility of gnome-shell crashing.

How to use:
* download `create-folders.sh` and `folder-list` files and place them in the same folder;
* run `create-folders.sh`.

If you want to remove/add/change folders created by the script, edit the `folder-list` file.

> [!IMPORTANT]
> One folder consists of three fields, all fields are required.

```sh
# Part of the folder path in the settings file (cannot contain spaces or some special characters).
# /org/gnome/desktop/app-folders/folders/<folder_path>/
folder_path+=('Graphics')

# The folder name displayed in the App Grid.
folder_name+=('Graphics')

# App Categories, apps with matching categories will be displayed in this folder.
folder_categories+=("['Graphics','VectorGraphics']")
```

