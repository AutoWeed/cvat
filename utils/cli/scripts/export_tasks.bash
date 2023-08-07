#!/bin/bash

# Arguments
task_file=${1:-}
hostname=${2:-}
username=${3:-}
password=${4:-}
date_str="$(date +'%Y%m%d')"

while IFS="," read -r task_id task_name status project_id
do
  echo "Started exporting task $task_id"
  python3 ../cli.py --auth "$username:$password" --server-host "$hostname" \
    dump --format "CVAT for images 1.1" "$task_id" task_"$task_id"_"$date_str".zip
  echo "Finished exporting task $task_id".
done < <(tail -n +2 "$task_file")