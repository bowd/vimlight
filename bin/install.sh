#!/bin/bash

BACKUP_DIR=~/.vim.bak
REPO="git@github.com:bogdan-dumitru/vimlight.git"

function backup_config {
	# Check if there's already a backup
	if [ -e "$BACKUP_DIR" ]; then
		echo "$BACKUP_DIR exists. Please manually rotate / remove the current backup and try again."
		exit
	fi

	# Create the backup dir
	mkdir "$BACKUP_DIR"
	# Move all vim related folders to backup
	for entry in `ls -d ~/.vim* | grep -v $BACKUP_DIR`; do
		echo "Moving $entry to $BACKUP_DIR..."
		mv "$entry" $BACKUP_DIR
	done
}

function setup_config {
	# Clone repo into ~/.vim
	git clone $REPO  ~/.vim

	# Link .vimrc file
	ln -s ~/.vim/.vimrc ~/.vimrc

	# Create .vimrc.local from example?
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

	# Create an empty bundle.local
	touch ~/.vimrc.bundle.local

	# Setup Vundle
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

	# Install bundles
	vim +BundleInstall +qall

	echo "Setup complete."
	echo "Add your personal vim config to ~/.vimrc.local"
	echo "Add additional bundles to ~/.vimrc.bundle.local"
}

function main {
	# Backup current vim config
	backup_config
	# Install the new vim config from git
	setup_config
}

main
