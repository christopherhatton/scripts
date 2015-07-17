#!/bin/bash

logging_file="/home/filesystem_usage"

collect_filesystem_info ()
# Collect the file system sizes
{
  current_date=`date | tr -d 'n' `
  filesystem_size=`df -h | grep 'mapper' |  awk ' {print $5} '`
  filesystem_size_element=( $filesystem_size )
  echo $current_date$(printf ",%s" "${filesystem_size_element[@]//%}") >> $logging_file
}

create_header ()
# Create header for the file if required
{
  header_info=`df -h | grep 'mapper\|none' | awk ' {print $1 } '`
  header_info_element=($header_info)
  if [ ! -f "$logging_file" ]; then
      echo $(printf "date,%s" "${header_info_element[@]}") >> $logging_file
  fi
}

create_header
collect_filesystem_info
