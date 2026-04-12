touchpad_id=$(grep -Po 'Touchpad.*id=\K[^\[]+' <<< $(xinput list))
tap_id=$(grep -Po 'Tapping Enabled \(\K[^\)]+' <<< $(xinput list-props $touchpad_id))
xinput set-prop $touchpad_id $tap_id 1
