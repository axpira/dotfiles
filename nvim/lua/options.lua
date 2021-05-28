local utils = require'utils'

utils.set_global_options({
  maplocalleader = ' ',
  mapleader = ' ',
})

utils.set_options({
    -- ui options
    pastetoggle = '<F1>',
    number = true,
    title = true,
    titlestring = "%{expand('%:p')}",
    number = true,
    relativenumber = true,
    colorcolumn = "100,120",
    wrap = false,
    termguicolors = true,

    hidden = true,
    list = true,
    -- listchars = [[eol:$,tab:>-,trail:~,extends:>,precedes:<]],
    listchars = [[tab:»·,nbsp:+,trail:·,extends:→,precedes:←]],
    shada = [[!,'500,<50,s10,h]],

    smartcase = true,
    ignorecase = true,
    inccommand = "nosplit",

    splitbelow = true,
    splitright = true,

    wildignorecase = true,
    wildmode = "longest:full,full",

    updatetime = 1000,

    smartindent = true,
    --shortmess = vim.o.shortmess .. "c",
    scrolloff = 12,
    -- completeopt = "menu,menuone,noselect,preview",
    completeopt = "menuone,noselect",
    clipboard = "unnamedplus",

    shiftwidth = 2,
    softtabstop = 2,
    tabstop = 2,
    expandtab = true,

    swapfile = false,

    foldmethod = "indent",
    foldlevelstart = 99,

    omnifunc = "v:lua.vim.lsp.omnifunc",

    undofile = true
})

