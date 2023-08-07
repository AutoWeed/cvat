#!/bin/bash

# Arguments
id=${1:-}
hostname=${2:-}
username=${3:-}
password=${4:-}
date_str="$(date +'%Y%m%d')"
project_tasks=project_"$id"_tasks_"$date_str".csv
tmp_tasks=tmp_tasks_"$date_str".csv

# Generate tmp csv with all tasks from CVAT
python3 ../cli.py --auth "$username:$password" --server-host "$hostname" ls > "$tmp_tasks"

# Write header to project tasks csv file
echo "task_id,task_name,task_status,project_id" > "$project_tasks"

while IFS="," read -r task_id task_name task_status project_id
do
  if [[ "$project_id" == "$id" ]]; then
    echo "$task_id,$task_name,$task_status,$project_id"
    echo "$task_id,$task_name,$task_status,$project_id" >> "$project_tasks"
  fi
done < "$tmp_tasks"
