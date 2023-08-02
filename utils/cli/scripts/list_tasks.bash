#!/bin/bash

# Arguments
id=${1:-21}
status=${2:-completed}
hostname=$3
username=$4
password=$5
date_str="$(date +'%Y%m%d')"
specific_tasks=project_"$id"_"$status"_tasks_"$date_str".csv
all_tasks=all_tasks_"$date_str".csv

echo "$all_tasks"
echo "$specific_tasks"

python3 cli.py --auth "$username:$password" --server-host "$hostname" ls > "$all_tasks"

echo "task_id,task_name,task_status,project_id" > "$specific_tasks"

while IFS="," read -r task_id task_name task_status project_id
do
  if [[ "$project_id" == "$id" ]]; then
    if [[ "$status" == "all" ]]; then
      echo "$task_id,$task_name,$task_status,$project_id"
      echo "$task_id,$task_name,$task_status,$project_id" >> "$specific_tasks"
    elif [[ "$task_status" == "$status" ]]; then
      echo "$task_id,$task_name,$task_status,$project_id"
      echo "$task_id,$task_name,$task_status,$project_id" >> "$specific_tasks"
    fi
  fi
done < "$all_tasks"

rm "$all_tasks"
