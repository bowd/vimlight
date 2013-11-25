#!/bin/bash

set -e

BACKUP_DIR="~/.vim.bak"

function backup_config {
	# Check if there's already a backup
	if [ -e $BACKUP_DIR ]; then
		echo "$BACKUP_DIR exists. Please manually rotate / remove the current backup and try again."
		exit
	fi

	# Create the backup dir
	mkdir $BACKUP_DIR
	# Move all vim related folders to backup
	for entry in `ls ~/.vim* | grep -v $BACKUP_DIR`; do
		echo "Moving $entry to $BACKUP_DIR..."
		mv $entry $BACKUP_DIR/
	done
}

function setup_config {
}

function main {
	# Backup current vim config
	backup_config
	# Install the new vim config from git
	setup_config
}

main


