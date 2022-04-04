#!/usr/bin/env lua
package.path = package.path .. ";/home/axpira/.config/script/lua/?.lua"
local util = require('util')

local name = "/sys/class/power_supply/BAT0/uevent"

local file = io.open(name, "r")
local lines = util.parse_file(file, "=", 14)

function get_time()
  local t = lines.charge_now / lines.current_now
  local hours = math.floor(t)
  local minutes = math.floor((t - hours) * 60)
  return string.format("%.02d:%.02d", hours, minutes)
end

function get_icon()
  local status_icons = {
    ["Not charging"] = function() return "" end,
    ["Unknown"] = function() return "" end,
    ["Charging"] = function() return "" end,
    ["Full"] = function() return "" end,
    ["Discharging"] = function()
      percent = lines.capacity
      icons = { "", "", "", "", "", "", "", "", "", "", "" }
      return icons[math.floor(percent / 10)]
    end
  }
  local icon = status_icons[lines.status]()
  if not icon then
    return ""
  end
  return icon
end

local sep = ""
if lines.status == "Discharging" then
  print(string.format("%s%s%s%s%s%%", get_icon(), sep, get_time(), sep, lines.capacity))
else
  print(string.format("%s%s%s%%", get_icon(), sep, lines.capacity))
end
