require("lualine").setup {
  --theme = "gruvbox",
  options = {
    icons_enabled = false,
  },
  separator = "|",
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch","diff"},
    lualine_c = {
      {"filename", full_path = true},
      {"diagnostics", sources = {"nvim_lsp"}},
    },
    lualine_x = {"encoding", "fileformat", "filetype"},
    lualine_y = {"progress"},
    lualine_z = {"location"},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {},
  },
}
