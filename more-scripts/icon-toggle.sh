#!/bin/bash

CURRENT=$(xfconf-query -c xfce4-desktop -p /desktop-icons/style)
if [ $CURRENT -eq 2 ]
then
    xfconf-query -c xfce4-desktop -p /desktop-icons/style -s 0
elif [ $CURRENT -eq 0 ]
then
    xfconf-query -c xfce4-desktop -p /desktop-icons/style -s 2
fi
