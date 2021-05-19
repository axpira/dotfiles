
vim.g.dap_virtual_text = true
vim.g.dap_virtual_text = 'all frames'
require("dapui").setup()

require("telescope").load_extension("dap")
local dap = require("dap")
-- -- python
-- dap.adapters.go = {
--   type = "executable",
--   command = "node",
--   args = {
--     string.format("%s/go/vscode-go/dist/debugAdapter.js", vim.fn.stdpath("cache")),
--   },
-- }
-- dap.configurations.go = {
--   type = "go",
--   name = "Debug",
--   request = "launch",
--   showLog = false,
--   program = "${file}",
--   dlvToolPath = vim.fn.exepath("dlv"),
-- }


dap.adapters.go = function(callback, config)
  local handle
  local pid_or_err
  local port = 38697
  handle, pid_or_err =
    vim.loop.spawn(
    "dlv",
    {
      args = {"dap", "-l", "127.0.0.1:" .. port},
      detached = true
    },
    function(code)
      handle:close()
      print("Delve exited with exit code: " .. code)
    end
  )
  -- Wait 100ms for delve to start
  vim.defer_fn(
    function()
      --dap.repl.open()
      callback({type = "server", host = "127.0.0.1", port = port})
    end,
    100)


  --callback({type = "server", host = "127.0.0.1", port = port})
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      program = "${file}"
    }
}
