local mp = require 'mp'
local options = require 'mp.options'

local function inc_speed()
    local new_speed = mp.get_property("speed")+.5
    mp.set_property("speed", new_speed)
    mp.osd_message("▶▶ x"..new_speed, 2.5)
end
local function dec_speed()
    local new_speed = mp.get_property("speed")-.5
    if new_speed < 1.5 then new_speed = 1 end -- clear up FP imprecision

    mp.set_property("speed", new_speed)
    mp.osd_message("▶▶ x"..new_speed, 2.5)
end

local function fastforward_handle()
    inc_speed()
    mp.add_timeout(2.5, dec_speed )
end    

local function seekback_handle()
    mp.commandv("seek", -5)
    mp.set_property("speed", 1)
end

mp.add_forced_key_binding("RIGHT", "fastforward", fastforward_handle, {repeatable=true} )
mp.add_forced_key_binding("LEFT", "seekback", seekback_handle, {repeatable=true} )