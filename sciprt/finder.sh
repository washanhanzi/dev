#!/bin/bash

folder=$(find ~/Desktop ~/Github ~/.config -mindepth 1 -maxdepth 1 -type d | fzf)
cd $folder
