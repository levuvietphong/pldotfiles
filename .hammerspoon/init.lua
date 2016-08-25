require "hs.wifi"

-- Set grid size.
hs.grid.GRIDWIDTH  = 3
hs.grid.GRIDHEIGHT = 2
hs.grid.MARGINX    = 0
hs.grid.MARGINY    = 0
-- Set window animation off. It's much smoother.
hs.window.animationDuration = 0


-- hot key
hs.hotkey.bind("cmd", "J", function()
                 hs.hints.windowHints(hs.window.visibleWindows(),
                                      nil,
                                      false
                 )
                 end
)


hs.hotkey.bind("cmd", "G", hs.grid.show)
hs.hotkey.bind("cmd", ";", hs.grid.maximizeWindow)


--Auto reload confg
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


local wifiWatcher = nil
local homeSSID = "MyHomeNetwork"
local lastSSID = hs.wifi.currentNetwork()


------------------
-- wifi watcher --
------------------
hs.wifi.watcher.new(function ()
    local currentWifi = hs.wifi.currentNetwork()
    -- short-circuit if disconnecting
    if not currentWifi then return end
    hs.alert.show("Wi-Fi connected to " .. currentWifi, 3)
    hs.audiodevice.defaultOutputDevice():setVolume(0)
end):start()