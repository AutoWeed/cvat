#!/bin/bash
task_file=$1
hostname=$2
username=$3
password=$4
while IFS="," read -r task_id task_name share_dir assignee_id
do
  echo "Task ID: $task_id"
  echo "Task Name: $task_name"
  echo "Annotations file: task_annotations/$task_id.zip"
  python3 cli.py --auth "$username:$password" --server-host "$hostname" \
      upload "$task_id" "task_annotations/$task_id.zip" --format "ImageNet 1.0"
  echo ""
done < <(tail -n +2 "$task_file")
