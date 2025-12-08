#!/bin/bash

sudo btrfs subvolume snapshot -r / /.snapshots/$(date +%Y-%m-%d)
