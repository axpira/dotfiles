require('mini.base16').mini_palette('#112641', '#e2e98f', 75)
require('mini.bufremove').setup({})
require('mini.comment').setup({})
--require('mini.completion').setup({})
--require('mini.cursorword').setup({ delay = 1000 })
require('mini.fuzzy').setup({})
require('mini.misc').setup({})
require('mini.pairs').setup({})
require('mini.statusline').setup({})
require('mini.surround').setup({})
require('mini.trailspace').setup({})
require('gitsigns').setup()

vim.opt.termguicolors = true
require('colorizer').setup()

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

vim.opt.swapfile = false

vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
vim.opt.undofile = true

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
map("n", "<Leader>z", [[<Cmd>lua MiniMisc.zoom()<CR>]], {noremap = true})
map("n", "<Leader>t", [[<Cmd>lua MiniTrailspace.trim()<CR>]], {noremap = true})

map("n", "K", [[<cmd>lua vim.lsp.buf.hover()<CR>]], {noremap = true})
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {noremap = true})
map("i", "<C-k>", [[<cmd>lua vim.lsp.buf.hover()<CR>]], {noremap = true})
-- map("n", "[e", [[<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]], {noremap = true})
-- map("n", "]e", [[<cmd>lua vim.lsp.diagnostic.goto_next()<CR>]], {noremap = true})
map("n", "gD", [[<Cmd>lua vim.lsp.buf.declaration()<CR>]], {noremap = true})
--map("n", "gd", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], {noremap = true})
map("n", "gd", [[<Cmd>Telescope lsp_definitions<CR>]], {noremap = true})
--map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap = true})
map('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', {noremap = true})
--map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {noremap = true})
map('n', 'gr', '<cmd>Telescope lsp_references<CR>', {noremap = true})
map("n", "<Leader>rn", [[<Cmd>lua vim.lsp.buf.rename()<CR>]], {noremap = true})
--map('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {noremap = true})
map('n', '<Leader>D', '<cmd>Telescope lsp_type_definitions<CR>', {noremap = true})
--map('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true})
map('n', '<Leader>ca', '<cmd>Telescope lsp_code_actions<CR>', {noremap = true})
map('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', {noremap = true})
map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {noremap = true})
map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {noremap = true})
map('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', {noremap = true})
map('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', {noremap = true})

map("n", "]g", [[<cmd>lua require"gitsigns".next_hunk()<CR>]], {noremap = true})
map("n", "[g", [[<cmd>lua require"gitsigns".prev_hunk()<CR>]], {noremap = true})


map("n", "<Leader>fg", [[<Cmd>lua require("telescope.builtin").live_grep()<CR>]], {noremap = true})
map("n", "<Leader>ff", [[<Cmd>lua require("telescope.builtin").git_files()<CR>]], {noremap = true})
map("n", "<Leader>fF", [[<Cmd>lua require("telescope.builtin").find_files()<CR>]], {noremap = true})
map("n", "<Leader>fb", [[<Cmd>lua require("telescope.builtin").buffers()<CR>]], {noremap = true})

map("n", '<M-h>', [[<C-w><<CR>]], {noremap = true})
map("n", '<M-l>', [[<C-w>><CR>]], {noremap = true})
map("n", '<M-k>', [[<C-w>-<CR>]], {noremap = true})
map("n", '<M-j>', [[<C-w>+<CR>]], {noremap = true})

local nvim_lsp = require("lspconfig")
nvim_lsp.gopls.setup({})
nvim_lsp.dockerls.setup({})
nvim_lsp.html.setup({})
nvim_lsp.jsonls.setup({})
nvim_lsp.pyright.setup({})
nvim_lsp.sqlls.setup({})
nvim_lsp.tsserver.setup({})
nvim_lsp.vimls.setup({})
nvim_lsp.yamlls.setup({})
