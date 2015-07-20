#!/bin/bash

logging_file="filesystem_usage"

collect_filesystem_info ()
# Collect the file system sizes
{
  current_date=`date | tr -d 'n' `
  filesystem_size=`df -h | grep 'mapper\|none' |  awk ' {print $5} '`
  filesystem_size_element=( $filesystem_size )
  echo $current_date$(printf ",%s" "${filesystem_size_element[@]//%}") >> $logging_file
}

create_header ()
# Create header for the file if required
{
  header_info=`df -h | grep 'mapper\|none' | awk ' {print $1 } '`
  header=`echo $header_info | sed 's/ /,/'`
  if [ ! -f $logging_file ]; then
      echo date,${header} >> $logging_file
 fi
}

create_header
collect_filesystem_info
