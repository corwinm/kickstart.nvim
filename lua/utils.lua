local M = {}

--- Convert a plugin name to a GitHub URL
--- @param plugin string
--- @return string
local function gh(plugin) return 'https://github.com/' .. plugin end
M.gh = gh

--- Register keymaps in lazy.nvim format
--- @param keymaps table[]
--- Each keymap should be a table with the following format:
--- {
---    mode = string, -- e.g., 'n', 'i', 'v',
---    lhs = string, -- e.g., '<leader>ff'
---    rhs = string|function, -- e.g., '<cmd>Telescope find_files<cr>' or a Lua function
---    desc = string, -- e.g., 'Find files with Telescope'
---    opts = table, -- Optional keymap options (e.g., { silent = true })
--- }
local function registerKeymaps(keymaps)
  for _, keymap in ipairs(keymaps) do
    -- local mode = keymap[1]
    local mode = keymap.mode or 'n'
    local lhs = keymap[1]
    local rhs = keymap[2]
    local opts = keymap[3] or {}
    local desc = keymap.desc or opts.desc
    if desc then opts.desc = desc end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end
M.registerKeymaps = registerKeymaps

return M
