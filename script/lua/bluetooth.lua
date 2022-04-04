#!/usr/bin/env lua
package.path = package.path .. ";/home/axpira/.config/script/lua/?.lua"
local util = require('util')

local show = util.parse_command("bluetoothctl show")
if not show then
  print("ERROR")
  return
end
local icon = ""
local text = ""

if show.powered == "yes" then
  icon = ""
end

local info = util.parse_command("bluetoothctl info")
if info then
  icon=""
  text=info.name
end

print(icon .. " " .. text .. "")
