local settings = require "settings"
settings.webview.zoom_level = 200
--settings.on["example.com"].webview.zoom_level = 200
settings.window.home_page = "https://searx.info"

local engines = settings.window.search_engines
engines.sx = "https://searx.info/?q=%s"
engines.ddg	 = "https://duckduckgo.com/?q=%s"
engines.gh = "https://github.com/search?q=%s"
engines.g = "https://google.com/search?q=%s"

engines.default = engines.sx

local select = require "select"

select.label_maker = function ()
    local chars = charset("asdfghjkl")
    return trim(sort(reverse(chars)))
end

local follow = require "follow"
--follow.stylesheet = "font.size = 20pt"
