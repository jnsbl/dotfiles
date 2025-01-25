-- vim:fileencoding=utf-8:foldmethod=marker
-- {{{ Imports
import XMonad hiding ( (|||) ) -- https://wiki.haskell.org/Xmonad/General_xmonad.hs_config_tips#Binding_keys_to_a_specific_layout

import Data.Bifunctor (bimap)
import Data.Char as DC
import Data.List as DL
import Data.Maybe (catMaybes, fromMaybe)
import Data.Monoid

import System.Directory (getHomeDirectory)
import System.Exit
import System.IO
import System.IO.Unsafe (unsafePerformIO)

import XMonad.Actions.CycleWS
import XMonad.Actions.Promote
import XMonad.Actions.UpdatePointer
import XMonad.Actions.WithAll (sinkAll)

import XMonad.Core (installSignalHandlers)

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing

import XMonad.Layout.Dwindle
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.LayoutModifier
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns

import XMonad.ManageHook

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.NamedActions
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.WorkspaceCompare

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified XMonad.Layout.Magnifier as Mag
import qualified XMonad.Layout.ToggleLayouts as T (ToggleLayout(Toggle))

import Graphics.X11.ExtraTypes.XorgDefault
-- }}}

-- {{{ Variable definitions
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
myTerminal      = "kitty"

myBrowser       = "min"
myFileManager   = "thunar"
myEditor        = "nvim-qt"

-- Path to wallpaper to set at startup
myWallpaperPath :: String
myWallpaperPath = "~/Pictures/Wallpapers/Wallhaven/2024-07/wallhaven-0pepv3.jpg"

-- Useless gap around and among windows
myUselessGap    = 10

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
myWorkspaces    = ["web","code","chat","music","notes","other"]
myWorkspaceKeys = [xK_plus,xK_ecaron,xK_scaron,xK_ccaron,xK_rcaron,xK_zcaron,xK_yacute,xK_aacute,xK_iacute] -- cs-cz keyboard
-- myWorkspaceKeys = [xK_1 .. xK_9] -- en-us keyboard

-- Width of the window border in pixels.
myBorderWidth   = 2
-- }}}

-- {{{ Key bindings
------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
-- See https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Util-EZConfig.html#v:mkKeymap

myEssentialKeys conf@XConfig {XMonad.modMask = modm} =
  M.fromList $
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    -- mod-control-[1..9], Switch to workspace N greedily - see https://www.reddit.com/r/xmonad/comments/ndww5/comment/c38moye/?utm_source=share&utm_medium=web2x&context=3
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) myWorkspaceKeys
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask), (W.greedyView, controlMask)]
    ]
    ++
    [((m .|. modm, k), screenWorkspace sc >>= flip whenJust (windows . f))
        | (k, sc) <- zip [xK_a, xK_s, xK_d] [0,1,2] -- i.e. M-a for screen 0, M-s for screen 1, ...
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]

subtitle' ::  String -> ((KeyMask, KeySym), NamedAction)
subtitle' x = ((0,0), NamedAction $ map toUpper $ x)

showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show keybindings" $ io $ do
  h <- spawnPipe $ "yad --text-info --center --geometry=1200x800 --title \"XMonad keybindings\" --button=yad-close:1"
  hPutStr h (unlines $ showKm x) -- showKM adds ">>" before subtitles
  -- hPutStr h (unlines $ showKmSimple x) -- showKmSimple doesn't add ">>" to subtitles
  hClose h
  return ()

myKeys :: XConfig l0 -> [((KeyMask, KeySym), NamedAction)]
myKeys c =
  let subKeys str ks = subtitle' str : mkNamedKeymap c ks in
  subKeys "Xmonad Essentials"
  [ ("M-w", addName "Kill focused window" $ kill)
  , ("M-S-q", addName "Quit XMonad" $ io (exitWith ExitSuccess))
  , ("M-S-r", addName "Recompile and restart XMonad" $ spawn "xmonad --recompile; xmonad --restart")
  , ("M-b", addName "Toggle top bar" $ sendMessage ToggleStruts)
  , ("M-S-<F1>", addName "Show colors" $ spawn showColorsCmd)
  , ("M-S-C-<F1>", addName "Show Xresources" $ spawn showXresCmd)
  ]

  ^++^ subKeys "Window navigation"
  [ ("M-<Tab>", addName "Move focus to next window" $ windows W.focusDown)
  , ("M-S-<Tab>", addName "Move focus to prev window" $ windows W.focusUp)
  , ("M-j", addName "Move focus to next window" $ windows W.focusDown)
  , ("M-k", addName "Move focus to prev window" $ windows W.focusUp)
  , ("M-m", addName "Move focus to master window" $ windows W.focusMaster)
  , ("M-S-m", addName "Move focused window to master" $ promote)
  , ("M-S-j", addName "Swap focused window with next window" $ windows W.swapDown)
  , ("M-S-k", addName "Swap focused window with prev window" $ windows W.swapUp)
  ]

  ^++^ subKeys "Window resizing"
  [ ("M-S-h", addName "Shrink window" $ sendMessage Shrink)
  , ("M-S-l", addName "Expand window" $ sendMessage Expand)
  , ("M-f", addName "Toggle focused window fullscreen" $ sendMessage $ Toggle FULL)
  , ("M-C-m", addName "Toggle focused window magnified" $ sendMessage Mag.Toggle)
  ]

  ^++^ subKeys "Floating windows"
  [ ("M-S-f", addName "Toggle float layout" $ sendMessage (T.Toggle "floats"))
  , ("M-t", addName "Sink a floating window" $ withFocused $ windows . W.sink)
  , ("M-S-t", addName "Sink all floated windows" $ sinkAll)
  ]

  ^++^ subKeys "Menus / Prompts"
  [ ("M-<Space>", addName "Show application launcher" $ spawn "rofi -no-lazy-grab -show drun -modi drun -theme ~/.config/rofi/launcher_colorful_style5")
  , ("M-r", addName "Show dmenu" $ spawn "dmenu_run")
  , ("M-v", addName "Show clipboard history" $ spawn "rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'")
  , ("M-S-x", addName "Show display manager" $ spawn "prompt-display -r")
  , ("M-p c", addName "Show colorscheme prompt" $ spawn "prompt-colorscheme -r")
  , ("M-p t", addName "Show tldr prompt" $ spawn "prompt-tldr -r")
  , ("M-p q", addName "Show logout prompt" $ spawn "prompt-logout -r")
  , ("M-p w", addName "Show wiki prompt" $ spawn "prompt-wiki -r")
  , ("M-p a", addName "Show audio prompt" $ spawn "prompt-audio -r")
  , ("M-p r", addName "Show resolution prompt" $ spawn "prompt-resolution -r")
  , ("M-p m", addName "Show Xmonad bar prompt" $ spawn "prompt-xmonad -r")
  ]

  ^++^ subKeys "Favorite programs"
  [ ("M-<Return>", addName "Launch terminal" $ spawn myTerminal)
  , ("M-S-<Return>", addName "Launch file manager" $ spawn myFileManager)
  , ("M-C-<Return>", addName "Launch browser" $ spawn myBrowser)
  , ("M-<F2>", addName "Launch editor" $ spawn myEditor)
  , ("M1-C-<Space>", addName "Show calendar" $ spawn "gsimplecal")
  ]

  ^++^ subKeys "Monitors"
  [ ("M-M1-j", addName "Switch focus to prev screen" $ prevScreen)
  , ("M-M1-k", addName "Switch focus to prev screen" $ nextScreen)
  , ("M-M1-S-j", addName "Send focused window to prev screen" $ shiftPrevScreen)
  , ("M-M1-S-k", addName "Send focused window to next screen" $ shiftNextScreen)
  ]

  ^++^ subKeys "Workspaces"
  [ ("M-<Right>", addName "Switch to next workspace" $ moveTo Next nonNSP)
  , ("M-S-<Right>", addName "Send to next workspace" $ shiftTo Next nonNSP)
  , ("M-<Left>", addName "Switch to prev workspace" $ moveTo Prev nonNSP)
  , ("M-S-<Left>", addName "Send to prev workspace" $ shiftTo Prev nonNSP)
  , ("M-<Esc>", addName "Switch to last visited workspace" $ toggleWS' [scratchpadWorkspaceTag])
  ]

  ^++^ subKeys "Layouts"
  [ ("M1-<Space>", addName "Switch to next layout" $ sendMessage NextLayout)
  , ("M1-S-<Space>", addName "Switch to first layout" $ sendMessage FirstLayout)
  , ("M1-S-t", addName "Switch to tall layout" $ sendMessage $ JumpToLayout "tall")
  , ("M1-S-w", addName "Switch to wide layout" $ sendMessage $ JumpToLayout "wide")
  , ("M1-S-f", addName "Switch to full layout" $ sendMessage $ JumpToLayout "full")
  , ("M1-S-z", addName "Switch to zoom layout" $ sendMessage $ JumpToLayout "zoom")
  , ("M1-S-m", addName "Switch to threeColMid layout" $ sendMessage $ JumpToLayout "threeColMid")
  , ("M1-S-d", addName "Switch to dwindle layout" $ sendMessage $ JumpToLayout "dwindle")
  ]

  ^++^ subKeys "Increase/decrease windows in master pane"
  [ ("M-C-,", addName "Increase windows in master pane" $ sendMessage (IncMasterN 1))
  , ("M-C-.", addName "Decrease windows in master pane" $ sendMessage (IncMasterN (-1)))
  ]

  ^++^ subKeys "Screenshot"
  [ ("M1-<Print>", addName "Take screenshot" $ spawn "printscr.sh")
  , ("M1-S-<Print>", addName "Show screenshot menu" $ spawn "prompt-screenshot -r")
  ]

  ^++^ subKeys "Lock screen"
  [ ("M-M1-l", addName "Lock screen" $ spawn "betterlockscreen --lock dim --span")
  ]

  ^++^ subKeys "Notifications"
  -- [ ("M-S-n", addName "Toggle notifications" $ spawn "~/.local/bin/toggle_dunst.sh")
  -- , ("C-S-<Space>", addName "Close all notifications" $ spawn "dunstctl close-all")
  [ ("M-S-n", addName "Disable notifications" $ spawn "~/.dotfiles/bin/disable_wired.sh")
  , ("M-S-d", addName "Enable notifications" $ spawn "~/.dotfiles/bin/enable_wired.sh")
  , ("C-S-<Space>", addName "Close all notifications" $ spawn "wired --drop all")
  ]

  ^++^ subKeys "Brightness controls"
  [ ("<XF86MonBrightnessUp>", addName "Increase brightness" $ spawn "brightnessctl --device=intel_backlight set +3%")
  , ("<XF86MonBrightnessDown>", addName "Decrease brightness" $ spawn "brightnessctl --device=intel_backlight set 3%-")
  ]

  ^++^ subKeys "Audio controls"
  [ ("<XF86AudioMute>", addName "Mute audio" $ spawn "bash -c 'pactl set-sink-mute $(pactl get-default-sink) toggle'")
  , ("<XF86AudioRaiseVolume>", addName "Increase volume" $ spawn "bash -c 'pactl set-sink-volume $(pactl get-default-sink) +3%'")
  , ("<XF86AudioLowerVolume>", addName "Decrease volume" $ spawn "bash -c 'pactl set-sink-volume $(pactl get-default-sink) -3%'")
  , ("<XF86AudioPlay>", addName "Play/pause" $ spawn "playerctl --player=spotify,mpd play-pause")
  , ("<XF86AudioStop>", addName "Stop" $ spawn "playerctl --player=spotify,mpd stop")
  , ("<XF86AudioPrev>", addName "Skip to prev track" $ spawn "playerctl --player=spotify,mpd previous")
  , ("<XF86AudioNext>", addName "Skip to next track" $ spawn "playerctl --player=spotify,mpd next")
  ]

  -- ^++^ subKeys "Systray"
  -- [ ("M-S-s", addName "Toggle systray" $ spawn "polybar-msg action tray module_toggle")
  -- ]

  ^++^ subKeys "Scratchpads"
  [ ("M-y", addName "Toggle scratchpad terminal" $ namedScratchpadAction myScratchpads "term")
  , ("M-C-y", addName "Toggle scratchpad terminal" $ namedScratchpadAction myScratchpads "term")
  , ("M-C-x", addName "Toggle scratchpad system monitor" $ namedScratchpadAction myScratchpads "top")
  , ("M-C-f", addName "Toggle scratchpad file manager" $ namedScratchpadAction myScratchpads "files")
  , ("M-C-v", addName "Toggle scratchpad volume control" $ namedScratchpadAction myScratchpads "volume")
  , ("M-C-a", addName "Toggle scratchpad audio player" $ namedScratchpadAction myScratchpads "mpc")
  , ("M-C-p", addName "Toggle scratchpad password manager" $ namedScratchpadAction myScratchpads "pass")
  , ("M-C-n", addName "Toggle scratchpad quick notes" $ namedScratchpadAction myScratchpads "notes")
  , ("M-C-s", addName "Toggle scratchpad screenshots" $ namedScratchpadAction myScratchpads "picscr")
  , ("M-C-w", addName "Toggle scratchpad wallpapers" $ namedScratchpadAction myScratchpads "picwal")
  , ("M-C-c", addName "Toggle scratchpad calculator" $ namedScratchpadAction myScratchpads "calc")
  ]
  where
    nonNSP = WSIs (return (\ws -> W.tag ws /= "NSP"))
    showColorsCmd = concat ["yad --text-info --center --geometry=400x600 --title \"XMonad colors\" --button=yad-close:1 --text \">> XMonad colors"
      , "\nnormalBorderColor=", myNormalBorderColor
      , "\nfocusedBorderColor=", myFocusedBorderColor
      , "\n\n>> XResources colors"
      , "\nforeground=", xColorFg
      , "\nbackground=", xColorBg
      , "\ncolor0=", color0
      , "\ncolor1=", color1
      , "\ncolor2=", color2
      , "\ncolor3=", color3
      , "\ncolor4=", color4
      , "\ncolor5=", color5
      , "\ncolor6=", color6
      , "\ncolor7=", color7
      , "\ncolor8=", color8
      , "\ncolor9=", color9
      , "\ncolor10=", color10
      , "\ncolor11=", color11
      , "\ncolor12=", color12
      , "\ncolor13=", color13
      , "\ncolor14=", color14
      , "\ncolor15=", color15
      , "\n\n>> XResources fonts"
      , "\nfont=", xFont
      , "\""
      ]
    showXresCmd = "xrdb -query | yad --text-info --center --geometry=400x600 --title \"Xresources\" --button=yad-close:1"

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

-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts
  $ mkToggle (NOBORDERS ?? FULL ?? EOT)
  $ spacingWithEdge myUselessGap (tall ||| full ||| dwindle ||| threeColMid ||| wide ||| zoom ||| threeCol)
  where
    -- default tiling algorithm partitions the screen into two panes
    tall        = renamed [Replace "tall"] (Tall nmaster delta ratio)
    wide        = renamed [Replace "wide"] (Mirror (Tall nmaster delta (3/5)))
    full        = renamed [Replace "full"] (Full)
    threeCol    = renamed [Replace "threeCol"] (ThreeCol nmaster delta ratio)
    threeColMid = renamed [Replace "threeColMid"] (ThreeColMid nmaster delta ratio)
    zoom        = renamed [Replace "zoom"] (Mag.magnifier tall)
    dwindle     = renamed [Replace "dwindle"] (Dwindle R CW 1.5 1.1)

    -- The default number of windows in the master pane
    nmaster  = 1

    -- Default proportion of screen occupied by master pane
    ratio    = 1/2

    -- Percent of screen to increment by when resizing panes
    delta    = 3/100
-- }}}

-- {{{ Scratchpads
myScratchpads :: [NamedScratchpad]
myScratchpads =
  [ NS "term"   spawnTerm findTerm manageTerm
  , NS "top"    spawnTop  findTop  manageTop
  , NS "files"  spawnRgr  findRgr  manageRgr
  , NS "volume" spawnVol  findVol  manageVol
  , NS "mpc"    spawnMpc  findMpc  manageMpc
  , NS "pass"   spawnPass findPass managePass
  , NS "notes"  spawnNote findNote manageNote
  , NS "picscr" spawnScrot findScrot manageScrot
  , NS "picwal" spawnWall findWall manageWall
  , NS "calc"   spawnCalc findCalc manageCalc
  ]
  where
    spawnTerm  = myTerminal ++ " --title scratchpad"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 - h
                 l = 0.95 - w
    spawnTop   = myTerminal ++ " --title top -e btop"
    findTop    = title =? "top"
    manageTop  = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 - h
                 l = 0.95 - w
    spawnRgr   = myTerminal ++ " --title ranger -e yazi"
    findRgr    = title =? "ranger"
    manageRgr  = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 - h
                 l = 0.95 - w
    spawnVol   = "pavucontrol"
    findVol    = className =? "Pavucontrol"
    manageVol  = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 - h
                 l = 0.95 - w
    spawnMpc   = "ymuse"
    findMpc    = className =? "Ymuse"
    manageMpc  = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 - h
                 l = 0.95 - w
    spawnPass  = "1password"
    findPass   = className =? "1Password"
    managePass = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 - h
                 l = 0.95 - w
    spawnNote  = "subl3"
    findNote   = className =? "Sublime_text"
    manageNote = customFloating $ W.RationalRect l t w h
               where
                 h = 0.6
                 w = 0.6
                 t = 0.8 - h
                 l = 0.8 - w
    spawnScrot  = "nsxiv --class NsxivScrot -t ~/Pictures/Screenshots"
    findScrot   = resource =? "NsxivScrot"
    manageScrot = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 - h
                 l = 0.95 - w
    spawnWall  = "nsxiv --class NsxivWall -t -r ~/Pictures/Wallpapers"
    findWall   = resource =? "NsxivWall"
    manageWall = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 - h
                 l = 0.95 - w
    spawnCalc  = "qalculate-gtk"
    findCalc   = className =? "Qalculate-gtk"
    manageCalc = customFloating $ W.RationalRect l t w h
               where
                 h = 0.6
                 w = 0.6
                 t = 0.8 - h
                 l = 0.8 - w
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
myManageHook = namedScratchpadManageHook myScratchpads
  <> composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "dialog"         --> doFloat
    , className =? "confirm"        --> doFloat
    , className =? "error"          --> doFloat
    , className =? "notification"   --> doFloat
    , className =? "splash"         --> doFloat
    , className =? "toolbar"        --> doFloat
    , className =? "file_progress"  --> doFloat
    , className =? "Yad"            --> doFloat
    , className =? "Gsimplecal"     --> doFloat
    , className =? "Espanso"        --> doFloat
    , className =? "Nm-connection-editor" --> doFloat
    , className =? "Blueman-manager" --> doFloat
    , winName   =? "File Operation Progress" --> doFloat
    , role      =? "pop-up"         --> doFloat
    , role      =? "bubble"         --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , isFullscreen --> doFullFloat
    ]
    where
      role = stringProperty "WM_WINDOW_ROLE"
      winName = stringProperty "WM_NAME"
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
myEventHook = swallowEventHook (className =? "Alacritty" <||> className =? "kitty" <||> className =? "Xterm") (return True)
-- }}}

-- {{{ Status bars and logging
------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = updatePointer (0.5, 0.5) (0, 0)

-- windowCount :: X (Maybe String)
-- windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset
--
-- myLogHook = do
--   xmproc0 <- spawnPipe ("xmobar -x 0 $HOME/.config/xmobar/primary.config")
--   xmproc1 <- spawnPipe ("xmobar -x 1 $HOME/.config/xmobar/secondary.config")
--   -- updatePointer (0.5, 0.5) (0, 0)
--   dynamicLogWithPP $  filterOutWsPP ["NSP"] $ xmobarPP
--           { ppOutput = \x -> hPutStrLn xmproc0 x   -- xmobar on monitor 1
--                           >> hPutStrLn xmproc1 x   -- xmobar on monitor 2
--           , ppCurrent = color6 "" . wrap
--                         ("<box type=Bottom width=2 mb=2 color=" ++ color6 ++ ">") "</box>"
--             -- Visible but not current workspace
--           , ppVisible = color6 ""
--             -- Hidden workspace
--           , ppHidden = color5 "" . wrap
--                        ("<box type=Top width=2 mt=2 color=" ++ color5 ++ ">") "</box>"
--             -- Hidden workspaces (no windows)
--           , ppHiddenNoWindows = color5 ""
--             -- Title of active window
--           , ppTitle = color15 "" . shorten 60
--             -- Separator character
--           , ppSep =  "<fc=" ++ color9 ++ "> <fn=1>|</fn> </fc>"
--             -- Urgent workspace
--           , ppUrgent = color8 "" . wrap "!" "!"
--             -- Adding # of windows on current workspace to the bar
--           , ppExtras  = [windowCount]
--             -- order of things in xmobar
--           , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
--           }
-- }}}

-- {{{ Startup hook
------------------------------------------------------------------------
-- Startup hook

myStartupHook :: X ()
myStartupHook = do
  let wallpaperCmd      = "feh --bg-scale " ++ myWallpaperPath ++ " " ++ myWallpaperPath
      statusbarCmd        = "~/.config/xmobar/launch.sh"
      picomCmd          = "picom"
      clipboardHistCmd  = "greenclip daemon"
      polkitCmd         = "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
      notifCmd          = "wired"
      systrayCmd        = "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 5 --transparent true --tint 0x000000 --height 18"
      netManAppletCmd   = "nm-applet"
      sndManAppletCmd   = "pasystray"
      blueManAppletCmd  = "blueman"
      updManAppletCmd   = "GDK_BACKEND=x11 pamac-tray"
      autostartAllCmd   = "dex --autostart --environment XMonad"
      cursorHiderCmd    = "unclutter --fork"
      emojiPickerCmd    = "emote"
  sequence_ [
      spawn     wallpaperCmd
    , spawn     statusbarCmd
    , spawnOnce picomCmd
    , spawnOnce clipboardHistCmd
    , spawnOnce polkitCmd
    , spawnOnce notifCmd
    , spawnOnce systrayCmd
    , spawnOnce netManAppletCmd
    , spawnOnce sndManAppletCmd
    -- , spawnOnce blueManAppletCmd
    -- , spawnOnce updManAppletCmd
    , spawnOnce cursorHiderCmd
    , spawnOnce emojiPickerCmd
    ]
-- }}}

-- {{{ Color scheme
-- https://edwardwibowo.com/blog/switching-themes-on-the-fly-with-xmonad/
splitAtColon :: String -> Maybe (String, String)
splitAtColon str = splitAtTrimming str <$> DL.elemIndex ':' str
  where
    splitAtTrimming :: String -> Int -> (String, String)
    splitAtTrimming s idx = bimap trim (trim . tail) $ splitAt idx s
    trim :: String -> String
    trim = DL.dropWhileEnd DC.isSpace . DL.dropWhile DC.isSpace

getFromXres :: String -> IO String
getFromXres key = do
  installSignalHandlers
  fromMaybe "" . findValue key <$> runProcessWithInput "xrdb" ["-query"] ""
  where
    findValue :: String -> String -> Maybe String
    findValue xresKey xres =
      snd <$>
      DL.find ((== xresKey) . fst) (catMaybes $ splitAtColon <$> lines xres)

xProp :: String -> String
xProp = unsafePerformIO . getFromXres

xFont :: String
xFont = xProp "*font"

xColorFg :: String
xColorFg = xProp "*foreground"

xColorBg :: String
xColorBg = xProp "*background"

xColor :: String -> String
xColor a = xProp $ "*color" ++ a

color0  = xColor "0"
color1  = xColor "1"
color2  = xColor "2"
color3  = xColor "3"
color4  = xColor "4"
color5  = xColor "5"
color6  = xColor "6"
color7  = xColor "7"
color8  = xColor "8"
color9  = xColor "9"
color10 = xColor "10"
color11 = xColor "11"
color12 = xColor "12"
color13 = xColor "13"
color14 = xColor "14"
color15 = xColor "15"

colBg      = xColorBg
colComment = color8
colFg      = xColorFg
colRed     = color1
colYellow  = color3
colGreen   = color2
colCyan    = color6
colBlue    = color4
colMagenta = color5
colOrange  = xColor "16"
colPink    = xColor "17"

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = color0
myFocusedBorderColor = color12
-- }}}

-- {{{ Main
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
myFilter = filterOutWs [scratchpadWorkspaceTag]
main = xmonad
     $ addDescrKeys' ((mod4Mask, xK_F1), showKeybindings) myKeys
     $ docks
     . addEwmhWorkspaceSort (pure myFilter)
     . ewmhFullscreen
     . ewmh
     . xmobarProp
     -- TODO Replace withEasySB with dynamicSBs (https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Hooks-StatusBar.html#g:4)
     -- . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
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
        keys               = myEssentialKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
    -- `additionalKeysP` myKeys

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = " | "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = yellow . wrap " " ""
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, _] -> [ws, l]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor colMagenta ""
    blue     = xmobarColor colBlue ""
    white    = xmobarColor color7 ""
    yellow   = xmobarColor colYellow ""
    red      = xmobarColor colRed ""
    lowWhite = xmobarColor colComment ""
-- }}}
