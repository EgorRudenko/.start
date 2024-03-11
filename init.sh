#!/bin/bash
hsetroot -center $HOME/.start/background/background.png &
picom --config $HOME/.config/picom/picom.conf &
xrdb $HOME/.Xresources &
bash $HOME/.start/statusbar.sh &

