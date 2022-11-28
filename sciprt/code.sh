#!/bin/bash

folder=$(find ~ ~/Desktop ~/Github ~/.config -mindepth 1 -maxdepth 1 -type d | fzf)
if [ -z $folder ]; then
  exit 0
else
  code $folder
  cd $folder
fi
