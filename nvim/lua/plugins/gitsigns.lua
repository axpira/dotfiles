require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', show_count = true, numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', show_count = true, numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', show_count = true, numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', show_count = true, numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', show_count = true, numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  numhl = false,
  linehl = false,
  keymaps = {},
  --   -- Default keymap options
  --   noremap = true,
  --   buffer = true,

  --   ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
  --   ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

  --   ['n <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
  --   ['n <leader>gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
  --   ['n <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
  --   ['n <leader>gR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
  --   ['n <leader>gp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
  --   ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

  --   -- Text objects
  --   ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
  --   ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
  -- },
  watch_index = {
    interval = 1000
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  -- use_decoration_api = true,
  -- use_internal_diff = true,  -- If luajit is present
}

