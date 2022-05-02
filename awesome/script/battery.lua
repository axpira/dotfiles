#!/usr/bin/env lua
package.path = package.path .. ";/home/axpira/.config/awesome/script/?.lua"
local util = require('util')


local function parse_file(path)
  path = path or "/sys/class/power_supply/BAT0/uevent"
  local file = io.open(path, "r")
  local lines = util.parse_file(file, "=", 14)
  file:close()
  return lines
end

local function get_time(config)
  local t = config.charge_now / config.current_now
  local hours = math.floor(t)
  local minutes = math.floor((t - hours) * 60)
  return string.format("%.02d:%.02d", hours, minutes)
end

local function get_icon(config)
  local status_icons = {
    ["Not charging"] = function() return "" end,
    ["Unknown"] = function() return "" end,
    ["Charging"] = function() return "" end,
    ["Full"] = function() return "" end,
    ["Discharging"] = function()
      percent = config.capacity
      icons = { "", "", "", "", "", "", "", "", "", "", "" }
      return icons[math.floor(percent / 10)]
    end
  }
  local icon = status_icons[config.status]()
  if not icon then
    return ""
  end
  return icon
end

local function status(status)
  local status_table = {
    ["Not charging"] = '?',
    ["Unknown"] = '?',
    ["Charging"] = '+',
    ["Full"] = '=',
    ["Discharging"] = '-',
  }
  return status_table[status]
end

local function refresh()
  local config = parse_file()
  return {
    value = tonumber(config.capacity),
    time = get_time(config),
    icon = get_icon(config),
    status = status(config.status),
  }
end

return {
  refresh = refresh,
}
