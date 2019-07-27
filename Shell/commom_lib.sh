#!/bin/bash 

_log_date() {
  echo $(date '+%Y-%m-%d W%U:d%u %H:%M:%S:%3N %Z')
}


get_elapsed_time() {
  echo "$(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
}
