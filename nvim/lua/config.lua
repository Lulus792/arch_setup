-- Basic settings to get started
vim.o.number = true
vim.o.relativenumber = false 
vim.o.termguicolors = true
vim.o.mouse = 'a'
vim.o.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

----------------------------------------------------
-- AUTO FORMAT PYTHON ON SAVE
----------------------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.py",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

return {}
