#!/bin/env bash
#
# Name: copypaste
# Author: Blaz P
#


USAGE="
Usage:	copypaste [-f, -t] filename or text [-p, -x]
	
	-f	copy file content to buffer,
	-t	copy input text to buffer.
	-p	primary buffer only
	-x	X clipboard only

	Default is to copy text to both clipboards.
	"

OPTION="$1"
ARGUMENT="$2"
BUFFER="$3"

# Check if there is enough agruments
if [ "$#" -lt "1" ]; then
	echo "$USAGE"
	exit 0
fi

if [ "$#" -lt "2" ]; then
	echo "
	Missing arguments"
	echo "$USAGE"
	exit 1
fi

# Check first argument
if [ "$OPTION" = "-f" ]; then
	if [ -f "$ARGUMENT" ]; then # Check if file exists
	: # If true do nothing       
	else 
		echo "Must use existing file or -t option"
		exit 1
	fi
if [ "$#" -gt "2" ]; then # Check if there is second option
if [ "$BUFFER" = "-p" ]; then # Check if second argument is -p
	 cat "$ARGUMENT" | xclip -selection "primary"
	 exit 0
 elif [ "$BUFFER" = "-x" ]; then
	  cat "$ARGUMENT" | xclip -selection "clipboard"
	  exit 0
  else
	echo "
	wrong argument"
	echo "$USAGE"
	exit 1
fi	

else
	cat "$ARGUMENT" | xclip -selection "clipboard"
	cat "$ARGUMENT" | xclip -selection "primary"
fi

elif [ "$OPTION" = "-t" ]; then

if [ "$#" -gt "2" ]; then
if [ "$BUFFER" = "-p" ]; then
         echo "$ARGUMENT" | xclip -r -selection "primary"
         exit 0
 elif [ "$BUFFER" = "-x" ]; then
          echo "$ARGUMENT" | xclip -r -selection "clipboard"
          exit 0     
  else               
        echo "
        wrong argument"
        echo "$USAGE"
	exit 1
fi

else
        echo "$ARGUMENT" | xclip -r -selection "clipboard"
        echo "$ARGUMENT" | xclip -r -selection "primary"

fi

else
	echo "$USAGE"
	exit 1
fi
	exit 0
