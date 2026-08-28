# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration using the built-in **vim.pack** plugin manager (Neovim 0.12+). All configuration is written in Lua.

## Architecture

- `init.lua` — Entry point. Loads core modules, collects plugin specs from `lua/plugins/*`, and registers them via `vim.pack.add()`. A `PackChanged` autocommand handles post-install builds (fff.nvim via nix, `:TSUpdate` for treesitter). Update plugins with `:lua vim.pack.update()`.
- `lua/options.lua` — Vim options (leader is Space, tabs=4 spaces, netrw disabled, shell=zsh).
- `lua/mappings.lua` — Global keymaps (`\` for NvimTree, `<leader>q` for diagnostics). Neovim window navigation, including NvimTree, uses `<C-h/j/k/l>`.
- `lua/autocommands.lua` — Autocommands including LSP-attach keymaps (all LSP goto/action bindings live here, using fzf-lua).
- `lua/theme_utils.lua` — Theme persistence system. Current theme is stored in `.nvim_theme` file; changed via `:Theme` command (triggers `:restart`).
- `lua/plugins/` — Each file returns a table with `specs` (list of plugin URLs/specs for vim.pack) and an optional `setup` function. `lua/plugins/unused/` contains disabled/experimental plugins.

## Key Design Decisions

- **Fuzzy finding is split**: `fff.nvim` handles file finding (`<leader>sf`) and grep (`<leader>sg`, `<leader>sw`, `<leader>sz`). `fzf-lua` handles LSP actions, diagnostics, help tags, theme picker, and `vim.ui.select` override.
- **LSP servers** are configured via `vim.lsp.enable()`/`vim.lsp.config()` (Neovim native, no mason). Configured servers: clangd, gopls, ty, ts_ls, html, cssls, eslint, jsonls, tailwindcss, nil_ls, terraformls, yamlls, lua_ls.
- **Completions** use `blink.cmp` (not nvim-cmp) with default keymap preset (C-y to accept).
- **Formatting** uses `conform.nvim` with format-on-save (disabled for C/C++). Formatters: nixfmt, stylua, ruff, prettierd/prettier, gofmt.
- **File explorers**: NvimTree (`\` to toggle) and Oil (`-` to open parent directory).
- **Colorscheme** is selectable at runtime via `:Theme` and persisted to `.nvim_theme`. Default is monokai-pro.
- **mini.nvim** provides: ai (textobjects), surround, icons (ascii style), clue (which-key replacement), statusline.
- **fff.nvim** is built via `nix run .#release`.

## Conventions

- Plugin specs are one-per-file in `lua/plugins/`, each returning `{ specs = {...}, setup = function() ... end }`.
- LSP keymaps are defined in the `LspAttach` autocommand in `lua/autocommands.lua`, not in `mappings.lua`.
- Lua formatting uses `stylua`. The `.luarc.json` registers `vim` as a global.
