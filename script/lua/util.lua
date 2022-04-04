
local function parse_file(file, separator, start)
  separator = separator or ":"
  start = start or 1
  local lines = {}
  for line in file:lines() do
    for k, v in string.gmatch(line, "%s*([%w_]+)%s*" .. separator .. "%s*([%w%s]+)%s*") do
      lines[k:lower():sub(start)] = v
   end
  end
  file:close()
  if not next(lines) then
    return nil
  end
  return lines
end

local function parse_command(command, separator)
  local handle = io.popen(command)
  return parse_file(handle, separator)
end

return {
  parse_command = parse_command,
  parse_file= parse_file,
}
