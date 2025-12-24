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
			root_dir = find_root({ "pyproject.toml", "setup.py", "main.py", ".git" }),
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
	pattern = { "c", "cc", "cpp" },
	callback = function()
		vim.lsp.start({
			name = "clangd",
			cmd = { "clangd", "--background-index" },
			root_dir = find_root({ "compile_command.json", "compile_flags", ".git" }),
			filetypes = { "c", "cc", "cpp" },
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
-- LSP KEYBINDS (GLOBAL)
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

