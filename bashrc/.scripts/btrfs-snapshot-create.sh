#!/bin/bash

btrfs subvolume snapshot -r / /.snapshots/$(date +%Y-%m-%d)
