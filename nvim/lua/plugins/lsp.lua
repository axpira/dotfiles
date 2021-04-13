local util = require'utils'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local nvim_lsp = require("lspconfig")
nvim_lsp.gopls.setup{
  capabilities = capabilities,
}
nvim_lsp.dockerls.setup{
  capabilities = capabilities,
}
nvim_lsp.html.setup{
  capabilities = capabilities,
}
nvim_lsp.jsonls.setup{
  capabilities = capabilities,
}
nvim_lsp.pyls.setup{
  capabilities = capabilities,
}
nvim_lsp.sqlls.setup{
  capabilities = capabilities,
}
nvim_lsp.tsserver.setup{
  capabilities = capabilities,
}
nvim_lsp.vimls.setup{
  capabilities = capabilities,
}
nvim_lsp.yamlls.setup{
  capabilities = capabilities,
}

local saga = require("lspsaga")
saga.init_lsp_saga({code_action_prompt = {enable = false}})

require("compe").setup {
  enabled = true,
  autocomplete = false,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    emoji = false,
    vim_dadbod = true,
    nvim_treesitter = true,
    vsnip = true,
    --snippets_nvim = true,
  },
}
