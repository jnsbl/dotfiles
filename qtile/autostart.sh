#!/usr/bin/env bash

# Autostart script for Qtile

cmd_exist() { unalias "$1" >/dev/null 2>&1 ; command -v "$1" >/dev/null 2>&1 ;}
svc_running() { systemctl --user status "$1" >/dev/null 2>&1 ;}
__kill() { kill -9 "$(pidof "$1")" >/dev/null 2>&1 ; }
__start() { sleep 1 && "$@" >/dev/null 2>&1 & }
__running() { pidof "$1" >/dev/null 2>&1 ;}

script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

# Set the wallpaper

if cmd_exist nitrogen ; then
    __kill nitrogen
    __start nitrogen --restore
fi

# Compositor

if cmd_exist picom ; then
    __kill picom
    __start picom
fi

# Authentication dialog

if cmd_exist lxsession ; then
    __kill lxsession
    __start lxsession
fi

# Notification daemon

if cmd_exist dunst ; then
    __kill dunst
    __start dunst
fi

# Clipboard manager

if cmd_exist greenclip ; then
    __kill greenclip
    __start greenclip daemon
fi

# Auto multi-display setup

if cmd_exist mons ; then
    __kill mons
    __start mons -a -x "$(script_dir)/multihead.sh"
fi

# X11 settings service

if svc_running xsettingsd.service ; then
else
    __start systemctl --user start xsettingsd.service
fi
