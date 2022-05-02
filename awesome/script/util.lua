
local function parse_file(file, separator, start)
  separator = separator or ":"
  start = start or 1
  local lines = {}
  for line in file:lines() do
    for k, v in string.gmatch(line, "%s*([%w_]+)%s*" .. separator .. "%s*([%w%s]+)%s*") do
      lines[k:lower():sub(start)] = v
   end
  end
  if not next(lines) then
    return nil
  end
  return lines
end

local function parse_command(command, separator)
  local handle = io.popen(command)
  return parse_file(handle, separator)
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end


return {
  parse_command = parse_command,
  parse_file = parse_file,
  dump = dump,
}
