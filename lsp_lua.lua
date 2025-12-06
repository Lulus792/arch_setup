-- lsp.lua - Complete Neovim LSP setup using the modern vim.lsp.start API
-- This file automatically starts LSP servers for Python and C/C++ WITHOUT requiring
-- compile_commands.json or pyproject.toml unless your project actually uses them.
-- Put this file in: ~/.config/nvim/lua/lsp.lua
-- Then load it in init.lua using: require("lsp")

-------------------------------------------------------------------------------
-- UTIL: Smart Root Directory Finder
-------------------------------------------------------------------------------
local function find_root(markers)
  local path = vim.fs.find(markers, { upward = true })[1]
  return path and vim.fs.dirname(path) or vim.fn.getcwd()
end

-------------------------------------------------------------------------------
-- PYTHON LSP (pyright)
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.lsp.start({
      name = "pyright",
      cmd = { "pyright-langserver", "--stdio" },
      root_dir = find_root({ "pyproject.toml", "setup.py", "requirements.txt", ".git" }),
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    })
  end,
})

-------------------------------------------------------------------------------
-- C/C++ LSP (clangd)
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.lsp.start({
      name = "clangd",
      cmd = { "clangd", "--background-index" },
      root_dir = find_root({ "compile_commands.json", "compile_flags.txt", ".git" }),
      filetypes = { "c", "cpp" },
      capabilities = vim.lsp.protocol.make_client_capabilities(),
    })
  end,
})

-------------------------------------------------------------------------------
-- DIAGNOSTICS SIGN ICONS
-------------------------------------------------------------------------------
local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-------------------------------------------------------------------------------
-- LSP KEYBINDINGS (GLOBAL)
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    local map = vim.keymap.set

    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

return {}
