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
require("twilight").setup({
  dimming = {
    inactive = true,
  },
  context = 10,
  treesitter = true,
  expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
    "function",
    "method",
    "table",
    "if_statement",
  },
})
--require("twilight").enable()

require('refactoring').setup({})
require('leap').setup({})
require('leap').set_default_keymaps()
require("telescope").load_extension("refactoring")

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
      null_ls.builtins.formatting.mdformat,

      null_ls.builtins.diagnostics.mypy,
      -- null_ls.builtins.diagnostics.actionlint,
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
      null_ls.builtins.diagnostics.vale,

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

require("rest-nvim").setup({
  -- Open request results in a horizontal split
  result_split_horizontal = false,
  -- Skip SSL verification, useful for unknown certificates
  skip_ssl_verification = false,
  -- Highlight request on run
  highlight = {
    enabled = true,
    timeout = 150,
  },
  result = {
    -- toggle showing URL, HTTP info, headers at top the of result window
    show_url = true,
    show_http_info = true,
    show_headers = true,
  },
  -- Jump to request line on run
  jump_to_request = false,
  env_file = '.env',
  custom_dynamic_variables = {},
  yank_dry_run = true,
})

-- local components = {
--     active = {},
--     -- inactive = {}
-- }
-- -- table.insert(components.inactive, {})
-- -- table.insert(components.inactive, {})
-- -- table.insert(components.inactive, {})
-- -- table.insert(components.inactive, {})
-- -- table.insert(components.inactive[2], {
-- --   provider = 'file_info',
-- --   type = 'full-path',
-- --   left_sep = ' ',
-- -- })
-- table.insert(components.active, {})
-- table.insert(components.active, {})
-- table.insert(components.active, {})
-- -- table.insert(components.active[1], {
-- --     -- Component info here
-- -- })
-- table.insert(components.active[1], {
--   provider = 'vi_mode',
--   hl = function()
--         return {
--             name = require('feline.providers.vi_mode').get_mode_highlight_name(),
--             fg = require('feline.providers.vi_mode').get_mode_color(),
--         }
--     end,
-- })
-- table.insert(components.active[1], {
--   provider = 'git_branch',
-- })
-- table.insert(components.active[1], {
--   provider = 'git_diff_added',
--   left_sep = ' ',
--   hl = {
--       fg = 'lightgreen',
--   }
-- })
-- table.insert(components.active[1], {
--   provider = 'git_diff_removed',
--   hl = {
--       fg = 'lightred',
--   }
-- })
-- table.insert(components.active[1], {
--   provider = 'git_diff_changed',
--   hl = {
--       fg = 'orange',
--   }
-- })
-- -- table.insert(components.active[1], {
-- --   provider = 'lsp_client_names',
-- --   left_sep = ' ',
-- -- })
-- table.insert(components.active[1], {
--   provider = 'diagnostic_warnings',
--   left_sep = ' ',
--   hl = {
--       fg = 'yellow',
--   }
-- })
-- table.insert(components.active[1], {
--   provider = 'diagnostic_errors',
--   hl = {
--       fg = 'red',
--   }
-- })
-- table.insert(components.active[1], {
--   provider = 'diagnostic_hints',
--   left_sep = ' ',
--   hl = {
--       fg = 'cyan',
--   }
-- })
-- table.insert(components.active[1], {
--   provider = 'diagnostic_info',
--   left_sep = ' ',
-- })
-- table.insert(components.active[2], {
--   provider = {
--     name = 'file_info',
--     opts = {
--       type = 'relative'
--     },
--   }
-- })
-- table.insert(components.active[3], {
--   provider = 'file_type',
-- })
-- table.insert(components.active[3], {
--   provider = 'file_format',
--   left_sep = ' ',
-- })
-- table.insert(components.active[3], {
--   provider = 'file_encoding',
--   left_sep = ' ',
-- })
-- table.insert(components.active[3], {
--   provider = 'position',
--   left_sep = ' ',
-- })
-- table.insert(components.active[3], {
--   provider = 'line_percentage',
--   left_sep = ' ',
-- })
-- -- components.active[2][1] = {
-- --     -- Component info here
-- -- }
-- -- components.active[3][1] = {
-- --     -- Component info here
-- -- }
vim.opt.laststatus = 3
-- require('feline').setup({
--   components = components,
-- })

require('mini.statusline').setup({
   set_vim_settings = false,
})

vim.g.maplocalleader = ' '
vim.g.mapleader = ' '

require('mini.surround').setup({
  -- Add custom surroundings to be used on top of builtin ones. For more
  -- information with examples, see `:h MiniSurround.config`.
  custom_surroundings = nil,

  -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
  highlight_duration = 500,

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    add = '<Leader>sa', -- Add surrounding in Normal and Visual modes
    delete = '<Leader>sd', -- Delete surrounding
    find = '<leader>sf', -- Find surrounding (to the right)
    find_left = '<Leader>sF', -- Find surrounding (to the left)
    highlight = '<Leader>sh', -- Highlight surrounding
    replace = '<Leader>sr', -- Replace surrounding
    update_n_lines = '<Leader>sn', -- Update `n_lines`
  },

  -- Number of lines within which surrounding is searched
  n_lines = 20,

  -- How to search for surrounding (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest'. For more details, see `:h MiniSurround.config`.
  search_method = 'cover',
})
-- {
--   -- Content of statusline as functions which return statusline string. See
--   -- `:h statusline` and code of default contents (used instead of `nil`).
--   content = {
--     -- Content for active window
--     active = nil,
--     -- Content for inactive window(s)
--     inactive = nil,
--   },
--
--   -- Whether to set Vim's settings for statusline (make it always shown with
--   -- 'laststatus' set to 2). To use global statusline in Neovim>=0.7.0, set
--   -- this to `false` and 'laststatus' to 3.
--   set_vim_settings = false,
-- })

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
colorscheme base16-grayscale-dark
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
-- map('n', '<Leader>ga', '<cmd>Telescope lsp_code_actions<CR>', {noremap = true})
map('n', '<Leader>ga', [[<cmd>lua vim.lsp.buf.code_action()<CR>]], {noremap = true})
map('n', '<Leader>gq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', {noremap = true})
map('n', '<Leader>gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', {noremap = true})
map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {noremap = true})
map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {noremap = true})

map("n", "]g", [[<cmd>lua require"gitsigns".next_hunk()<CR>]], {noremap = true})
map("n", "[g", [[<cmd>lua require"gitsigns".prev_hunk()<CR>]], {noremap = true})


map("n", "<Leader>fg", [[<Cmd>lua require("telescope.builtin").live_grep()<CR>]], {noremap = true})
map("n", "<Leader>fG", [[<Cmd>lua require("telescope.builtin").grep_string()<CR>]], {noremap = true})
map("n", "<Leader>fF", [[<Cmd>lua require("telescope.builtin").git_files()<CR>]], {noremap = true})
map("n", "<Leader>ff", [[<Cmd>lua require("telescope.builtin").find_files()<CR>]], {noremap = true})
map("n", "<Leader>fb", [[<Cmd>lua require("telescope.builtin").buffers()<CR>]], {noremap = true})
map("n", "<Leader>t", [[<Cmd>TroubleToggle<CR>]], {noremap = true})
map("n", "<Leader>T", [[<Cmd>TroubleToggle workspace_diagnostics<CR>]], {noremap = true})

-- Remaps for the refactoring operations currently offered by the plugin
vim.api.nvim_set_keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})
-- Extract block doesn't need visual mode
vim.api.nvim_set_keymap("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], {noremap = true, silent = true, expr = false})
-- Inline variable can also pick up the identifier currently under the cursor without visual mode
vim.api.nvim_set_keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})
-- -- prompt for a refactor to apply when the remap is triggered
-- vim.api.nvim_set_keymap(
--     "v",
--     "<leader>rr",
--     ":lua require('refactoring').select_refactor()<CR>",
--     { noremap = true, silent = true, expr = false }
-- )
--
-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
	"v",
	"<leader>rr",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
	{ noremap = true }
)

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
