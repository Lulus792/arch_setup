local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins here
require("lazy").setup({

	-- Colorscheme
	{
		"Mofiqul/vscode.nvim",
		config = function()
			vim.cmd.colorscheme("vscode")
		end,
	},

	-- Souround actions
  {
    "echasnovski/mini.surround",
    version = "*",
    config = function()
    require("mini.surround").setup({
      mappings = {
        add = "<leader>sa",
        delete = "<leader>sd",
        replace = "<leader>sc",
        find = "<leader>sf",
        find_left = "<leader>sF",
      },
    })
    end,
  },

	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup{}
		end,
	},

	

	-- Treesitter (syntax highlighting, better code understanding)
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup {
				highlight = { enable = true },
				indent = { enable = true },
			}
		end,
	},

	-- Formatter (using conform.nvim recommended, never and supports multiple formatters)
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
				},
        format_on_save = true,
			})
		end,
	},

	-- Bufferline (tabs/buffers display)
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup{}
		end,
	},

	-- LSP pictograms for completion
	"onsails/lspkind.nvim",

	-- Folding (UFO recommended, more advanced)
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldenable = true
			require("ufo").setup()
		end,
	},

	-- Illuminate (highlights other uses of word under cursor)
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure{}
		end,
	},

	-- AI sidekick & csvview (both from folke/sidekick.nvim)
	{
		"folke/sidekick.nvim",
		config = function()
			require("sidekick").setup{}
		end,
	},

	-- mini.nvim (contains lots of small utilities, can be enabled as needed)
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.comment").setup()
		end,
	},

	-- Global note-taking plugin (for noites across projects)
	{
		"backdround/global-note.nvim",
		config = function()
			require("global-note").setup({
				filename = "note.md",
				directory = vim.fn.stdpath("data") .. "/notes",
			})
		end,
	},

	-- LSP Config (manages language servers)
	--{
	--	"neovim/nvim-lspconfig",
	--	config = function()
	--		-- require("lspconfig").lua.ls.setup{}
	--		local lspconfig = require('lspconfig')
	--		lspconfig.pyright.setup{}
	--		lspconfig.clangd.setup{
	--			cmd = { "clangd", "--background-index" },
	--			filetypes = { "c", "cpp", "cc", "objc", "objcpp" },
	--			root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", "git"),
	--		}
	--	end,
	--},

	-- Telescope (fuzzy finder)
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup{}
		end,
	},

	-- Web dev icons (optional but good for UI)
	"nvim-tree/nvim-web-devicons",

	-- Statusline (lualine.nvim)
	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("lualine").setup{
				options = { theme = "vscode" },
			}
		end,
	},

	-- Git signs (shows git changes in sign column)
	"lewis6991/gitsigns.nvim",

	-- Completion engine (nvim-cmp and sources)
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				window = {
					completion = cmp.config.window.bordered({
						max_height = 10,
					}),
					documentation = cmp.config.window.bordered(),
				},

				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-Space>'] = cmp.mapping.complete(),
					['<TAB>'] = cmp.mapping.confirm({ select = true }),
					['<C-e>'] = cmp.mapping.close(),
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-p>'] = cmp.mapping.select_prev_item(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = require("lspkind").cmp_format({with_text = true, maxwidth = 50})
				},
			})
		end,
	},

	-- Mason for managing LSP, DAP, linters, formatters installation
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup{}
		end,
	},

	-- Trouble for diagnostics and erros UI
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup()
		end,
	},
	
	-- Debugger
	{
		"mfussenegger/nvim-dap",
		config = function()
			-- configure adapters and configurations for each language
			local dap = require("dap")

			-- Python
			dap.adapters.python = {
				type = 'executable',
				command = 'python',
				args = { 'm', 'debugpy.adapter' },
			}
			dap.configurations.python = {
				{
					type = 'python',
					request = 'launch',
					name = "Launch file",
					program = "${file}",
					pythonPath = function()
						return 'python'
					end,
				},
			}

      -- C/C++
      dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-vscode',
        name = "lldb"
      }
      dap.configurations.cc {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      }

      -- Use same config for C
      dap.configurations.c = dap.configurations.cc
		end,
	},

	-- Dapui
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio"
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			-- Auto open UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.close()
			end
			
			-- Auto close on end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_existed["dapui_config"] = function()
				dapui.close()
			end
		end,
	},

	-- UI Replacement with noice.nvim (improves messages and command UI)
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup{}
		end,
	},

	-- File explorer (neo-tree)
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup{}
		end,
	},

})

require("keycaps")
require("lsp")
require("config")

