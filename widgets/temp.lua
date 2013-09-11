
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013, Luke Bonham                     
                                                  
--]]

local newtimer     = require("lain.helpers").newtimer

local wibox        = require("wibox")

local io           = io
local tonumber     = tonumber

local setmetatable = setmetatable

-- coretemp
-- lain.widgets.temp
local temp = {}

local function worker(args)
    local args     = args or {}
    local timeout  = args.timeout or 5
    local settings = args.settings or function() end

    temp.widget = wibox.widget.textbox('')

    function temp.update()
        local f = io.open("/sys/class/thermal/thermal_zone0/temp")
        coretemp_now = tonumber(f:read("*all")) / 1000
        f:close()
        widget = temp.widget
        settings()
    end

    newtimer("coretemp", timeout, temp.update)

    return temp.widget
end

return setmetatable(temp, { __call = function(_, ...) return worker(...) end })
