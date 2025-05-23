#!/bin/bash

options=$(printf "Add\nRemove\nList")
option=$(gum choose $options)

if [ "$option" = "Add" ];
  devices=$(printf "station list" | iwctl | grep con | awk '{print $2}')
  device=$(gum choose $devs --header "What device do you want to connect?")
  networks=$(printf "station $device scan\nstation $device get-networks" | iwctl)
  network=$(gum choose $networks --header "What network do you want to go to?")
  enterprise=$(gum choose $(printf 'Yes\nNo') --header "Is it WPA & WPA2 Enterprise?")
  
  if [ "$enterprise" = "Yes" ]; then
    auths=$(gum choose $(printf 'PWD\nTSL\nTTLS\nPEAP') --header "What kind of authentication does it use?")
    echo "[Security]" > $network.8021x
    echo "EAP-Method=$auths" >> $network.8021x
    identity=$(gum input --header "What is your identity given by your organization? i.e. username, email")
    echo "EAP-Identity=$identity" >> $network.8021x
  fi

fi
