local paq_exists = pcall(vim.cmd, [[ packadd paq-nvim ]])
if not paq_exists then
  local dest = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))
  local repo_url = "https://github.com/savq/paq-nvim.git"

  vim.fn.mkdir(dest, "p")
  print("Downloading paq")
  vim.fn.system(string.format("git clone %s %s", repo_url, dest .. "paq-nvim"))
  vim.cmd 'packadd paq-nvim'
  print("Paq installed")
end

local paq = require'paq-nvim'.paq
paq {'savq/paq-nvim', opt=true}

--colorscheme
paq 'habamax/vim-colors-lessthan'
paq 'jacoborus/tender.vim'

paq 'mhartington/formatter.nvim'


paq 'easymotion/vim-easymotion'
paq 'simeji/winresizer'
--paq 'tpope/vim-surround'
--paq 'tpope/vim-repeat'
paq 'machakann/vim-sandwich'
paq 'wellle/targets.vim'
paq 'tpope/vim-dadbod'

paq 'norcalli/nvim-colorizer.lua'

paq 'hoob3rt/lualine.nvim'
paq 'nvim-treesitter/nvim-treesitter'
-- paq 'L3MON4D3/LuaSnip'
--paq 'norcalli/snippets.nvim'
paq 'hrsh7th/vim-vsnip'
paq 'rafamadriz/friendly-snippets'

paq 'akinsho/nvim-toggleterm.lua'

paq 'nvim-lua/popup.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'nvim-telescope/telescope.nvim'
paq 'lewis6991/gitsigns.nvim'

paq 'b3nj5m1n/kommentary'

--paq 'airblade/vim-rooter'

paq 'neovim/nvim-lspconfig'
paq 'glepnir/lspsaga.nvim'
paq 'hrsh7th/nvim-compe'
paq 'kristijanhusak/vim-dadbod-completion'
--require'plugins.dap'

paq 'vim-test/vim-test'


if not paq_exists then
  print("Installing packages")
  require'paq-nvim'.install()
end

vim.cmd([[colorscheme lessthan]])

require'plugins.treesitter'

require'plugins.formatter'

require'colorizer'.setup {
  'css';
  'javascript';
  html = {
    mode = 'foreground';
  }
}
require'plugins.lualine'

require'toggleterm'.setup({
  size = 20,
  open_mapping = [[<m-t>]],
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1,
  persist_size = true,
  direction = 'horizontal',
})

local actions = require('telescope.actions')
require'telescope'.setup{
  defaults = {
    defaults = {shorten_path = false},
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-S-j>"] = actions.move_selection_better,
        ["<C-S-k>"] = actions.move_selection_worse,
      },
    },
  }
}

require'plugins.gitsigns'

require'kommentary.config'.configure_language("default", {
  prefer_single_line_comments = true,
})

require'plugins.lsp'

vim.g["test#strategy"] = "neovim"
vim.g["test#neovim#term_position"] = "bot 30"
