#!/bin/bash

_VERSION="1.2"

source /home/ruben/Documents/scripts/config_login_drupal.sh


select_source_server () {

  _SOURCE_SITES=()

  for i in "${!_SOURCE_SITES_ASSOCIATIVE[@]}"
  do
    _SOURCE_SITES+=($i)
  done

  IFS=$'\n' sorted=($(sort <<<"${_SOURCE_SITES[*]}"))
  sorted+=("Quit")


  select SOURCE_SITE in "${sorted[@]}";do      
    if [ "$SOURCE_SITE" = "Quit" ]; then
      echo done
      exit
    else       		
      URL="$(ssh "${_SOURCE_SITES_ASSOCIATIVE[$SOURCE_SITE]}" drush @"$SOURCE_SITE" uli)"          
      echo "ssh "${_SOURCE_SITES_ASSOCIATIVE[$SOURCE_SITE]}" drush @"$SOURCE_SITE" uli";
	    xdg-open "${URL}"
      ssh "${_SOURCE_SITES_ASSOCIATIVE[$SOURCE_SITE]}" drush @"$SOURCE_SITE" dd | xclip -selection c;


      SITE_PATH_WITH_TRASH="$(ssh "${_SOURCE_SITES_ASSOCIATIVE[$SOURCE_SITE]}" drush sa @"$SOURCE_SITE" | grep  'site_path')";

      
      prefix="'site_path' => '";      
      suffix="',"
      echo "$SITE_PATH_WITH_TRASH" | sed -e "s/$prefix//" -e "s/$suffix//" | xclip -selection c;


      exit
    fi
  done
}
###---------------------------------------### Main Program ##---------------------------------------##
clear

select_source_server 
