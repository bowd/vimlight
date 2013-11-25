#!/bin/bash

set -e

BACKUP_DIR=~/.vim.bak
REPO="git@github.com:bogdan-dumitru/vimlight.git"

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[39m"
INFO="[$GREEN""info""$RESET]"
ERROR="[$RED""error""$RESET]"


function backup_config {
	# Check if there's already a backup
	if [ -e "$BACKUP_DIR" ]; then
		echo -e "$ERROR $BACKUP_DIR exists. Please manually rotate / remove the current backup and try again."
		exit
	fi

	# Create the backup dir
	echo -e "$INFO Backing up current vim configuration to $GREEN $BACKUP_DIR $RESET"
	mkdir "$BACKUP_DIR"
	# Move all vim related folders to backup
	for entry in `ls -d ~/.vim* | grep -v $BACKUP_DIR`; do
		echo -e "$INFO     $entry"
		mv "$entry" $BACKUP_DIR
	done
}

function setup_config {
	# Clone repo into ~/.vim
	echo ""
	echo -e "$INFO Downloading vimlight from github..."
	git clone $REPO  ~/.vim

	# Link .vimrc file
	echo ""
	echo -e "$INFO Linking .vimrc to ~"
	ln -s ~/.vim/.vimrc ~/.vimrc

	# Create .vimrc.local from example?
	echo ""
	echo -e "$INFO Creating ~/.vimrc.local"
	finish="-1"
	while [ "$finish" = '-1' ]; do
		finish="1"
		read -p "Do you want to setup .vimrc.local from the example one provided (https://github.com/bogdan-dumitru/vimlight/blob/master/.vimrc.local.example)? [Yn] " yn
		case $yn in
			""|[Yy] ) cp ~/.vim/.vimrc.local.example ~/.vimrc.local ;;
			[Nn]    )  touch ~/.vimrc.local ;;
			*       ) finish="-1" ;;
		esac
	done

	echo ""
	echo -e "$INFO Creating ~/.vimrc.bundles.local"
	# Create an empty bundle.local
	touch ~/.vimrc.bundles.local

	# Setup Vundle
	echo ""
	echo -e "$INFO Downloading the vundle plugin from github..."
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

	# Install bundles
	echo ""
	echo -e "$INFO Installing bundles"
	vim +BundleInstall +qall

	echo -e "$GREEN""Setup complete.""$RESET"
	echo -e "$YELLOW""Add your personal vim config to ~/.vimrc.local""$RESET"
	echo -e "$YELLOW""Add additional bundles to ~/.vimrc.bundle.local""$RESET"
}

function main {
	# Backup current vim config
	backup_config
	# Install the new vim config from git
	setup_config
}

main
