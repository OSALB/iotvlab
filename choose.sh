#!/usr/bin/env bash

if ! command -v choose > /dev/null
then
	echo 'Please install choose.'
fi

if ! command -v buku > /dev/null
then
	echo 'Please install buku.'
fi

if ! command -v jq > /dev/null
then
	echo 'Please install jq.'
fi

selection=$(buku -p -j | jq -r '.[] | "\(.title) || (\(.index))"' | choose | cut -d'|' -f3 | tr -d '( )')

if [[ ${selection} == "" ]]
then
	exit
fi

buku -o ${selection}
