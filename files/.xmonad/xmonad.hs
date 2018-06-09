import qualified Data.Map                     as M
import           Data.Ratio                   ((%))
import           Graphics.X11.ExtraTypes.XF86
import           XMonad
import           XMonad.Actions.Plane
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops hiding (fullscreenEventHook)
import           XMonad.Hooks.FadeInactive
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.Place
import           XMonad.Hooks.SetWMName
import           XMonad.Hooks.UrgencyHook
import           XMonad.Layout.Circle
import           XMonad.Layout.Fullscreen
import           XMonad.Layout.Grid
import           XMonad.Layout.IM
import           XMonad.Layout.NoBorders
import           XMonad.Layout.PerWorkspace   (onWorkspace)
import           XMonad.Layout.ResizableTile
import           XMonad.Layout.Spacing
import           XMonad.Layout.ThreeColumns
import           XMonad.Prompt
import           XMonad.Prompt.Window
import qualified XMonad.StackSet              as W
import           XMonad.Util.EZConfig
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.Run
import           XMonad.Util.Scratchpad


{-
  General configuration values
-}

myModMask            = mod4Mask  -- super
myNormalBorderColor  = "#002b36"
myFocusedBorderColor = "#dc322f"
myBorderWidth        = 0
mySpacing            = 0
myTerminal           = "gnome-terminal"
myBrowser            = "firefox"

{-
  Workspaces
-}

myWorkspaces =
  [
    "Hub",
    "Dev",
    "Chat",
    "Media",
    "Etc",
    "Draw"
  ]

startupWorkspace = "Hub"


{-
  Layouts + Other Theme Stuff
-}

myXPConfig :: XPConfig
myXPConfig = def { bgColor = "#002b36"
                 , font = "-*-fixed-*-*-*-*-20-*-*-*-*-*-*-*"
                 , height = 40
                 , position = Bottom }


myFloatingPlacement = withGaps (16,0,16,0) (smart (0.5,0.5))

-- NB large center master panel (for gimp)
threeColMid = smartBorders(avoidStruts(ThreeColMid 1 (3/100) (3/4)))

defaultLayouts = smartBorders(avoidStruts(spacing mySpacing(
  ResizableTall 1 (3/100) (1/2) []
  ||| noBorders Full
  ||| Mirror (ResizableTall 1 (3/100) (1/2) [])
  ||| Circle
  ||| Grid
  ||| ThreeColMid 1 (3/100) (1/3))))

myLayouts =
  onWorkspace "Draw" threeColMid $ defaultLayouts


{-
  Keybindings + Actions
-}


centralFloat = customFloating (W.RationalRect 0.25 0.25 0.5 0.5)

scratchpads = [ NS "term" (myTerminal ++ " --class=scratchterm -- tmux") (className =? "scratchterm") centralFloat
              , NS "notes" "emacsclient -c --create-frame --frame-parameters='(quote (name . \"scratchnotes\"))' ~/org/inbox.org" (resource =? "scratchnotes") centralFloat
              , NS "capture" "emacsclient -n -e '(make-capture-frame)'" (resource =? "capture") centralFloat
              , NS "agenda" "emacsclient -n -e '(make-agenda-frame)'" (resource =? "agenda-scratch") centralFloat
              , NS "music" "chromium-browser --app=http://localhost:6680/iris/" (resource =? "localhost__iris") doFullFloat ]


myKeyBindings =
  [
    ((myModMask, xK_b), sendMessage ToggleStruts)
    , ((myModMask, xK_a), sendMessage MirrorShrink)
    , ((myModMask, xK_z), sendMessage MirrorExpand)
    , ((myModMask, xK_p), spawn "synapse")
    , ((myModMask .|. shiftMask, xK_l), spawn "i3lock --color=111111")
    , ((myModMask .|. shiftMask, xK_w), placeFocused myFloatingPlacement)
    , ((myModMask, xK_v), spawn "emacsclient -c")
    , ((myModMask, xK_o), spawn myBrowser)
    , ((myModMask, xK_c), namedScratchpadAction scratchpads "capture")
    , ((myModMask .|. mod1Mask, xK_space), spawn "synapse")
    , ((myModMask, xK_f), windowPromptGoto myXPConfig)
    , ((myModMask, xK_y), windowPromptBring myXPConfig)
    , ((myModMask, xK_u), focusUrgent)
    , ((myModMask, xK_u), focusUrgent)
    , ((myModMask .|. shiftMask , xK_m), namedScratchpadAction scratchpads "music")
    , ((myModMask, xK_a), namedScratchpadAction scratchpads "agenda")
    , ((myModMask, xK_x), namedScratchpadAction scratchpads "term")
    -- useful to check /usr/include/X11/XF86keysym.h for these:
    , ((0, 0x1008FF12), spawn "amixer -D pulse sset Master toggle")
    , ((0, 0x1008FF11), spawn "amixer -D pulse sset Master 10%-")
    , ((0, 0x1008FF13), spawn "amixer -D pulse sset Master 10%+")
  ]


{-
  Management Hooks
-}
myManagementHooks :: [ManageHook]
myManagementHooks = [
  fullscreenManageHook
  , namedScratchpadManageHook scratchpads
  , resource =? "synapse" --> doIgnore
  , className =? "" --> doF (W.shift "Media")  -- this is actually spotify, but it doesn't set it's WM_CLASS property until after boot
  , className =? "zoom" --> doFloat <+> doF (W.shift "Chat")
  , className =? "Slack" --> doF (W.shift "Chat")
  , placeHook myFloatingPlacement
  ]



myStartupHook = do
  spawn "killall tint2 || true && tint2"
  setWMName "LG3D"
  windows $ W.greedyView startupWorkspace

{-
  Main!
-}
main = do
  xmonad $ ewmh $ fullscreenSupport $ withUrgencyHook NoUrgencyHook $ def {
    focusedBorderColor = myFocusedBorderColor
  , normalBorderColor = myNormalBorderColor
  , terminal = myTerminal
  , borderWidth = myBorderWidth
  , layoutHook = myLayouts
  , workspaces = myWorkspaces
  , modMask = myModMask
  , handleEventHook = fullscreenEventHook <+> docksEventHook
  , startupHook = myStartupHook
  , manageHook = manageHook def
      <+> composeAll myManagementHooks
      <+> manageDocks
  }
    `additionalKeys` myKeyBindings
