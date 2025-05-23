#!/bin/bash

options=$(printf "Add\nRemove\nList")
option=$(gum choose $options)

if [ "$option" = "Add" ];
  devices=$(printf "station list" | iwctl | grep con)
  devs=""
  for elem in $devices; do
    devs=$devs" $(echo $elem | awk '{print $2}')"
  done
  device=$(gum choose $devs)
fi
