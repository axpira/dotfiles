local util = require'utils'

util.set_filetype_hooks({
  go = function()
    util.set_buffer_options({
      expandtab = false,
    })
  end,
  html = function()
    util.set_options({
      shiftwidth = 4,
      softtabstop = 4,
    })
  end,
  sh = function()
    util.set_options({
      shiftwidth = 4,
      softtabstop = 4,
    })
  end,
  proto = function()
    util.set_options({
      shiftwidth = 4,
      softtabstop = 4,
    })
  end,
})
