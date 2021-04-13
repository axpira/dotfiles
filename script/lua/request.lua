
local http = require "socket.http"

local data = ""

local function collect(chunk)
  if chunk ~= nil then
    data = data .. chunk
    end
  return true
end

local ok, statusCode, headers, statusText = http.request {
  method = "GET",
  url = "http://someserver.sometld/somepath",
  sink = collect
}

print("ok\t",         ok);
print("statusCode", statusCode)
print("statusText", statusText)
print("headers:")
for i,v in pairs(headers) do
  print("\t",i, v)
end

print("data", data)

