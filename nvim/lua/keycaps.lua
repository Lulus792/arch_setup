-- keycaps.lua - Full keybinds for your entire Neovim setup
-- Make sure in your init.lua you load this file with:
-- require("keycaps")

-- Set leader key
vim.g.mapleader = " "
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

---------------------------------------------------------------------
-- FILE EXPLORER (Neo-tree)
---------------------------------------------------------------------
map("n", "<leader>e", ":Neotree toggle<CR>", opts)         -- Toggle neo-tree
map("n", "<leader>r", ":Neotree reveal<CR>", opts)        -- Reveal current file

---------------------------------------------------------------------
-- TELESCOPE
---------------------------------------------------------------------
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)  -- Find files
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)   -- Live grep
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)      -- Buffers list
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)    -- Help search
map("n", "<leader>fa", ":Telescope builtin<CR>", opts)       -- All pickers

---------------------------------------------------------------------
-- BUFFERLINE
---------------------------------------------------------------------
map("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
map("n", "<leader>x", ":bdelete<CR>", opts)                -- Close buffer
map("n", "<leader>bp", ":BufferLinePick<CR>", opts)        -- Pick buffer

---------------------------------------------------------------------
-- LSP (Language Server Protocol)
---------------------------------------------------------------------
--map("n", "K", vim.lsp.buf.hover, opts)                        -- Hover docs
--map("n", "gd", vim.lsp.buf.definition, opts)                 -- Go to definition
--map("n", "gi", vim.lsp.buf.implementation, opts)             -- Implementation
--map("n", "gr", vim.lsp.buf.references, opts)                 -- References
--map("n", "<leader>rn", vim.lsp.buf.rename, opts)             -- Rename symbol
--map("n", "<leader>ca", vim.lsp.buf.code_action, opts)         -- Code action
--map("n", "<leader>f", function()
--  vim.lsp.buf.format({ async = true })
--end, opts)

---------------------------------------------------------------------
-- FOLDING (nvim-ufo)
---------------------------------------------------------------------
map("n", "<leader>fo", function() require("ufo").openAllFolds() end, opts)
map("n", "<leader>fc", function() require("ufo").closeAllFolds() end, opts)
map("n", "<leader>ft", "<leader>ft", opts) -- toggle fold

---------------------------------------------------------------------
-- DEBUGGING (nvim-dap)
---------------------------------------------------------------------
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, opts)
map("n", "<leader>ds", function() require("dap").continue() end, opts)
map("n", "<leader>di", function() require("dap").step_into() end, opts)
map("n", "<leader>dO", function() require("dap").step_over() end, opts)
map("n", "<leader>do", function() require("dap").step_out() end, opts)
map("n", "<leader>du", function() require("dapui").toggle() end, opts)

---------------------------------------------------------------------
-- TROUBLE
---------------------------------------------------------------------
map("n", "<leader>tt", ":TroubleToggle<CR>", opts)          -- Toggle main trouble view
map("n", "<leader>tw", ":Trouble diagnostics<CR>", opts)
map("n", "<leader>td", ":Trouble diagnostics document<CR>", opts)
map("n", "<leader>tr", ":Trouble lsp_references<CR>", opts)
map("n", "<leader>tq", ":Trouble qflist<CR>", opts)

---------------------------------------------------------------------
-- GLOBAL NOTE (global-note.nvim)
---------------------------------------------------------------------
-- Default commands:
--   :GlobalNote       -> Opens the global note
--   :GlobalNoteClear  -> Clears content
--   :GlobalNoteToggle -> Toggles

map("n", "<leader>gn", ":GlobalNote<CR>", opts)           -- Open global note

---------------------------------------------------------------------
-- QUALITY OF LIFE
---------------------------------------------------------------------
map("n", "<leader>sv", ":Lazy reload<CR>", opts)         -- Reload config
-- map("n", "<leader>ev", ":edit $MYVIMRC<CR>", opts)           -- Edit config file


return {}
