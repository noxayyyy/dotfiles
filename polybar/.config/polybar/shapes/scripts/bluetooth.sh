#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
  echo " %{F#66ffffff}"
else
  if [ $(bluetoothctl info | grep 'Device' | wc -c) -ne 0 ]
  then 
    echo "  $(bluetoothctl info | grep -oP -m 1 'Name: \K.*')"
  else
    echo " "
  fi
fi

