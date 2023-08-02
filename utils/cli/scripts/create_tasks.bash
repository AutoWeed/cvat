#!/bin/bash
task_file=$1
project_id=$2
hostname=$3
username=$4
password=$5
while IFS="," read -r task_id task_name share_dir assignee_id
do
  echo "Task name: $task_name"
  echo "Share directory: $share_dir"
  echo "Assignee ID: $assignee_id"
  python3 cli.py --auth "$username:$password" --server-host "$hostname" \
      create "$task_name" \
      share "$share_dir" \
      --project_id 23 --assignee_id "$assignee_id" --image_quality 100
  echo ""
done < <(tail -n +2 "$task_file")
