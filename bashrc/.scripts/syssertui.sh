#!/bin/bash

while true; do
  services=$(systemctl list-unit-files | grep service | grep -v systemd | grep -v dbus | awk '{print $1}' | sed 's/\.[^.]*$//')
  service=$(gum filter $services --header "Choose the service to manage or select 'Exit' to exit: ")
  if [ "$service" = "" ] || [ "$service" = "Exit" ]; then
    break
  fi
  isactive=$(systemctl status $service | grep Active | awk '{print $2}')
  isenabled=$(systemctl list-unit-files | grep $service | awk '{print $2}')
  printf "\n$service is $isenabled and $isactive\n\n"
  actions=$(printf "enable\nstart\ndisable\nstop\n")
  action=$(gum choose $actions --header "What do you want to do to $service?")
  if [ "$action" = "" ]; then
    break
  fi
  sudo systemctl $action $service
  isactive=$(systemctl status $service | grep Active | awk '{print $2}')
  isenabled=$(systemctl list-unit-files | grep $service | awk '{print $2}')
  printf "$service is now $isenabled and $isactive\n"

done
