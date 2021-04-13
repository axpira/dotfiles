
local paq = require'paq-nvim'.paq

paq 'mfussenegger/nvim-dap'
paq 'nvim-telescope/telescope-dap.nvim'

require("telescope").load_extension("dap")
local dap = require("dap")
-- python
dap.adapters.go = {
  type = "executable",
  command = "node",
  args = {
    string.format("%s/go/vscode-go/dist/debugAdapter.js", vim.fn.stdpath("cache")),
  },
}
dap.configurations.go = {
  type = "go",
  name = "Debug",
  request = "launch",
  showLog = false,
  program = "${file}",
  dlvToolPath = vim.fn.exepath("dlv"),
}
