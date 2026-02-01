# AGENTS.md - Neovim Configuration Guide for AI Coding Agents

This document provides essential information for AI coding agents working in this Neovim configuration repository.

## Repository Overview

This is a **Neovim configuration** based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - a well-documented, single-file starting point for Neovim. It uses **Lua** as the primary language and **Lazy.nvim** for plugin management.

## Build/Lint/Test Commands

### Formatting
```bash
# Format all Lua files with Stylua
stylua .

# Check formatting without modifying files
stylua --check .
```

### Health Checks
```bash
# Run health checks (from within Neovim)
:checkhealth
:checkhealth kickstart

# The health check validates:
# - Neovim version (requires 0.11+)
# - External dependencies (git, make, unzip, ripgrep)
# - System information
```

### Testing
**No automated testing framework is configured.** Changes should be manually validated by:
1. Opening Neovim and checking for errors
2. Running `:checkhealth` to verify configuration
3. Testing affected plugins/features manually

### CI/CD
- **GitHub Action**: `.github/workflows/stylua.yml` runs on PRs
- Validates Lua formatting with `stylua --check .`

## Code Style Guidelines

### Lua Formatting (Stylua)

Configuration: `.stylua.toml`

```toml
column_width = 160        # Maximum line width
indent_type = "Spaces"    # Use spaces, not tabs
indent_width = 2          # 2 spaces per indent level
quote_style = "AutoPreferSingle"  # Prefer 'single' over "double"
call_parentheses = "None" # Function calls without parens: require 'module'
```

**Examples:**
```lua
-- ✅ GOOD
local telescope = require 'telescope'
local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = desc })
end

-- ❌ BAD
local telescope = require("telescope");  -- Double quotes, semicolon
local map = function (keys, func, desc)  -- Space before parens
  vim.keymap.set("n", keys, func, {desc=desc}) -- Inconsistent spacing
end
```

### Imports and Requires

**Pattern:** Use `require 'module'` without parentheses (per Stylua config)

```lua
-- ✅ Standard requires
local telescope = require 'telescope'
local actions = require 'telescope.actions'

-- ✅ Conditional requires (inside functions)
config = function()
  local lint = require 'lint'
  lint.linters_by_ft = { ... }
end
```

### Type Annotations

Use **LuaLS/EmmyLua** style annotations for complex functions:

```lua
---@param title string|?
---@param client obsidian.Client
---@return string
local function create_note(title, client)
  -- implementation
end

-- Suppress specific diagnostics when needed
---@diagnostic disable-next-line: unused-local
```

### Plugin Structure (Lazy.nvim)

Every plugin file in `lua/custom/plugins/` or `lua/kickstart/plugins/` should return a table:

```lua
return {
  'author/plugin-name',
  dependencies = { 'required/dependency' },  -- Optional
  event = 'VimEnter',  -- Lazy-load on event
  cmd = 'CommandName',  -- Lazy-load on command
  keys = {  -- Lazy-load on keymap
    { '<leader>x', '<cmd>Command<cr>', desc = 'Description' },
  },
  opts = {  -- Simple config (passed to require('plugin').setup())
    option = value,
  },
  config = function()  -- Complex config (use instead of opts)
    local plugin = require 'plugin'
    plugin.setup { ... }
  end,
}
```

### Naming Conventions

- **Files:** `lowercase-with-hyphens.lua` (e.g., `typescript-tools.lua`, `auto-save.lua`)
- **Variables:** `snake_case` (e.g., `local lint_augroup`)
- **Functions:** `snake_case` (e.g., `local function create_note()`)
- **Constants:** `UPPER_SNAKE_CASE` (rare, prefer local variables)
- **Augroups:** `kebab-case` or `snake_case` (e.g., `'kickstart-lsp-attach'`, `'lint'`)

### Keymaps

**Always include descriptive `desc` for which-key integration:**

```lua
-- ✅ GOOD
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { 
  desc = '[S]earch [H]elp' 
})

-- ❌ BAD (missing desc)
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags)
```

**Mnemonic hints:** Use `[X]` brackets to highlight key letters:
- `[S]earch [H]elp` → `<leader>sh`
- `[G]oto [D]efinition` → `grd`
- `[T]oggle [D]iagnostics` → `<leader>td`

### Autocommands

**Always use augroups with `clear = true`:**

```lua
-- ✅ GOOD
local augroup = vim.api.nvim_create_augroup('my-feature', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  pattern = '*.go',
  callback = function()
    -- implementation
  end,
})

-- ❌ BAD (no augroup, can't be reloaded)
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function() ... end,
})
```

### Error Handling

```lua
-- ✅ Use pcall for operations that might fail
local ok, telescope = pcall(require, 'telescope')
if not ok then
  vim.notify('Telescope not found', vim.log.levels.ERROR)
  return
end

-- ✅ Validate client capabilities
if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
  -- enable feature
end
```

## File Organization

```
.
├── init.lua                      # Main config (1134 lines, monolithic but documented)
├── .stylua.toml                  # Formatter configuration
├── lazy-lock.json                # Plugin version lockfile (don't edit manually)
├── lua/
│   ├── kickstart/
│   │   ├── health.lua            # Health check implementation
│   │   └── plugins/              # Standard Kickstart plugins
│   └── custom/
│       └── plugins/              # User-added plugins (one per file)
├── lsp/                          # LSP-specific overrides (ts_ls.lua, denols.lua)
└── plugin/                       # Auto-loaded configs (terminal.lua)
```

**Rules:**
- Core options/keymaps/autocommands: `init.lua`
- New plugins: Add to `lua/custom/plugins/<plugin-name>.lua`
- LSP overrides: Add to `lsp/<server>.lua`
- Auto-loaded scripts: Add to `plugin/<feature>.lua`

## LSP Configuration

LSP servers are configured in `init.lua` (lines 723-771) via `mason-lspconfig`:

```lua
servers = {
  gopls = {},
  pyright = {},
  ts_ls = {},  -- TypeScript (requires package.json/tsconfig.json)
  denols = {},  -- Deno (requires deno.json/deno.jsonc)
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = 'Replace' },
      },
    },
  },
}
```

**LSP attach keybindings (via LspAttach autocommand):**
- `grn` - Rename
- `gra` - Code action
- `grr` - References
- `gri` - Implementation
- `grd` - Definition
- `grD` - Declaration
- `grt` - Type definition
- `gO` - Document symbols
- `gW` - Workspace symbols
- `<leader>td` - Toggle diagnostics
- `<leader>th` - Toggle inlay hints

## Formatting Configuration

**Tool:** `conform.nvim` (configured in `init.lua` lines 807-856)

**Formatters by language:**
- Lua: `stylua`
- Python: `isort`, `black`
- TypeScript/JavaScript: `prettierd` (with `prettier` fallback)
- Go: `goimports`, `gofumpt`
- JSON/HTML/CSS/Markdown: `prettierd`, `prettier`

**Format commands:**
- Auto-format on save (500ms timeout, with LSP fallback)
- Manual: `<leader>f` in normal/visual mode

## Important Conventions

### Comments
- Use `--` for single-line comments
- Use block comments for documentation: `--[[ ... ]]`
- Include "NOTE:", "WARN:", "TODO:" markers for visibility
- Document complex logic inline

### Dependencies
- External tools installed via Mason (`:Mason` to manage)
- Required external tools: `git`, `make`, `unzip`, `ripgrep`, C compiler

### Diagnostics
- Diagnostics use Nerd Font icons (requires `vim.g.have_nerd_font = true`)
- Severity sorting enabled
- Virtual text shows source when multiple sources exist
- Underline only for ERROR severity

### TypeScript/Deno Handling
- `ts_ls` and `denols` have mutual exclusion via `root_pattern`
- Both set `single_file_support = false` to prevent conflicts
- Alternative: `typescript-tools.nvim` (disabled if ts_ls enabled)

---

**Last Updated:** 2025-01-20  
**Neovim Version:** 0.11+  
**Plugin Manager:** Lazy.nvim
