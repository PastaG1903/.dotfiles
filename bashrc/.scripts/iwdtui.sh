#!/bin/bash

while true; do

  options=$(printf "Add\nRemove\nList\nExit")
  option=$(gum choose $options)

  if [ "$option" = "Add" ]; then
    devices=$(printf "station list" | iwctl | grep con | awk '{print $2}')
    device=$(gum choose $devices --header "What device do you want to connect?")
    printf "station $device scan" | iwctl
    networks=$(iwctl station $device get-networks | sed -r 's/\x1B\[[0-9;]*[mK]//g' | awk 'BEGIN { start = 0 } /^[-]+$/ { start++; next } NF > 0 { print $1 }' | tail -n +3)
    network=$(gum choose $networks --header "What network do you want to go to?")
    enterprise=$(gum choose $(printf 'WPA-PSK\nWPA-Enterprise\nOther') --header "How is the network secured?")
    if [ "$enterprise" = "nothing selected" ]; then
      break

    elif [ "$enterprise" = "Other" ]; then
      password=$(gum input --header "What is the password for $network?")
      iwctl station $device connect $Network -p $password

    elif [ "$enterprise" = "WPA-PSK" ]; then
      touch $network.psk
      echo "[Security]" > "$network".psk
      passp=$(gum input --header "What is the passphrase?")
      echo "Passphrase=$passp" >> "$network".psk
      sudo mv ./$network.psk /var/lib/iwd
    
    elif [ "$enterprise" = "WPA-Enterprise" ]; then
      auths=$(gum choose $(printf 'PWD\nPEAP\nTTLS') --header "What kind of authentication does it use?")
      echo "[Security]" > "$network".8021x
      echo "EAP-Method=$auths" >> "$network".8021x
      identity=$(gum input --header "What is your identity given by your organization? i.e. username, email")
      echo "EAP-Identity=$identity" >> "$network".8021x

      if [ "$auths" = "PWD" ]; then
        password=$(gum input --header "What is the password for $network?")
        echo "EAP-Password=$password" >> "$network".8021x
      fi

      if [ "$auths" = "PEAP" ]; then
        echo "EAP-PEAP-Phase2-Method=MSCHAPV2" >> "$network".8021x
        echo "EAP-PEAP-Phase2-Identity=$identity" >> "$network".8021x
        password=$(gum input --header "What is the password for $network?")
        echo "EAP-PEAP-Phase2-Password=$password" >> "$network".8021x
        cacert=$(gum input --header "Please write the path to the CA certificate. Leave blank if none")
        if [ "$cacert" != "" ]; then
          echo "EAP-PEAP-CACert=$cacert" >> "$network".8021x
        fi
        mask=$(gum input --header "Please write the server domain mask (if any)")
        if [ "$mask" != "" ]; then
          echo "EAP-PEAP-ServerDomainMask=$mask" >> "$network".8021x
        fi
      fi

      if [ "$auths" = "TTLS" ]; then
        echo "EAP-TTLS-Phase2-Method=Tunneled-PAP" >> "$network".8021x
        echo "EAP-TTLS-Phase2-Identity=$identity" >> "$network".8021x
        password=$(gum input --header "What is the password for $network?")
        echo "EAP-TTLS-Phase2-Password=$password" >> "$network".8021x
        cacert=$(gum input --header "Please write the path to the CA certificate. Leave blank if none")
        if [ "$cacert" != "" ]; then
          echo "EAP-TTLS-CACert=$cacert" >> "$network".8021x
        fi
        mask=$(gum input --header "Please write the server domain mask (if any)")
        if [ "$mask" != "" ]; then
          echo "EAP-TTLS-ServerDomainMask=$mask" >> "$network".8021x
        fi
      fi

      echo "" >> "$network".8021x
      echo "[Settings]" >> "$network".8021x
      echo "AutoConnect=true" >> "$network".8021x

      sudo mv ./$network.8021x /var/lib/iwd
      
    fi

    iwctl station $device connect $network

    echo "You should be now connected to $network"

  fi

  if [ "$option" = "Remove" ]; then
    networks=$(sudo lsd -1F /var/lib/iwd/ | grep -v /)
    ntr=$(gum choose $networks --header "What network do you want to remove?")
    sudo rm /var/lib/iwd/ntr
  fi

  if [ "$option" = "List" ]; then
    networks=$(sudo lsd -1F /var/lib/iwd/ | grep -v /)
    printf $networks
  fi

  if [ "$option" = "Exit" ]; then
    break
  fi
done
