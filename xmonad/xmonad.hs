-- vim:fileencoding=utf-8:foldmethod=marker
-- {{{ Imports
import XMonad
import Data.Monoid
import System.Directory (getHomeDirectory)
import System.Exit

import XMonad.Actions.CycleWS
import XMonad.Actions.UpdatePointer

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing

import XMonad.Util.EZConfig

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import Graphics.X11.ExtraTypes.XorgDefault
-- }}}

-- {{{ Variable definitions
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
myTerminal      = "alacritty"

myBrowser       = "min"
myFileManager   = "thunar"
myEditor        = "nvim-qt"

-- Path to wallpaper to set at startup
myWallpaperPath :: String
myWallpaperPath = "~/Pictures/Wallpapers/FrenzyExists/Gruv/haskell.jpg"

-- Useless gap around and among windows
myUselessGap    = 3

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Regular modifier and alternative modifier
myModMask       = mod4Mask
myAltMask       = mod1Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["web","code","chat","music","notes","other"]
myWorkspaceKeys = [xK_plus,xK_ecaron,xK_scaron,xK_ccaron,xK_rcaron,xK_zcaron,xK_yacute,xK_aacute,xK_iacute] -- cs-cz keyboard
-- myWorkspaceKeys = [xK_1 .. xK_9] -- en-us keyboard

-- Width of the window border in pixels.
myBorderWidth   = 1

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

-- Path to user's home directory (used in paths)
-- myHomeDir :: IO String
-- myHomeDir = do
--   homeDir <- getHomeDirectory
--   return homeDir
-- }}}

-- {{{ Key bindings
------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
-- See https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Util-EZConfig.html#v:mkKeymap
--
myKeys :: [(String, X ())]
myKeys =
  [ ("M-<Return>", spawn myTerminal)
  , ("M1-C-<Space>", spawn "gsimplecal")
  , ("M-S-<Return>", spawn myFileManager)
  , ("M-C-<Return>", spawn myBrowser)
  , ("M-<F2>", spawn myEditor)

  , ("M-r", spawn "dmenu_run")
  , ("M-<Space>", spawn "rofi -no-lazy-grab -show drun -modi drun -theme ~/.config/rofi/launcher_colorful_style5")
  , ("M-v", spawn "rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'")
  , ("M-S-x", spawn "~/.config/rofi/scripts/rofi-display")

  , ("M-S-q", io (exitWith ExitSuccess))
  , ("M-q", spawn "xmonad --recompile; xmonad --restart")
  , ("M-S-<F1>", spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))

  , ("M1-<Print>", spawn "~/bin/printscr.sh")
  , ("M1-S-<Print>", spawn "~/.config/rofi/scripts/rofi-screenshot")

  , ("M-w", kill)
  , ("M1-<Space>", sendMessage NextLayout)
  , ("M1-S-<Space>", sendMessage FirstLayout)
  , ("M-<Esc>", toggleWS)

  , ("M-<Tab>", windows W.focusDown)
  , ("M-j", windows W.focusDown)
  , ("M-k", windows W.focusUp)
  , ("M-m", windows W.focusMaster)
  , ("M-S-j", windows W.swapDown)
  , ("M-S-k", windows W.swapUp)
  , ("M-S-h", sendMessage Shrink)
  , ("M-S-l", sendMessage Expand)
  , ("M-t", withFocused $ windows . W.sink)
  , ("M-,", sendMessage (IncMasterN 1))
  , ("M-.", sendMessage (IncMasterN (-1)))
  , ("M-b", sendMessage ToggleStruts)
  , ("M-f", sendMessage $ Toggle FULL)

  , ("M-M1-j", prevScreen)
  , ("M-M1-k", nextScreen)
  , ("M-M1-S-j", shiftPrevScreen)
  , ("M-M1-S-k", shiftNextScreen)

  , ("M-M1-l", spawn "betterlockscreen --lock dim")

  , ("M-S-n", spawn "~/.local/bin/toggle_dunst.sh")
  , ("C-S-<Space>", spawn "dunstctl close-all")

  , ("<XF86MonBrightnessUp>", spawn "brightnessctl --device=nvidia_wmi_ec_backlight set +3%")
  , ("<XF86MonBrightnessDown>", spawn "brightnessctl --device=nvidia_wmi_ec_backlight set 3%-")

  , ("<XF86AudioMute>", spawn "bash -c 'pactl set-sink-mute $(pactl get-default-sink) toggle'")
  , ("<XF86AudioRaiseVolume>", spawn "bash -c 'pactl set-sink-volume $(pactl get-default-sink) +3%'")
  , ("<XF86AudioLowerVolume>", spawn "bash -c 'pactl set-sink-volume $(pactl get-default-sink) -3%'")
  , ("<XF86AudioPlay>", spawn "playerctl play-pause")
  , ("<XF86AudioStop>", spawn "playerctl stop")
  , ("<XF86AudioPrev>", spawn "playerctl previous")
  , ("<XF86AudioNext>", spawn "playerctl next")

  , ("M-o", nextScreen)
  , ("M-S-o", shiftNextScreen)
  ]

myAdditionalKeys conf@XConfig {XMonad.modMask = modm} =
  M.fromList $
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) myWorkspaceKeys
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-- }}}

-- {{{ Mouse bindings
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
-- }}}

-- {{{ Layouts
------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = smartSpacing myUselessGap
  $ smartBorders
  $ mkToggle (NOBORDERS ?? FULL ?? EOT)
  $ avoidStruts (tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
-- }}}

-- {{{ Window rules
------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]
-- }}}

-- {{{ Event handling
------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty
-- }}}

-- {{{ Status bars and logging
------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = updatePointer (0.5, 0.5) (0, 0)
-- }}}

-- {{{ Startup hook
------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook :: X ()
myStartupHook = do
  let wallpaperCmd      = "feh --bg-scale " ++ myWallpaperPath
      picomCmd          = "killall -9 picom; sleep 1 && picom -b &"
      polybarCmd        = "~/.config/polybar/launch.sh"
      clipboardHistCmd  = "killall -9 greenclip; sleep 1 && greenclip daemon"
      polkitCmd         = "killall -9 /usr/lib/polkit-kde-authentication-agent-1; sleep 1 && /usr/lib/polkit-kde-authentication-agent-1"
      notifCmd          = "killall -9 dunst; sleep 1 && dunst &"
      systrayCmd        = "killall -9 trayer; sleep 1 && trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 5 --transparent true --tint 0x000000 --height 18"
      netManAppletCmd   = "killall -9 nm-applet; sleep 1 && nm-applet"
      sndManAppletCmd   = "killall -9 pasystray; sleep 1 && pasystray"
      blueManAppletCmd  = "killall -9 blueman; sleep 1 && blueman"
      updManAppletCmd   = "killall -9 pamac-tray; sleep 1 && GDK_BACKEND=x11 pamac-tray"
  sequence_ [
      spawn wallpaperCmd
    , spawn picomCmd
    , spawn polybarCmd
    , spawn clipboardHistCmd
    , spawn polkitCmd
    , spawn notifCmd
    -- , spawn systrayCmd
    -- , spawn netManAppletCmd
    -- , spawn sndManAppletCmd
    -- , spawn blueManAppletCmd
    -- , spawn updManAppletCmd
    ]
-- }}}

-- {{{ Main
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad . docks . ewmhFullscreen . ewmh
     $ defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myAdditionalKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
    `additionalKeysP` myKeys
-- }}}

-- {{{ Help
-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
-- TODO Update according to my key bindings
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "",
    "-- Workspaces & screens",
    "mod-[1..9]   Switch to workSpace N",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
-- }}}
