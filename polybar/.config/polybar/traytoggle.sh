#!/bin/bash

if pgrep -x "trayer" > /dev/null
then
  killall trayer
else
  trayer &
fi
