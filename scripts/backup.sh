#!/usr/bin/env bash

rsync -avh -e ssh --delete --exclude '.cache/' --exclude '.cargo/' --exclude '.gradle/' --stats ~ "192.168.1.77:/hdd/backups/${HOSTNAME}"
