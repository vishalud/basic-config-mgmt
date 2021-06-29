#!/usr/bin/env bash

#The aim of this tool is to mimic config management tool. It does so by, looking for updates and existing files specified by a user, before proceeding to setup
#and configure a PHP stack to run a simple PHP web app that echo's Hello World
#Refer README.md for more information

#remove packages specified in uninstall.txt

#Only run if uninstall.txt is not empty
if [ -s pkgs/uninstall.txt ]; then
  #Declare and populate an array removal_list with the names of packages to be uninstalled
  declare -a removal_list
  while IFS='\n' read -r value; do
    removal_list+=( "${value}" )
  done < "pkgs/uninstall.txt"

  # Iterate over removal_list array and reemove packages if not already removed.
  for del_pkg in "${removal_list[@]}"
  do
    if dpkg -l | grep -i "${del_pkg}"; then
      sudo apt-get remove "${del_pkg}" # Uninstall packages from removal_list array
      sudo apt-get autoremove # Remove packages that arent genrally needed
      sudo apt-get purge -y $(dpkg --list |grep '^rc' |awk '{print $2}') # Remove obsolete config files
      sudo apt-get clean # Run apt-get clean
    fi
  done
fi

# install packages specified in install.txt

# Runs only if install_list.txt is not empty
if [ -s pkgs/install.txt ]; then
  #Declare and populate an array install_list with the names of packages to be installed
  declare -a install_list
  while IFS='\n' read -r value; do
    install_list+=( "${value}" )
  done < "pkgs/install.txt"

  # Iterate install_list array. Install if not already installed.
  for install_pkg in "${install_list[@]}"
  do
    if ! dpkg -l | grep "${install_pkg}"; then
      sudo apt-get install -y "${install_pkg}"
      fi
  done
fi

# --------------------------
# Setting Metadata and Content
# --------------------------

# Replace default index.html with index.php if the file exists
if [ -f "/var/www/html/index.html" ]; then
  sudo rm /var/www/html/index.html
  touch /var/www/html/index.php
fi

# Build our associative array from key val pairs in metadata.txt
# Note: Separator and order are important in this text file

# Runs only if uninstall list is not empty
if [ -s metadata.txt ]; then
  declare -A metadata
  while IFS== read -r key value; do
    metadata[$key]=$value
  done < "metadata.txt"
  sudo chmod "${metadata[permissions]}" "${metadata[file]}"
  sudo chown "${metadata[owner]}" "${metadata[file]}"
  sudo chgrp "${metadata[group]}" "${metadata[file]}"
  sudo echo "${metadata[content]}" > "${metadata[file]}"
fi

# --------------------------
# Check for Required Restart
# --------------------------
needrestart
