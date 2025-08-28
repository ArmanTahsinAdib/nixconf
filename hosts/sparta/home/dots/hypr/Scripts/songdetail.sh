#!/usr/bin/env sh

if [[ $(playerctl -p spotify status 2>/dev/null) == "Playing" ]]; then
  status='  '
else
  status='  '
fi

# status='▷ '
# status=' '

song_info=$(playerctl -p spotify metadata --format "$status {{title}}")

echo "$song_info"
