local api = vim.api
local M = {}
-- helper function until https://github.com/neovim/neovim/pull/13479 arrives
local opts_info = api.nvim_get_all_options_info()
local opt = setmetatable({}, {
  __index = vim.o,
  __newindex = function(_, key, value)
    vim.o[key] = value
    local scope = opts_info[key].scope
    if scope == "win" then
      vim.wo[key] = value
    elseif scope == "buf" then
      vim.bo[key] = value
    end
  end,
})

function M.set_global_options(options)
  for k, v in pairs(options) do
    vim.g[k] = v
  end
end

function M.set_options(options)
  for k, v in pairs(options) do
    opt[k] = v
  end
end

function M.set_buffer_options(options)
  for k, v in pairs(options) do
    vim.bo[k] = v
  end
end

function M.set_global_key_mappings(mappings)
  for _, map in pairs(mappings) do
    api.nvim_set_keymap(unpack(map))
  end
end

function M.set_buf_key_mappings(mappings)
  for _, map in pairs(mappings) do
    api.nvim_buf_set_keymap(0, unpack(map))
  end
end

HOOKS = {}
function M.set_filetype_hooks(hooks)
  local autocmds = {}
  for filetype, hook in pairs(hooks) do
    HOOKS[filetype] = hook
    autocmds["LuaFileTypeHook_" .. M.escape_keymap(filetype)] =
      {{"FileType", filetype, ("lua HOOKS[%q]()"):format(filetype)}};
  end
  M.create_augroups(autocmds)
end

function M.escape_keymap(key)
  -- Prepend with a letter so it can be used as a dictionary key
  return "k" .. key:gsub(".", string.byte)
end

-- grabbed from https://github/norcalli/nvim-utils
function M.create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command("augroup " .. group_name)
    api.nvim_command("autocmd!")
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten {"autocmd", def}, " ")
      api.nvim_command(command)
    end
    api.nvim_command("augroup END")
  end
end

return M
