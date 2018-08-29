# Update Tools

Simple script to automate the update of github repositories. It takes only one
argument the path where all your projects are stored, then updates them.

If errors are raised during the update, it will notice you at the end of the
execution with the path of all project that has not been updated.

# Installation

To install it you just need to clone this repo and enjoy.

To use it : 

```bash
./update-tools.sh -h
Usage : ./update-tools.sh [options]

Options :
	-p <path>: The path where all tools are stored
```


```bash
./update-tools.sh -p /home/jnt/tools
Start the update of WhatWeb
Start the update of wpscan
These tools require your attention to be updated
/home/jnt/tools/IoT/PenIOTest
/home/jnt/tools/Skype-tools/LyncSniper
/home/jnt/tools/WiFi-tools/eaphammer
/home/jnt/tools/WiFi-tools/krackattacks-scripts
```
