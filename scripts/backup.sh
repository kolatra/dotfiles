#!/bin/bash

rsync -a -e ssh --delete --exclude 'Videos/' --exclude '.local/' --exclude '.cache/' --exclude '.cargo/' --exclude '.gradle/' --stats ~ 192.168.1.77:/hdd/backups/pandora
