-- -----------------------------------------------------------------------------
-- Config based on:
-- https://github.com/exark/dotfiles/blob/master/.hammerspoon/init.lua
--
-- -----------
-- hs settings
-- -----------
-- None of this animation shit:
hs.window.animationDuration = 0

-- Modifier shortcuts
local alt = {"⌥"}
local cmd = {"⌘"}
local ctrl = {"⌃"}
local hyper = {"⌘", "⌥", "⌃", "⇧"}
local pushkey = {"⌃", "⌘"}
local nudgekey= {"⌃", "⌘", "⇧"}

-- --------------------------------------------------------
-- Helper functions - these do all the heavy lifting below.
-- Names are roughly stolen from same functions in Slate :)
-- --------------------------------------------------------
-- Move a window a number of pixels in x and y
function nudge(xpos, ypos)
	local win = hs.window.focusedWindow()
	local f = win:frame()
	f.x = f.x + xpos
	f.y = f.y + ypos
	win:setFrame(f)
end


-- Resize a window by moving the bottom
function yank(xpixels,ypixels)
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.w = f.w + xpixels
	f.h = f.h + ypixels
	win:setFrame(f)
end

-- return the first integer index holding the value
function indexOff(t,val)
   for k,v in ipairs(t) do
      if v == val then return k end
   end
end

-- Resize window for chunk of screen.
-- For x and y: use 0 to expand fully in that dimension, 0.5 to expand halfway
-- For w and h: use 1 for full, 0.5 for half
function push(x, y, w, h)
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w*x)
	f.y = max.y + (max.h*y)
	f.w = max.w*w
	f.h = max.h*h
	win:setFrame(f)
end

-- Move focused window to N/E/S/W
function moveEast()
   local win = hs.window.focusedWindow()
   local current = win:screen()
   win:moveToScreen(current:toEast())
end

function moveWest()
   local win = hs.window.focusedWindow()
   local current = win:screen()
   win:moveToScreen(current:toWest())
end

function moveNorth()
   local win = hs.window.focusedWindow()
   local current = win:screen()
   win:moveToScreen(current:toNorth())
end

function moveSouth()
   local win = hs.window.focusedWindow()
   local current = win:screen()
   win:moveToScreen(current:toSouth())
end

-- ----------------
-- Window positions
-- ----------------
local topLeft     = hs.geometry.rect(0,0,0.5,0.5)
local halfLeft    = hs.geometry.rect(0,0,0.5,1.0)
local bottomLeft  = hs.geometry.rect(0,0.5,0.5,0.5)
local topRight    = hs.geometry.rect(0.5,0,0.5,0.5)
local halfRight   = hs.geometry.rect(0.5,0,0.5,1.0)
local bottomRight = hs.geometry.rect(0.5,0.5,0.5,0.5)
local center      = hs.geometry.rect(0.25,0,0.5,1.0)
local centerWide  = hs.geometry.rect(0.125,0,0.75,1.0)

-- -----------------
-- Window management
-- -----------------

-- Movement hotkeys
hs.hotkey.bind(nudgekey, 'down', function() nudge(0,100) end)  --down
hs.hotkey.bind(nudgekey, "up", function() nudge(0,-100) end)   --up
hs.hotkey.bind(nudgekey, "right", function() nudge(100,0) end) --right
hs.hotkey.bind(nudgekey, "left", function() nudge(-100,0) end) --left

-- Resize hotkeys
-- hs.hotkey.bind(yankkey, "up", function() yank(0,-100) end)   -- yank bottom up
-- hs.hotkey.bind(yankkey, "down", function() yank(0,100) end)  -- yank bottom down
-- hs.hotkey.bind(yankkey, "right", function() yank(100,0) end) -- yank right side right
-- hs.hotkey.bind(yankkey, "left", function() yank(-100,0) end) -- yank right side left

-- Push to screen edge
hs.hotkey.bind(pushkey,"h", function() push(0,0,0.5,1) end) 	  -- left side
hs.hotkey.bind(pushkey,"l", function() push(0.5,0,0.5,1) end)     -- right side
hs.hotkey.bind(nudgekey,"h", function() push(0,0,0.75,1) end) 	  -- left side
hs.hotkey.bind(nudgekey,"l", function() push(0.25,0,0.75,1) end)   -- right side
hs.hotkey.bind(pushkey,"k", function() push(0,0,1,0.5) end) 	  -- top half
hs.hotkey.bind(pushkey,"j", function() push(0,0.5,1,0.5) end)     -- bottom half
hs.hotkey.bind(pushkey,"u", function() push(0,0,0.5,0.5) end)     -- top left
hs.hotkey.bind(pushkey,"i", function() push(0.5,0,0.5,0.5) end)   -- top right
hs.hotkey.bind(pushkey,"n", function() push(0,0.5,0.5,0.5) end)   -- bottom left
hs.hotkey.bind(pushkey,"m", function() push(0.5,0.5,0.5,0.5) end) -- bottom right
hs.hotkey.bind(pushkey,"c", function() push(0.25,0,0.5,1) end) -- center
hs.hotkey.bind(pushkey,"x", function() push(0.0,0,0.25,1) end) -- left of center
hs.hotkey.bind(pushkey,"v", function() push(0.75,0,0.25,1) end) -- right of center
hs.hotkey.bind(nudgekey,"c", function() push(0.125,0,0.75,1) end) -- centerwide

-- Push to other monitor
hs.hotkey.bind(pushkey, 'left', function() moveWest() end)
hs.hotkey.bind(pushkey, 'right', function() moveEast() end)
hs.hotkey.bind(pushkey, 'up', function() moveNorth() end)
hs.hotkey.bind(pushkey, 'down', function() moveSouth() end)

-- Fullscreen
hs.hotkey.bind(pushkey, "f", function() push(0,0,1,1) end)

-- -- set up your windowfilter
-- switcher = hs.window.switcher.new() -- only visible windows, all Spaces
-- hs.window.switcher.ui.backgroundColor = {0.1,0.1,0.1,0}
-- hs.window.switcher.ui.highlightColor = {0.8,0.5,0,0.3}
-- hs.window.switcher.ui.showTitles = false
-- hs.window.switcher.ui.showSelectedTitle = false
-- hs.window.switcher.ui.showThumbnails = true
-- hs.window.switcher.ui.showSelectedThumbnail = false
-- hs.window.switcher.ui.selectedThumbnailSize = 0
-- -- if hammerspoon updated, need to comment drawings.selRect:show() in the draw
-- -- function in
-- -- /Applications/Hammerspoon/Contents/Resources/extensions/hs/window/switcher.lua
-- -- in order to hide the selected rectangle pop-up

-- -- bind to hotkeys; WARNING: at least one modifier key is required!
-- hs.hotkey.bind('alt','tab',function()switcher:next()end)
-- hs.hotkey.bind('alt-shift','tab',function()switcher:previous()end)
-- -- cmd-tab is rebound to alt-tab through Karabiner-elements

-- -- ------------
-- -- Focus window
-- -- ------------
-- hs.hotkey.bind(cmd, 'up', function()
--     hs.window.frontmostWindow():focusWindowNorth()
-- end)

-- hs.hotkey.bind(cmd, 'down', function()
--     hs.window.frontmostWindow():focusWindowSouth()
-- end)

-- hs.hotkey.bind(cmd, 'right', function()
--     hs.window.frontmostWindow():focusWindowEast()
-- end)

-- hs.hotkey.bind(cmd, 'left', function()
--     hs.window.frontmostWindow():focusWindowWest()
-- end)

-- ---------------------
-- Application shortcuts
-- ---------------------
-- WATCH OUT! when adding a hyper + key combination, you also need to add the
-- same shortcut in the ~/.config/karabiner/karabiner.json file, because
-- karabiner-elements cannot both show function keys with fn and use it as a
-- hyper modifier.
hs.hotkey.bind(hyper, "S", function() hs.application.launchOrFocus("Firefox") end)
hs.hotkey.bind(hyper, "C", function() hs.application.launchOrFocus("Calendar") end)
hs.hotkey.bind(hyper, "K", function() hs.application.launchOrFocus("Spotify") end)
hs.hotkey.bind(hyper, "P", function() hs.application.launchOrFocus("Preview") end)
hs.hotkey.bind(hyper, "F", function() hs.application.launchOrFocus("Finder") end)
hs.hotkey.bind(hyper, "M", function() hs.application.launchOrFocus("Mail") end)
-- hs.hotkey.bind(hyper, "Z", function() hs.application.launchOrFocus("zoom.us") end)
-- hs.hotkey.bind(hyper, "V", function() hs.application.launchOrFocus("VLC") end)
hs.hotkey.bind(hyper, "T", function() hs.application.launchOrFocus("Reminders") end)
hs.hotkey.bind(hyper, "N", function() hs.application.launchOrFocus("Notes") end)
hs.hotkey.bind(hyper, "A", function() hs.application.launchOrFocus("Activity Monitor") end)
-- Remapped fn+w to f13 since it might activate WiFi logging?
-- see https://apple.stackexchange.com/a/393558
hs.hotkey.bind({}, "f13", function() hs.application.launchOrFocus("Messages") end)
hs.hotkey.bind(hyper, "B", function() hs.application.launchOrFocus("Bitwarden") end)
hs.hotkey.bind(hyper, "L", function() hs.application.launchOrFocus("Zotero") end)
hs.hotkey.bind(hyper, "E", function() hs.application.launchOrFocus("Emacs") end)

-- -- ---------
-- -- Dark mode
-- -- ---------
-- local fileDarkMode = "/Users/stijn/Documents/Code/Applescripts/Dark Mode.scpt"
-- hs.hotkey.bind(hyper, "D", function() hs.osascript.applescriptFromFile(fileDarkMode) end)

-- -----
-- Hints
-- -----
hs.hotkey.bind(hyper, "H", function() hs.hints.windowHints() end)


-- ---------------
-- Monitor layouts
-- ---------------
-- Monitor names
local primaryScreen = hs.screen.primaryScreen()

-- Check for dual monitor setup
local dual = ((#hs.screen.allScreens()) == 2)
local single = ((#hs.screen.allScreens()) == 1)


-- Define other monitor name
if dual then
   local x = indexOff(hs.screen.allScreens(), hs.screen.find(primaryScreen))
   if x == 1 then
      otherScreen = hs.screen.allScreens()[2]
   else
      otherScreen = hs.screen.allScreens()[1]
   end
end

-- Monitor layouts
local singleMonitor = {
   {"Finder", nil, laptopScreen, topLeft, nil, nil},
   {"Bitwarden", nil, laptopScreen, halfRight, nil, nil},
   {"Emacs",  nil, laptopScreen, hs.layout.maximized, nil, nil},
   {"Firefox",  nil, laptopScreen, hs.layout.maximized, nil, nil},
   {"Activity Monitor", nil, laptopScreen, bottomLeft, nil, nil},
   {"Calendar", nil, laptopScreen, hs.layout.left75, nil, nil},
}

local multipleMonitor = {
   {"Finder", nil, laptopScreen, topLeft, nil, nil},
   {"Bitwarden", nil, laptopScreen, topRight, nil, nil},
   {"Emacs",  nil, laptopScreen, hs.layout.maximized, nil, nil},
   {"Firefox",  nil, laptopScreen, hs.layout.maximized, nil, nil},
   {"Activity Monitor", nil, otherScreen, bottomLeft, nil, nil},
   {"Calendar", nil, otherScreen, hs.layout.left75, nil, nil},
   {"Spotify", nil, otherScreen, hs.layout.maximized, nil, nil},
}


function changeLayout()
   -- Can run into issues if applications in one of the layouts are not running
   -- app:allWindows() will return nil and cause an error
   -- (see https://groups.google.com/g/hammerspoon/c/MowWJud0GbE?pli=1)
  if dual then
     hs.layout.apply(multipleMonitor)
     -- hs.alert("Dual screen layout loaded")
  elseif single then
     hs.layout.apply(singleMonitor)
     -- hs.alert("Single screen layout loaded")
  end
end

-- apply single or multiple monitor layouts
-- run screen watcher to look for setup change
changeLayout()
watcher = hs.screen.watcher.new(changeLayout)
watcher:start()


-- ----------------
-- config reloading
-- ----------------
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

hs.hotkey.bind(hyper, "R", function() hs.reload() end)

-- function showFrontMostApplication()
--    hs.alert.show(hs.application.frontmostApplication())
-- end
-- hs.hotkey.bind(hyper, "X", function() showFrontMostApplication() end)

-- ------------
-- Caffeine.app
-- ------------
local caffeine = hs.menubar.new()

function setCaffeineDisplay(state)
    local result
    if state then
        result = caffeine:setIcon("caffeine-on.pdf")
    else
        result = caffeine:setIcon("caffeine-off.pdf")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

-- put laptop to sleep
-- no longer seems to work in Monterey...
hs.hotkey.bind(hyper, "delete", function() hs.caffeinate.systemSleep() end)
