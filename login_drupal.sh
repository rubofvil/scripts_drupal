#!/bin/bash

_VERSION="1.1"

source config_login_drupal.sh


select_source_server () {

  _SOURCE_SITES=()

  for i in "${!_SOURCE_SITES_ASSOCIATIVE[@]}"
  do
    _SOURCE_SITES+=($i)
  done

  select SOURCE_SITE in "${_SOURCE_SITES[@]}";do      
    if [ "$SOURCE_SITE" = "Quit" ]; then
      echo done
      exit
    else       		
      URL="$(ssh "${_SOURCE_SITES_ASSOCIATIVE[$SOURCE_SITE]}" drush @"$SOURCE_SITE" uli)"          
      echo "ssh "${_SOURCE_SITES_ASSOCIATIVE[$SOURCE_SITE]}" drush @"$SOURCE_SITE" uli";
			xdg-open "${URL}"  			
      exit
    fi
  done
}
###---------------------------------------### Main Program ##---------------------------------------##
clear

select_source_server 

