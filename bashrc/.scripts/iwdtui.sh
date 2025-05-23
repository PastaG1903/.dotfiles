#!/bin/bash

while true; do

  options=$(printf "Add\nRemove\nList\nExit")
  option=$(gum choose $options)

  if [ "$option" = "Add" ]; then
    devices=$(printf "station list" | iwctl | grep con | awk '{print $2}')
    device=$(gum choose $devices --header "What device do you want to connect?")
    printf "station $device scan" | iwctl
    networks=$(iwctl station $device get-networks | awk 'NR > 5 {print $1}')
    network=$(gum choose $networks --header "What network do you want to go to?")
    enterprise=$(gum choose $(printf 'WPA-PSK\nWPA Enterprise\nOther') --header "How is the network secured?")

    if [ "$enterprise" = "WPA-PSK" ]; then
      echo "[Security]" > $network.psk
      passp=$(gum input --header "What is the passphrase?")
      echo "Passphrase=$passp" >> $network.psk
    fi
    
    if [ "$enterprise" = "WPA Enterprise" ]; then
      auths=$(gum choose $(printf 'PWD\nTSL\nTTLS\nPEAP') --header "What kind of authentication does it use?")
      echo "[Security]" > $network.8021x
      echo "EAP-Method=$auths" >> $network.8021x
      identity=$(gum input --header "What is your identity given by your organization? i.e. username, email")
      echo "EAP-Identity=$identity" >> $network.8021x

      if [ "auths" = "PWD" ]; then
        password=$(gum input --header "What is the password for $network?")
        echo "EAP-Password=$password" >> $network.8021x
      fi
      if [ "auths" = "PEAP" ]; then
        echo "EAP-PEAP-Phase2-Method=MSCHAPV2" >> $network.8021x
        echo "EAP-PEAP-Phase2-Identity=$identity" >> $network.8021x
        password=$(gum input --header "What is the password for $network?")
        echo "EAP-PEAP-Phase2-Password=$password" >> $network.8021x
      fi

      echo "" >> $network.8021x
      echo "[Settings]" >> $network.8021x
      echo "AutoConnect=true" >> $network.8021x
      
    fi

  fi
  if [ "$option" = "Exit" ]; then
    break
  fi
done
