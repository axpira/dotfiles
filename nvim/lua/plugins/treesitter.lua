require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
  ensure_installed = {
    "go",
    "python",
    "lua",
    "yaml",
    "json",
    "javascript",
    "bash",
    "typescript",
    "rust",
    "regex",
    "java",
    "html",
    "bash",
    "css",
    "toml",
  },
}
