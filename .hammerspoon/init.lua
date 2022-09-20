spaces = require("hs.spaces")

----------------
-- Configuration
----------------

-- Make the alerts look nicer.
hs.alert.defaultStyle.strokeColor =  {white = 1, alpha = 0}
hs.alert.defaultStyle.fillColor =  {white = 0.05, alpha = 0.75}
hs.alert.defaultStyle.radius =  10

-- Disable the slow default window animations.
hs.window.animationDuration = 0

local hyper = {"cmd", "ctrl", "alt"}
local hyper_shift = {"cmd", "alt", "shift"}
local hyper_third = {"cmd", "ctrl"}

function moveLeftHalf()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end

function moveLeftTwoThird()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w * 2 / 3
    f.h = max.h
    win:setFrame(f)
end

function moveLeftThird()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w / 3
    f.h = max.h
    win:setFrame(f)
end

function moveRightHalf()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end

function moveRightThird()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x + (max.w * 2 / 3)
    f.y = max.y
    f.w = max.w / 3
    f.h = max.h
    win:setFrame(f)
end

function moveCenterThird()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x + (max.w / 3)
    f.y = max.y
    f.w = max.w / 3
    f.h = max.h
    win:setFrame(f)
end

function moveTopHalf()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    if f.x >= max.w / 2 then
        f.x = max.x + (max.w / 2)
    else
        f.x = max.x
    end

    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
end

function moveBottomHalf()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    if f.x >= max.w / 2 then
        f.x = max.x + (max.w / 2)
    else
        f.x = max.x
    end

    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
end

function maximize()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
    win:setFrame(f)
end

function moveToScreen(screenPos)
    window = hs.window.focusedWindow()
    screen = hs.screen.find({x=screenPos, y=0})
    window:moveToScreen(screen)
end

hs.hotkey.bind(hyper, "Left", moveLeftHalf)
hs.hotkey.bind(hyper, "Right", moveRightHalf)
hs.hotkey.bind(hyper, "Up", moveTopHalf)
hs.hotkey.bind(hyper, "Down", moveBottomHalf)
hs.hotkey.bind(hyper, "M", maximize)

hs.hotkey.bind(hyper_third, "Left", moveLeftTwoThird)
hs.hotkey.bind(hyper_third, "Right", moveRightThird)
hs.hotkey.bind(hyper_third, "Down", moveCenterThird)
hs.hotkey.bind(hyper_third, "Up", moveLeftThird)

function MoveWindowToSpace(sp)
    local win = hs.window.focusedWindow()      -- current window
    local uuid = win:screen():spacesUUID()     -- uuid for current screen
    local spaceID = spaces.layout()[uuid][sp]  -- internal index for sp
    maximize()
    spaces.moveWindowToSpace(win:id(), spaceID) -- move window to new space
    spaces.changeToSpace(spaceID)              -- follow window to new space
end

function ChangeToSpace(sp)
    local win = hs.window.focusedWindow()      -- current window
    local uuid = win:screen():spacesUUID()     -- uuid for current screen
    local spaceID = spaces.layout()[uuid][sp]  -- internal index for sp
    spaces.changeToSpace(spaceID)              -- follow window to new space
end

hs.hotkey.bind(hyper, "1",function() MoveWindowToSpace(1) end)
hs.hotkey.bind(hyper, "2",function() MoveWindowToSpace(2) end)
hs.hotkey.bind(hyper, "3",function() MoveWindowToSpace(3) end)
hs.hotkey.bind(hyper, "4",function() MoveWindowToSpace(4) end)

hs.hotkey.bind(hyper, "pad1",function() ChangeToSpace(1) end)
hs.hotkey.bind(hyper, "pad2",function() ChangeToSpace(2) end)
hs.hotkey.bind(hyper, "pad3",function() ChangeToSpace(3) end)
hs.hotkey.bind(hyper, "pad4",function() ChangeToSpace(4) end)

hs.hotkey.bindSpec({hyper, "y" }, hs.toggleConsole)
hs.hotkey.bindSpec({hyper, "r" }, hs.reload)

hs.hotkey.bind(hyper, 'space', hs.spotify.displayCurrentTrack)
hs.hotkey.bind(hyper, 'P',     hs.spotify.play)
hs.hotkey.bind(hyper, 'S',     hs.spotify.pause)
hs.hotkey.bind(hyper, 'N',     hs.spotify.next)
hs.hotkey.bind(hyper, 'I',     hs.spotify.previous)

hs.hotkey.bind(hyper, ']', function() hs.audiodevice.defaultOutputDevice():setVolume(hs.audiodevice.current().volume + 5) end)
hs.hotkey.bind(hyper, '[', function() hs.audiodevice.defaultOutputDevice():setVolume(hs.audiodevice.current().volume - 5) end)

hs.alert.show("Config loaded")
