#!/bin/bash

languages=$(echo "typescript rust golang" |tr " " "\n")
core_utils=$(echo "find xargs sed awk bc sort head tail cat read grep" |tr " " "\n")

selected=$(echo -e "$languages\n$core_utils" | fzf) 

if [ -z $selected ]; then
  exit 0
fi

read -p "query: " query

if echo "$languages" | grep -qs $selected; then
  curl cht.sh/$selected/$(echo "$query" | tr " " "+") | less -r
else
  curl cht.sh/$selected~$query | less -r
fi 
