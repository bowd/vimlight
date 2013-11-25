#!/bin/bash

set -e

BACKUP_DIR=~/.vim.bak

GREEN='\033[32m'
RED='\033[31m'
YELLOW='\033[33m'
RESET='\033[39m'

function info {
	echo -e "[${GREEN}info${RESET}] $1"
}
function error {
	echo -e "[${RED}error${RESET}] $1"
}


info "Removing all current vim configs."
for entry in `ls -d ~/.vim* | grep -v $BACKUP_DIR`; do
	info "     $entry"
	rm -rf $entry
done

if [ -d $BACKUP_DIR]; then
	info "Restoring old configs from $YELLOW $BACKUP_DIR $RESET"
	mv $BACKUP_DIR/.* ~/.
	rm -rf $BACKUP_DIR
else
	error "No backup to restore"
fi

echo -e "$YELLOW Done. $RESET"
