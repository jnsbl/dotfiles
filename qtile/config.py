# vim:fileencoding=utf-8:foldmethod=marker
# {{{ License
# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# }}}

# {{{ Imports
from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

import os
import subprocess
import time
# }}}

mod = "mod4"
terminal = "alacritty"
font_name = 'mononoki Nerd Font Mono'
home = os.path.expanduser('~')

# {{{ Colors
# Colors taken from https://github.com/morhetz/gruvbox (dark mode)
BG         = '#282828'
BG_RED     = '#cc241d'
BG_GREEN   = '#98971a'
BG_YELLOW  = '#d79921'
BG_BLUE    = '#458588'
BG_PURPLE  = '#b16286'
BG_AQUA    = '#689d6a'
BG_GRAY    = '#a89984'
BG0_H      = '#1d2021'
BG0_S      = '#32302f'
BG0        = '#282828'
BG1        = '#3c3836'
BG2        = '#504945'
BG3        = '#665c54'
BG4        = '#7c6f64'
BG5_GRAY   = '#928374'
BG_ORANGE  = '#d65d0e'
FG         = '#ebdbb2'
FG0        = '#fbf1c7'
FG1        = '#ebdbb2'
FG2        = '#d5c4a1'
FG3        = '#bdae93'
FG4        = '#a89984'
RED        = '#fb4934'
GREEN      = '#b8bb26'
YELLOW     = '#fabd2f'
BLUE       = '#83a598'
PURPLE     = '#d3869b'
AQUA       = '#8ec07c'
GRAY       = '#928374'
ORANGE     = '#fe8019'
# }}}

# {{{ Hooks and functions
@hook.subscribe.startup_once
def autostart():
    path = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.run([path])

@lazy.function
def save_screenshot(qtile):
    fpath = home + "/Pictures/Screenshots/"
    fname = "Screenshot_" + time.strftime("%Y%m%d_%H%M%S") + ".png"
    cmd   = "shotgun " + fpath + fname
    qtile.cmd_spawn(cmd)

@hook.subscribe.screen_change
def update_monitors(event):
    qtile.restart()

def check_monitor_status():
    # TODO Getting output from xrandr takes 2-3 seconds :/
    monitor_count = subprocess.check_output('xrandr --listactivemonitors | wc -l', shell=True).decode().strip("\n")
    # xrandr prints two lines for each monitor
    if monitor_count == '2':
        return "\uf878" # nf-mdi-monitor
    else:
        return "\uf879" # nf-mdi-monitor_multiple


def check_notifications_status():
    # is_paused = qtile.cmd_spawn('dunstctl is-paused')
    is_paused = subprocess.check_output('dunstctl is-paused', shell=True).decode().strip("\n")
    if is_paused == 'true':
        return "\uf59a" # nf-mdi-bell_off
    else:
        return "\uf599" # nf-mdi-bell
# }}}

# {{{ Keys
keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

    Key([mod], "space",
        lazy.spawn("rofi -modi \"drun,calc,filebrowser\" -show drun"),
        desc="Show rofi"),
    # Key([mod, "ctrl"], "space",
    #     lazy.spawn("ulauncher"),
    #     desc="Show Ulauncher"),
    Key(["mod1"], "Tab",
        lazy.spawn("rofi -show window"),
        desc="Switch to a window"),
    Key([mod], "v",
        lazy.spawn("rofi -modi \"clipboard:greenclip print\" -show clipboard -run-command '{cmd}'"),
        desc="Switch to a window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    # Key([mod, "control"], "h", lazy.layout.grow_left(),
    #     desc="Grow window to the left"),
    # Key([mod, "control"], "l", lazy.layout.grow_right(),
    #     desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),

    Key([mod, "control"], "l", lazy.layout.grow()),
    Key([mod, "control"], "h", lazy.layout.shrink()),
    Key([mod, "control"], "o", lazy.layout.maximize()),
    Key([mod, "control"], "space", lazy.layout.flip()),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    Key([mod, "mod1"], "space", lazy.next_screen()),

    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),

    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 0 -q set Master 2dB+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 0 -q set Master 2dB-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer set Master toggle")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),

    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl --device=intel_backlight set +3%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl --device=intel_backlight set 3%-")),

    Key(["mod1", "control"], "space", lazy.spawn('gsimplecal')),

    Key(["mod1"], "space", lazy.widget["keyboardlayout"].next_keyboard(), desc="Next keyboard layout."),

    Key([mod, "mod1"], "l", lazy.spawn('betterlockscreen --lock dim')),

    Key([], "Print", save_screenshot),
]
# }}}

# {{{ Groups
# Icons - https://www.nerdfonts.com/cheat-sheet
groups = [
    Group("a", label="\uf312"), # nf-linux-manjaro
    Group("s", label="\ufa9e", # nf-mdi-web
          matches=[Match(wm_class='brave'), Match(wm_class='firefox')],
          layout='stack',
         ),
    Group("d", label="\ue796", # nf-dev-code
          matches=[Match(wm_class='nvim-qt'), Match(wm_class='vscodium')],
          layout='monadwide',
         ),
    Group("f", label="\uf489"), # nf-oct-terminal
    Group("u", label="\uf086", # nf-fa-comments
          matches=[Match(wm_class='skypeforlinux')],
          layout='stack',
         ),
    Group("i", label="\ufc58", # nf-mdi-music
          matches=[Match(wm_class='Spotify'), Match(wm_class='elisa')],
          layout='stack',
         ),
    Group("o", label="\uf718", # nf-mdi-file_document
          matches=[Match(wm_class='libreoffice')],
          layout='stack',
         ),
    Group("p", label="\ue29a"), # nf-fae-checklist_o
]
# from libqtile.dgroups import simple_key_binder
# dgroups_key_binder = simple_key_binder(mod)
for i in groups:
    keys.extend(
        [
            Key([mod], i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key([mod, "shift"], i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            Key([mod, "shift", "control"], i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc="Move focused window to group {}".format(i.name),
            ),
        ]
    )
# }}}

# {{{ Layouts
# Default theme settings for layouts
layout_theme = {
    "border_width": 3,
    "border_on_single": True,
    "margin": 8,
    "border_focus": GREEN,
    "border_normal": BG2
}

layouts = [
    layout.MonadTall(ratio=0.6, **layout_theme),
    layout.MonadWide(ratio=0.6, **layout_theme),
    layout.Stack(num_stacks=1, **layout_theme),
    # layout.Max(**layout_theme),
    # layout.Floating(**layout_theme),
    layout.Columns(**layout_theme),
    # layout.Bsp(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Tile(**layout_theme),
    # layout.TreeTab(**layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Zoomy(**layout_theme),
]
# }}}

# {{{ Screens, bars and widgets
widget_defaults = dict(
    font=font_name,
    fontsize=13,
    padding=2,
)
icon_defaults = dict(
    font=font_name,
    fontsize=26,
    padding=2,
)

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=10),
                widget.CurrentLayoutIcon(scale=0.7, foreground=FG, **icon_defaults),
                widget.CurrentScreen(active_color=GREEN, inactive_color=RED, **widget_defaults),
                widget.Spacer(length=10),

                widget.GroupBox(
                    borderwidth=2,
                    active=FG,
                    inactive=BG3,
                    this_current_screen_border=FG,
                    this_screen_border=FG,
                    other_current_screen_border=FG4,
                    other_screen_border=FG4,
                    font=icon_defaults['font'],
                    fontsize=icon_defaults['fontsize'],
                    highlight_method='line',
                    highlight_color=BG
                ),
                widget.Prompt(**widget_defaults),

                # widget.Spacer(length=30),
                # widget.TextBox(text="\uf9fd", foreground=BG, background=GREEN, padding=5, font=icon_defaults['font'], fontsize=28), # nf-mdi-target
                # widget.TextBox(text="Dělba práce", foreground=BG, background=GREEN, padding=5, font=widget_defaults['font'], fontsize=widget_defaults['fontsize']),

                widget.Spacer(),
                widget.WindowName(foreground=FG, **widget_defaults),
                # widget.Spacer(),
                # widget.Clock(format='%a %d.%m.%Y %H:%M:%S'),

                widget.Spacer(),

                # widget.Systray(),
                # widget.Spacer(length=10),

                widget.TextBox(text="\uf580", foreground=GREEN, font=icon_defaults['font'], fontsize=14), # nf-mdi-battery_80
                widget.Battery(
                    format='{percent:2.0%} ({hour:d}:{min:02d}{char})',
                    full_char="\uf578", # nf-mdi-battery
                    charge_char="\uf077", # nf-fa-chevron_up
                    discharge_char="\uf078", # nf-fa-chevron_down
                    empty_char="\uf58d", # nf-mdi-battery_outline
                    notify_below=20,
                    foreground=GREEN
                ),
                widget.Spacer(length=10),

                widget.TextBox(text="\uf85a", foreground=YELLOW, **icon_defaults), # nf-mdi-memory
                widget.Memory(
                    format='{MemPercent:.0f}%',
                    foreground=YELLOW,
                    mouse_callbacks={'Button1': lambda:qtile.cmd_spawn('kitty -e btop')},
                    **widget_defaults
                ),
                widget.Spacer(length=10),

                widget.TextBox(text="\ue30d", foreground=ORANGE, **icon_defaults), # nf-weather-day_sunny
                widget.Backlight(
                    foreground=ORANGE,
                    brightness_file="/sys/class/backlight/intel_backlight/brightness",
                    max_brightness_file="/sys/class/backlight/intel_backlight/max_brightness",
                ),
                widget.Spacer(length=10),

                widget.TextBox(text="\ufa7d", foreground=PURPLE, **icon_defaults), # nf-mdi-volume_high
                widget.PulseVolume(
                    foreground=PURPLE,
                    mouse_callbacks={'Button1': lambda:qtile.cmd_spawn('pavucontrol')},
                    **widget_defaults
                ),
                widget.Spacer(length=10),

                widget.TextBox(text="\ufaa8", foreground=BLUE, **icon_defaults), # nf-mdi-wifi
                widget.Wlan(
                    format='{percent:2.0%}',
                    disconnected_message='n/a',
                    interface='wlp0s20f3',
                    foreground=BLUE,
                    mouse_callbacks={'Button1': lambda:qtile.cmd_spawn('networkmanager_dmenu')}, # networkmanager_dmenu / rofi-wifi-menu
                    **widget_defaults
                ),
                widget.Spacer(length=10),

                widget.KeyboardLayout(configured_keyboards=['cz','us'], foreground=AQUA),
                widget.Spacer(length=10),

                # widget.GenPollText(
                #     update_interval=5,
                #     func=check_monitor_status,
                #     # mouse_callbacks={'Button1': lambda:qtile.cmd_spawn('dunstctl set-paused toggle')},
                #     foreground=GRAY,
                #     **icon_defaults
                # ),
                # widget.Spacer(length=10),

                widget.GenPollText(
                    update_interval=1,
                    func=check_notifications_status,
                    mouse_callbacks={'Button1': lambda:qtile.cmd_spawn('dunstctl set-paused toggle')},
                    foreground=GRAY,
                    **icon_defaults
                ),
                widget.Spacer(length=10),

                # widget.CheckUpdates(
                #     colour_no_updates=GRAY,
                #     colour_have_updates=GRAY,
                #     display_format="\ufc35 {updates}", # nf-mdi-arrow_up_bold
                #     no_update_string="\ufc35 0", # nf-mdi-arrow_up_bold
                #     distro='Arch',
                #     custom_command_modify='pacman -Qu | grep -Fv "[ignored]"',
                #     update_interval=3600,
                #     **widget_defaults
                # ),
                # widget.Spacer(length=10),

                widget.Clock(
                    format='%H:%M:%S',
                    foreground=FG,
                    mouse_callbacks={'Button1': lambda:qtile.cmd_spawn('gsimplecal')},
                    **widget_defaults
                ),
                widget.Spacer(length=10),
            ],
            28, background=BG0_H, margin=[8, 8, 0, 8]  # N E S W
        ),
        # bottom=bar.Bar(
        #     [
        #         widget.Spacer(),
        #         widget.TextBox(text="\uf9fd", foreground=PURPLE, font=icon_defaults['font'], fontsize=icon_defaults['fontsize']), # nf-mdi-target
        #         widget.TextBox(text="uuCloudg02 Q1 plan", foreground=PURPLE, font=widget_defaults['font'], fontsize=widget_defaults['fontsize']),
        #         widget.Spacer(),
        #     ],
        #     28, background=BG0_H, margin=[0, 8, 8, 8]  # N E S W
        # ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=10),
                widget.CurrentLayoutIcon(scale=0.7, foreground=FG, **icon_defaults),
                widget.CurrentScreen(active_color=GREEN, inactive_color=RED, **widget_defaults),
                widget.Spacer(length=10),

                widget.GroupBox(
                    borderwidth=2,
                    active=FG,
                    inactive=BG3,
                    this_current_screen_border=FG,
                    this_screen_border=FG,
                    other_current_screen_border=FG4,
                    other_screen_border=FG4,
                    font=icon_defaults['font'],
                    fontsize=icon_defaults['fontsize'],
                    highlight_method='line',
                    highlight_color=BG
                ),

                widget.Spacer(),
                widget.WindowName(foreground=FG, **widget_defaults),
                widget.Spacer(),


                widget.Clock(
                    format='%d.%m. %H:%M:%S',
                    foreground=FG,
                    mouse_callbacks={'Button1': lambda:qtile.cmd_spawn('gsimplecal')},
                    **widget_defaults
                ),
                widget.Spacer(length=10),
            ],
            28, background=BG0_H, margin=[8, 8, 0, 8]  # N E S W
        ),
    ),
]
# }}}

# {{{ Mouse
# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]
# }}}

# {{{ Miscellaneous
dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
        Match(title='Set Time Reservation State'),  # plus4u.net
        Match(title='about:blank'),  # blank web page
    ],
    **layout_theme,
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "qtile"
# }}}
