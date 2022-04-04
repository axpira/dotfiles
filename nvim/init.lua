--require('mini.base16').mini_palette('#112641', '#e2e98f', 75)
--require('mini.bufremove').setup({})
--require('mini.comment').setup({})
----require('mini.completion').setup({})
----require('mini.cursorword').setup({ delay = 1000 })
--require('mini.misc').setup({})
----require('mini.pairs').setup({})
--require('mini.statusline').setup({})
--require('mini.surround').setup({})
--require('mini.trailspace').setup({})
require('Comment').setup()
require("dapui").setup()
--require('mini.fuzzy').setup({})
require('telescope').setup({})
--require('telescope').setup({defaults = {generic_sorter = require('mini.fuzzy').get_telescope_sorter}})
require('telescope').load_extension('dap')
require('dap-go').setup()
require("nvim-dap-virtual-text").setup()
require("dap-python").setup("/usr/bin/python")
require'nvim-web-devicons'.setup({})
require("trouble").setup({})
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.autopep8,
      null_ls.builtins.formatting.black,
      -- null_ls.builtins.formatting.codespell,
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.formatting.fixjson,
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.gofumpt,
      null_ls.builtins.formatting.goimports,
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.protolint,
      null_ls.builtins.formatting.shellharden,
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.formatting.taplo,
      null_ls.builtins.formatting.trim_newlines,
      null_ls.builtins.formatting.trim_whitespace,

      null_ls.builtins.diagnostics.mypy,
      null_ls.builtins.diagnostics.actionlint,
      null_ls.builtins.diagnostics.checkmake,
      null_ls.builtins.diagnostics.codespell,
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.diagnostics.flake8,
      null_ls.builtins.diagnostics.jsonlint,
      null_ls.builtins.diagnostics.markdownlint,
      null_ls.builtins.diagnostics.misspell,
      null_ls.builtins.diagnostics.proselint,
      null_ls.builtins.diagnostics.protoc_gen_lint,
      null_ls.builtins.diagnostics.protolint,
      null_ls.builtins.diagnostics.pydocstyle,
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.diagnostics.standardjs,
      null_ls.builtins.diagnostics.trail_space,
      null_ls.builtins.diagnostics.vulture,
      null_ls.builtins.diagnostics.write_good,
      null_ls.builtins.diagnostics.xo,
      null_ls.builtins.diagnostics.yamllint,
      null_ls.builtins.diagnostics.staticcheck,
      null_ls.builtins.diagnostics.golangci_lint,

      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.proselint,
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.code_actions.xo,

      null_ls.builtins.completion.spell,
    },
})
require('gitsigns').setup()

vim.opt.termguicolors = true
require('colorizer').setup()

local components = {
    active = {},
    inactive = {}
}
table.insert(components.inactive, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})
table.insert(components.inactive[2], {
  provider = 'file_info',
  type = 'full-path',
  left_sep = ' ',
})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
-- table.insert(components.active[1], {
--     -- Component info here
-- })
table.insert(components.active[1], {
  provider = 'vi_mode',
  hl = function()
        return {
            name = require('feline.providers.vi_mode').get_mode_highlight_name(),
            fg = require('feline.providers.vi_mode').get_mode_color(),
        }
    end,
})
table.insert(components.active[1], {
  provider = 'git_branch',
})
table.insert(components.active[1], {
  provider = 'git_diff_added',
  left_sep = ' ',
  hl = {
      fg = 'lightgreen',
  }
})
table.insert(components.active[1], {
  provider = 'git_diff_removed',
  hl = {
      fg = 'lightred',
  }
})
table.insert(components.active[1], {
  provider = 'git_diff_changed',
  hl = {
      fg = 'orange',
  }
})
-- table.insert(components.active[1], {
--   provider = 'lsp_client_names',
--   left_sep = ' ',
-- })
table.insert(components.active[1], {
  provider = 'diagnostic_warnings',
  left_sep = ' ',
  hl = {
      fg = 'yellow',
  }
})
table.insert(components.active[1], {
  provider = 'diagnostic_errors',
  hl = {
      fg = 'red',
  }
})
table.insert(components.active[1], {
  provider = 'diagnostic_hints',
  left_sep = ' ',
  hl = {
      fg = 'cyan',
  }
})
table.insert(components.active[1], {
  provider = 'diagnostic_info',
  left_sep = ' ',
})
table.insert(components.active[2], {
  provider = 'file_info',
  type = 'full-path',
  left_sep = ' ',
})
table.insert(components.active[3], {
  provider = 'file_type',
})
table.insert(components.active[3], {
  provider = 'file_format',
  left_sep = ' ',
})
table.insert(components.active[3], {
  provider = 'file_encoding',
  left_sep = ' ',
})
table.insert(components.active[3], {
  provider = 'position',
  left_sep = ' ',
})
table.insert(components.active[3], {
  provider = 'line_percentage',
  left_sep = ' ',
})
-- components.active[2][1] = {
--     -- Component info here
-- }
-- components.active[3][1] = {
--     -- Component info here
-- }
require('feline').setup({
  components = components,
})

vim.g.maplocalleader = ' '
vim.g.mapleader = ' '

vim.opt.pastetoggle = '<F1>'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = '120,140'
vim.opt.wrap = false
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.scrolloff = 12
vim.opt.completeopt = "menuone,noselect"
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
--vim.opt.clipboard = "unnamed"

vim.opt.swapfile = false

vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
vim.opt.undofile = true
vim.bo.undofile = true

vim.opt.list = true
vim.opt.listchars = [[tab:»·,nbsp:+,trail:·,extends:→,precedes:←]]

vim.cmd [[
colorscheme rams
]]


local map = vim.api.nvim_set_keymap

--map('n', '<Leader>w', ':write<CR>', {noremap = true})
map('i', '<C-l>', [[<C-O>x]], {noremap = true})
map("n", "<Leader>,", [[<Cmd>noh<CR>]], {noremap = true})
map("n", "<Leader>h", [[<C-W><C-H>]], {noremap = true})
map("n", "<Leader>j", [[<C-W><C-J>]], {noremap = true})
map("n", "<Leader>k", [[<C-W><C-K>]], {noremap = true})
map("n", "<Leader>l", [[<C-W><C-L>]], {noremap = true})
map("n", "<Leader>bb", [[<Cmd>b#<CR>]], {noremap = true})
map("n", "<Leader>bn", [[<Cmd>bn<CR>]], {noremap = true})
map("n", "<Leader>bp", [[<Cmd>bp<CR>]], {noremap = true})
map("n", "<Leader>bd", [[<Cmd>b#<bar>bd#<CR>]], {noremap = true})
map("n", "<Leader>bD", [[<Cmd>bd!<CR>]], {noremap = true})
map("n", "<Leader>c", [[<Cmd>cclose<CR>]], {noremap = true})
--map("n", "<Leader>z", [[<Cmd>lua MiniMisc.zoom()<CR>]], {noremap = true})
map("n", "<Leader>z", [[<Cmd>tab split<CR>]], {noremap = true})
--map("n", "<Leader>t", [[<Cmd>lua MiniTrailspace.trim()<CR>]], {noremap = true})
map("n", "Y", [["+y]], {noremap = true})
map("v", "Y", [["+y]], {noremap = true})
-- map("n", "P", [["+p]], {noremap = true})
-- map("v", "P", [["+p]], {noremap = true})
map("n", "H", "^", {noremap = true})
map("n", "L", "$", {noremap = true})

map("i", "<C-k>", [[<cmd>lua vim.lsp.buf.hover()<CR>]], {noremap = true})
map("n", "K", [[<cmd>lua vim.lsp.buf.hover()<CR>]], {noremap = true})
--map("i", '<C-K>', [[<cmd>lua vim.lsp.buf.signature_help()<CR>]], {noremap = true})
--map("i", "<C-k>", [[<cmd>lua vim.lsp.buf.hover()<CR>]], {noremap = true})
-- map("n", "[e", [[<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]], {noremap = true})
-- map("n", "]e", [[<cmd>lua vim.lsp.diagnostic.goto_next()<CR>]], {noremap = true})
--map("n", "gD", [[<Cmd>lua vim.lsp.buf.declaration()<CR>]], {noremap = true})
map('n', '<Leader>gh', [[<cmd>lua vim.lsp.buf.hover()<CR>]], {noremap = true})
map("n", "<Leader>gd", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], {noremap = true})
--map("n", "gd", [[<Cmd>Telescope lsp_definitions<CR>]], {noremap = true})
map('n', '<Leader>gi', [[<cmd>Telescope lsp_implementations<CR>]], {noremap = true})
map('n', '<Leader>gr', [[<cmd>Telescope lsp_references<CR>]], {noremap = true})
map("n", "<Leader>gR", [[<Cmd>lua vim.lsp.buf.rename()<CR>]], {noremap = true})
map('n', '<Leader>gt', '<cmd>Telescope lsp_type_definitions<CR>', {noremap = true})
map('n', '<Leader>gD', '<cmd>Telescope diagnostics<CR>', {noremap = true})
map('n', '<Leader>ga', '<cmd>Telescope lsp_code_actions<CR>', {noremap = true})
map('n', '<Leader>gq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', {noremap = true})
map('n', '<Leader>gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', {noremap = true})
map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {noremap = true})
map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {noremap = true})

map("n", "]g", [[<cmd>lua require"gitsigns".next_hunk()<CR>]], {noremap = true})
map("n", "[g", [[<cmd>lua require"gitsigns".prev_hunk()<CR>]], {noremap = true})


map("n", "<Leader>fg", [[<Cmd>lua require("telescope.builtin").live_grep()<CR>]], {noremap = true})
map("n", "<Leader>fG", [[<Cmd>lua require("telescope.builtin").grep_string()<CR>]], {noremap = true})
map("n", "<Leader>ff", [[<Cmd>lua require("telescope.builtin").git_files()<CR>]], {noremap = true})
map("n", "<Leader>fF", [[<Cmd>lua require("telescope.builtin").find_files()<CR>]], {noremap = true})
map("n", "<Leader>fb", [[<Cmd>lua require("telescope.builtin").buffers()<CR>]], {noremap = true})

map("n", "<F2>" , [[<cmd>lua require('dapui').toggle()<CR>]], {noremap=true})
map("n", "<F3>" , [[<cmd>lua require('dapui').eval()<CR>]], {noremap=true})
map("n", "<F4>" , [[<cmd>lua require('dap').toggle_breakpoint()<CR>]], {noremap=true})
map("n", "<F5>" , [[<cmd>lua require('dap').continue()<CR>]], {noremap=true})
map("n", "<F6>" , [[<cmd>lua require('dap').step_over()<CR>]], {noremap=true})
map("n", "<F7>" , [[<cmd>lua require('dap').step_into()<CR>]], {noremap=true})
map("n", "<F8>" , [[<cmd>lua require('dap').step_out()<CR>]], {noremap=true})
map("n", "<Leader>dt" , [[<cmd>lua require('dap-go').debug_test()<CR>]], {noremap=true})

local nvim_lsp = require("lspconfig")
nvim_lsp.gopls.setup({
  settings = {
    gopls = {
      buildFlags =  {"-tags=integration test functional"},
    }
  },
})
nvim_lsp.dockerls.setup({})
nvim_lsp.html.setup({})
nvim_lsp.jsonls.setup({})
nvim_lsp.pyright.setup({})
nvim_lsp.sqlls.setup({})
nvim_lsp.tsserver.setup({})
nvim_lsp.vimls.setup({})
nvim_lsp.yamlls.setup({})



vim.cmd [[
autocmd BufRead * autocmd FileType <buffer> ++once
      \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
      \ | wincmd p | diffthis
]]
