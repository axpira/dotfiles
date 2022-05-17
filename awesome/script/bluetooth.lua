#!/usr/bin/env lua
package.path = package.path .. ";/home/axpira/.config/script/lua/?.lua"
local util = require('util')

local function run_command(cmd)
  local show = util.parse_command("bluetoothctl " .. cmd)
  if not show then
    print("ERROR")
    return
  end
  return show
end

local function refresh()
  local config = run_command("show")
  --local icon = ""
  local icon = ""
  local text = ""

  if config.powered == "yes" then
    icon = " "
  end

  local config = run_command("info")
  if config then
    icon = " "
    text = config.name
  end

  return {
    icon = icon,
    text = text,
  }
end


return {
  refresh = refresh,
}
