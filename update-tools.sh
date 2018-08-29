#!/bin/bash


# Usage function
function usage(){
    echo -e "Usage : $0 [options]"
    echo -e "\nOptions :"
    echo -e "\t-p <path>: The path where all tools are stored"
    exit 1
}

# Colors
RED='\033[0;31m'
Blue='\033[0;34m'
NC='\033[0m' # No Color

# Empty array to store all raised errors
errors=

function isGitDir(){
    for dir in $1/.*; do
	if [ ! -d $dir ]; then
	    continue
	fi
	
	if [ $(basename $dir) = ".git" ]; then
	    echo 1 # True
	    return 1
	fi
    done

    echo 0 # False
    return 0
}

function getDir(){
    rep="$1"
    for dir in $rep/*; do
	# Is a directory
	if [ ! -d "$dir" ]; then
	    continue
	fi

	# echo -e $dir
	# Test if .git folder exists
	if [ $(isGitDir "$dir") -eq 1 ]; then
	    update "$dir"
	else
	    getDir "$dir"
	fi
    done
}

function update(){
    path="$1"
    name=$(basename $path)
    echo -e "Start the update of $name"
    status=$( cd $path && git pull 2>&1 )
    #echo $status
    # Check if no errors was raised
    if [[ $status =~ "Abandon" ]]; then
	errors+=("$path")
    fi
}

# Test the number of args
if [ $# -gt 2 ]; then
    echo -e "Wrong number of args"
    usage
fi

# Check options
while getopts ":p:h" opt; do
    case $opt in
	h)
	    usage
	    exit 1
	    ;;
	p)
	    # Check if the path is valid
	    if [ ! -d $OPTARG ]; then
		echo -e "The given path seems to not exist !"
		usage
		exit 1
	    fi
	    getDir $OPTARG
	    ;;
	\?)
	    echo "Invalid option: -$OPTARG"
	    usage
	    ;;
	:)
	    echo "Missing arg after -$OPTARG"
	    usage
	    ;;
    esac
done

if [ errors ]; then
    echo -e "${RED}These tools require your attention to be updated${NC}"
    for error in ${errors[@]}; do
	echo -e "${Blue}$error${NC}"
    done
fi
	
