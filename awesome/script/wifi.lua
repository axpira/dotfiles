#!/usr/bin/env lua
package.path = package.path .. ";/home/axpira/.config/script/lua/?.lua"
local util = require('util')

local function run_command(interface)
  local show = util.parse_command("iw dev " .. interface .. " link")
  if not show then
    print("ERROR")
    return
  end
  return show
end

local function refresh()
  local config = run_command("wlp2s0")
  local icon = ""
  local text = ""
  if config.ssid then
    icon = ""
    text = config.ssid
  end

  return {
    icon = icon,
    text = text,
  }
end

return {
  refresh = refresh,
}
