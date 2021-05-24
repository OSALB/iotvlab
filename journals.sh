#!/usr/bin/env bash
## Personal journal script. Assumes the following:
###     - Your preferred editor is vim
###     - All journals will be placed in the same directory 
###     - Journals will organized in directories by year, month, day (i.e. 2020/Nov/25.txt)

## Journal names, separated by '\n' character
journals="journal\nmeditations_journal\nchurch_journal"

## Script assumes that all journals will be placed in the same root directory
root_dir="$HOME/sync"
mkdir -p "$root_dir"

## Figure out if user wants to read, write, edit or cancel
action="$(printf "read\nwrite\nedit\ncancel" | fzf)"

if [[ "$action" == "cancel" ]]
then
	exit 0
fi

## Journal selection
target_journal="$(printf "$journals" | fzf)"

## Read in journal
if [[ "$action" == "read" ]]
then
	target="$root_dir/$target_journal"
	mkdir -p "$target"

	## Loop through journal directories until journal file is selected
	while true
	do
		if [[ -d $target ]]
		then
			target_name="$(ls $target | fzf)"
			target="$target/$target_name"
		elif [[ -f $target ]]
		then
			less $target
			break
		fi
	done
fi

## Write in journal
if [[ "$action" == "write" ]]
then
	target="$root_dir/$target_journal"
	mkdir -p "$target"
  
	year=$(date +%Y)
	month=$(date +%h)
	day=$(date +%d)

	time=$(date +%H:%M:%S)

	mkdir -p "$target/$year/$month"
	file="$target/$year/$month/$day.txt"
  
	printf "[$time]\n" >> $file

	vim + $file

	printf "\n" >> $file
fi

## Edit journal entry
if [[ "$action" == "edit" ]]
then
	target="$root_dir/$target_journal"
	mkdir -p "$target"

	## Loop through journal directories until journal file is selected
	while true
	do
		if [[ -d $target ]]
		then
			target_name="$(ls $target | fzf)"
			target="$target/$target_name"
		elif [[ -f $target ]]
		then
			vim + $target
			break
		fi
	done
fi
