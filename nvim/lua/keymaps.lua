local util = require'utils'


local opts = {noremap = true, silent = true}
local opts_expr = {expr = true, noremap = true, silent = true}

util.set_global_key_mappings({
  {"i", "<C-l>", [[<C-O>x]], opts },

  {"n", "<Leader>,", [[<Cmd>noh<CR>]], opts},
  {"n", "<Leader>h", [[<C-W><C-H>]], opts},
  {"n", "<Leader>j", [[<C-W><C-J>]], opts},
  {"n", "<Leader>k", [[<C-W><C-K>]], opts},
  {"n", "<Leader>l", [[<C-W><C-L>]], opts},
  {"n", "<Leader>bb", [[<Cmd>b#<CR>]], opts},
  {"n", "<Leader>bn", [[<Cmd>bn<CR>]], opts},
  {"n", "<Leader>bp", [[<Cmd>bp<CR>]], opts},
  {"n", "<Leader>bd", [[<Cmd>b#<bar>bd#<CR>]], opts},
  {"n", "<Leader>bD", [[<Cmd>bd!<CR>]], opts},
  {"n", "<Leader>c", [[<Cmd>cclose<CR>]], opts},
  {"n", "<Leader>z", [[<Cmd>tab split<CR>]], opts},

  {"n", "<Leader>fg", [[<Cmd>lua require("telescope.builtin").live_grep()<CR>]], opts},
  {"n", "<Leader>ff", [[<Cmd>lua require("telescope.builtin").git_files()<CR>]], opts},
  {"n", "<Leader>fF", [[<Cmd>lua require("telescope.builtin").find_files()<CR>]], opts},
  {"n", "<Leader>fb", [[<Cmd>lua require("telescope.builtin").buffers()<CR>]], opts},

  {"n", "<Leader>t", [[<Cmd>TestNearest<CR>]], opts},
  {"n", "<Leader>T", [[<Cmd>TestFile<CR>]], opts},

  {"n", "<Leader>cf", [[<Cmd>Format<CR>]], opts},
  {"n", "]c", [[<cmd>lua require\"gitsigns\".next_hunk()<CR>]], opts},
  {"n", "[c", [[<cmd>lua require\"gitsigns\".prev_hunk()<CR>]], opts},
  -- {"n", "<leader>gs", [[<cmd>lua require"gitsigns".stage_hunk()<CR>]], opts},
  -- {"n", "<leader>gu", [[<cmd>lua require"gitsigns".undo_stage_hunk()<CR>]], opts},
  -- {"n", "<leader>gr", [[<cmd>lua require"gitsigns".reset_hunk()<CR>]], opts},
  -- {"n", "<leader>gR", [[<cmd>lua require"gitsigns".reset_buffer()<CR>]], opts},
  {"n", "<leader>gp", [[<cmd>lua require"gitsigns".preview_hunk()<CR>]], opts},
  -- {"n", "<leader>gb", [[<cmd>lua require"gitsigns".blame_line()<CR>]], opts},

  {"i", "<C-x><C-x>", "compe#complete()", opts_expr},
  {"n", "<C-f>", [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]], opts },
  {"n", "<C-b>", [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]], opts },
  {"i", "<CR>",  "compe#confirm('<CR>')", opts_expr},
  {"i", "<C-e>", "compe#close('<C-e>')",  opts_expr},
  {"n", "K",  [[<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]], opts },
  {"n", "gh", [[<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>]], opts },
  {"n", "gs", [[<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]], opts},
  {"n", "gr", [[<cmd>lua require('lspsaga.rename').rename()<CR>]], opts},
  -- {"n", "gd", [[<cmd>lua require'lspsaga.provider'.preview_definition()<CR>]], opts},
  {"n", "gD", [[<Cmd>lua vim.lsp.buf.declaration()<CR>]], opts},
  {"n", "gd", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], opts},
  {"n", "<Leader>ca", [[<cmd>lua require('lspsaga.codeaction').code_action()<CR>]], opts},
  {"v", "<Leader>ca", [[:<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>]], opts},
  {"n", "<Leader>cd", [[<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>]], opts},
  {"n", "<leader>cc", [[<cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>]], opts},
  {"n", "[e", [[<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>]], opts},
  {"n", "]e", [[<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>]], opts},
  {"n", "[d", [[<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]], opts},
  {"n", "]d", [[<cmd>lua vim.lsp.diagnostic.goto_next()<CR>]], opts},
  {"n", "<A-d>", [[<cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>]], opts},
  {"t", "<A-d>", [[<C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>]], opts},
  {"n", '<Leader>q', [[<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>]], opts},



  --{"n", "<Leader>f", [[<Cmd>Format<CR>]], {noremap = false, silent = true}},
  -- -- {"v", "<", [[<gv]], opts},
  -- -- {"v", ">", [[>gv]], opts},
  -- {"n", "<Leader>t", [[<Cmd>TestNearest<CR>]], opts},
  -- {"n", "<Leader>T", [[<Cmd>TestFile<CR>]], opts},
  -- {"n", "<Leader>n", [[<Cmd>cn<CR>]], opts},
  -- {"n", "<Leader>p", [[<Cmd>cp<CR>]], opts},
  -- {"n", "<Leader>fg", [[<Cmd>lua require("telescope.builtin").live_grep()<CR>]], opts},
  -- {"n", "<Leader>ff", [[<Cmd>lua require("telescope.builtin").git_files()<CR>]], opts},
  -- {"n", "<Leader>fF", [[<Cmd>lua require("telescope.builtin").find_files()<CR>]], opts},
  -- {"n", "<leader>G", [[<Cmd>FloatermNew --width=0.8 --height=0.8 lazygit<CR>]], opts},
  -- {"n", "<leader>W", [[<Cmd>Weather<CR>]], opts},
})
--
--print("mappings set")
--vim.api.nvim_set_keymap("n", [[<Leader>,]], [[<Cmd>noh<CR>]], opts)
--vim.api.nvim_set_keymap("n", "<leader>d", [[<Cmd>bd!<CR>]], opts)
--print(vim.inspect(vim.api.nvim_get_keymap('n')))
