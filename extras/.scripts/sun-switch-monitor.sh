cm=$(cat ~/.config/sunshine/sunshine.conf)
if [ "$cm" = "output_name = 0" ]; then
  echo "output_name = 1" > ~/.config/sunshine/sunshine.conf
elif [[ "$cm" = "output_name = 1" ]]; then
  echo "output_name = 0" > ~/.config/sunshine/sunshine.conf
else
  echo "output_name = 1" > ~/.config/sunshine/sunshine.conf
fi 
cm=$(cat ~/.config/sunshine/sunshine.conf)
tmux send-keys -t main:sunshine C-c 'sunshine' Enter

notify-send "The default streaming Sunshine monitor has been changed: $cm"
