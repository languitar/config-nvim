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

require("lazy").setup({
	-- visual
	{
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				default = true,
				override = {
					Dockerfile = {
						icon = "",
						color = "#b8b5ff",
						name = "Dockerfile",
					},
				},
			})
		end,
	},
	{
		"hoob3rt/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = { theme = "tokyonight" },
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = { { "filename", file_status = true, path = 1 } },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { { "filename", file_status = true, path = 1 } },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},
	{
		"akinsho/nvim-bufferline.lua",
		versio = "*",
		config = function()
			require("bufferline").setup({
				options = {
					diagnostics = "nvim_lsp",
					offsets = {
						{ filetype = "NvimTree", text = "File Explorer", text_align = "center" },
						{ filetype = "undotree", text = "Undo Tree", text_align = "center" },
						{ filetype = "twiggy", text = "Git Branches", text_align = "center" },
					},
				},
			})
		end,
		dependencies = "kyazdani42/nvim-web-devicons",
	},
	{
		"folke/tokyonight.nvim",
		config = function()
			vim.g.tokyonight_style = "night"
			vim.g.tokyonight_italic_keywords = false
			vim.g.tokyonight_colors = {
				border = "#333333",
			}
			vim.g.tokyonight_sidebars = { "qf", "undotree", "NvimTree", "twiggy" }
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
		event = "BufReadPre",
	},
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				plugins = {
					spelling = {
						enabled = true,
						suggestions = 20,
					},
				},
			})
		end,
	},
	{
		"anuvyklack/pretty-fold.nvim",
		config = function()
			require("pretty-fold").setup({})
			require("fold-preview").setup()
		end,
		dependencies = { "anuvyklack/nvim-keymap-amend", "anuvyklack/fold-preview.nvim" },
	},

	-- utilities
	{
		"gelguy/wilder.nvim",
		config = function()
			local wilder = require("wilder")
			wilder.setup({ modes = { ":", "/", "?" } })
			-- Disable Python remote plugin
			wilder.set_option("use_python_remote_plugin", 0)

			wilder.set_option("pipeline", {
				wilder.branch(
					wilder.cmdline_pipeline({
						fuzzy = 1,
						fuzzy_filter = wilder.lua_fzy_filter(),
					}),
					wilder.vim_search_pipeline()
				),
			})

			wilder.set_option(
				"renderer",
				wilder.renderer_mux({
					[":"] = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
						border = "rounded",
						highlighter = wilder.lua_fzy_highlighter(),
						left = {
							" ",
							wilder.popupmenu_devicons(),
						},
						right = {
							" ",
							wilder.popupmenu_scrollbar(),
						},
						highlights = {
							accent = wilder.make_hl(
								"WilderAccent",
								"Pmenu",
								{ { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }
							),
						},
					})),
					["/"] = wilder.wildmenu_renderer({
						highlighter = wilder.lua_fzy_highlighter(),
						highlights = {
							accent = wilder.make_hl(
								"WilderAccent",
								"Pmenu",
								{ { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }
							),
						},
					}),
				})
			)
		end,
		dependencies = { "romgrk/fzy-lua-native" },
	},
	{
		"glts/vim-textobj-comment",
		dependencies = { "kana/vim-textobj-user" },
	},
	"michaeljsmith/vim-indent-object",
	{
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				view = {
					width = 30,
					side = "left",
				},
				filters = {
					dotfiles = true,
					custom = { "^\\.git$", "^node_modules$", "^\\.cache$", "^__pycache__$" },
				},
				git = {
					ignore = true,
				},
				renderer = {
					highlight_git = true,
					icons = {
						glyphs = {
							default = "",
							symlink = "",
							git = {
								unstaged = "✗",
								staged = "✓",
								unmerged = "",
								renamed = "➜",
								untracked = "★",
								ignored = "◌",
								deleted = "",
							},
							folder = {
								arrow_closed = "",
								arrow_open = "",
								default = "",
								open = "",
								empty = "",
								empty_open = "",
								symlink = "",
								symlink_open = "",
							},
						},
					},
					special_files = {},
				},
				actions = {
					open_file = {
						resize_window = false,
					},
				},
			})
		end,
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},
	"mbbill/undotree",
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"nmac427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				enabled = false,
			})
		end,
	},
	"ojroques/nvim-bufdel",
	"tpope/vim-eunuch",
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	"AndrewRadev/splitjoin.vim",
	{
		"ggandor/lightspeed.nvim",
		config = function()
			require("lightspeed").setup({
				limit_ft_matches = 20,
			})
			local wk = require("which-key")
			wk.register({
				s = "Lightspeed forward",
				S = "Lightspeed backwards",
			})
		end,
		dependencies = "folke/which-key.nvim",
	},
	"editorconfig/editorconfig-vim",
	"tpope/vim-repeat",
	"vim-scripts/visualrepeat",
	"wellle/targets.vim",

	-- general language support
	"vigoux/LanguageTool.nvim",
	"Vimjas/vim-python-pep8-indent",
	"bps/vim-textobj-python",
	{
		"Rykka/riv.vim",
		config = function()
			vim.g.riv_fold_auto_update = 0
		end,
		ft = "rst",
	},
	"jamessan/vim-gnupg",
	"chrisbra/csv.vim",
	"vim-scripts/icalendar.vim",
	"neo4j-contrib/cypher-vim-syntax",
	"rasjani/robotframework-vim",
	"towolf/vim-helm",
	"gurpreetatwal/vim-avro",
	{ "stsewd/sphinx.nvim", run = ":UpdateRemotePlugins" },

	-- IDE-like features
	"rafamadriz/friendly-snippets",
	{
		"L3MON4D3/LuaSnip",
		dependencies = "rafamadriz/friendly-snippets",
		config = function()
			local ls = require("luasnip")
			-- some shorthands...
			local s = ls.snippet
			local sn = ls.snippet_node
			local t = ls.text_node
			local i = ls.insert_node
			local f = ls.function_node
			local c = ls.choice_node
			local d = ls.dynamic_node
			local l = require("luasnip.extras").lambda
			local r = require("luasnip.extras").rep
			local p = require("luasnip.extras").partial
			local m = require("luasnip.extras").match
			local n = require("luasnip.extras").nonempty
			local dl = require("luasnip.extras").dynamic_lambda
			local types = require("luasnip.util.types")

			ls.config.set_config({
				ext_opts = {
					[types.choiceNode] = {
						active = {
							virt_text = { { "choiceNode", "Comment" } },
						},
					},
				},
				-- treesitter-hl has 100, use something higher (default is 200).
				ext_base_prio = 300,
				-- minimal increase in priority.
				ext_prio_increase = 1,
			})

			ls.add_snippets("all", {
				s("uuid", {
					f(function()
						local random = math.random
						local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
						local out
						local function subs(char)
							local v = (((char == "x") and random(0, 15)) or random(8, 11))
							return string.format("%x", v)
						end

						out = template:gsub("[xy]", subs)
						return out
					end, {}),
				}),
				s("isodate", {
					f(function()
						return os.date("!%Y%m%dT%H%M%SZ")
					end, {}),
				}),
				s("timestamp", {
					f(function()
						return tostring(os.time(os.date("!*t")))
					end, {}),
				}),
			})

			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })

			local t = function(str)
				return vim.api.nvim_replace_termcodes(str, true, true, true)
			end

			_G.snip_jump_next = function()
				if ls.jumpable(1) then
					return t("<Plug>luasnip-jump-next")
				else
					return t("<C-j>")
				end
			end
			_G.snip_jump_prev = function()
				if ls.jumpable(-1) then
					return t("<Plug>luasnip-jump-prev")
				else
					return t("<C-k>")
				end
			end

			_G.snip_expand = function()
				if ls.expandable() then
					return t("<Plug>luasnip-expand-snippet")
				else
					return t("<Tab>")
				end
			end

			vim.api.nvim_set_keymap("i", "<C-j>", "v:lua.snip_jump_next()", { expr = true })
			vim.api.nvim_set_keymap("s", "<C-j>", "v:lua.snip_jump_next()", { expr = true })
			vim.api.nvim_set_keymap("i", "<C-k>", "v:lua.snip_jump_prev()", { expr = true })
			vim.api.nvim_set_keymap("s", "<C-k>", "v:lua.snip_jump_prev()", { expr = true })
			vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.snip_expand()", { expr = true })
			vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.snip_expand()", { expr = true })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				highlight = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "g.",
						node_incremental = ".",
						scope_incremental = ";",
						node_decremental = ",",
					},
				},
			})
			local wk = require("which-key")
			wk.register({
				["."] = "Start incremental selection",
			}, { prefix = "g" })

			-- use treesitter for folding
			-- vim.wo.foldmethod = 'expr'
			-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
			-- vim.wo.foldlevel = 1
		end,
		dependencies = "folke/which-key.nvim",
	},
	{
		"David-Kunz/treesitter-unit",
		config = function()
			vim.api.nvim_set_keymap(
				"x",
				"iu",
				':lua require"treesitter-unit".select()<CR>',
				{ noremap = true, desc = "treesitter unit" }
			)
			vim.api.nvim_set_keymap(
				"x",
				"au",
				':lua require"treesitter-unit".select(true)<CR>',
				{ noremap = true, desc = "treesitter unit" }
			)
			vim.api.nvim_set_keymap(
				"o",
				"iu",
				':<c-u>lua require"treesitter-unit".select()<CR>',
				{ noremap = true, desc = "treesitter unit" }
			)
			vim.api.nvim_set_keymap(
				"o",
				"au",
				':<c-u>lua require"treesitter-unit".select(true)<CR>',
				{ noremap = true, desc = "treesitter unit" }
			)
		end,
	},
	"b0o/schemastore.nvim",
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"dockerls",
					"html",
					"jsonls",
					"jdtls",
					"tsserver",
					"lua_ls",
					"pyright",
					"vale_ls",
				},
				automatic_installation = true,
			})
		end,
		dependencies = "williamboman/mason.nvim",
	},
	"neovim/nvim-lspconfig",
	{
		"j-hui/fidget.nvim",
		branch = "legacy",
		config = function()
			require("fidget").setup()
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({})
		end,
	},
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({})
		end,
		dependencies = { "kyazdani42/nvim-web-devicons" },
		cmd = { "Trouble", "TroubeToggle" },
	},
	{
		"kosayoda/nvim-lightbulb",
		config = function()
			-- show lightbulbs for code actions
			vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "emoji" },
					{ name = "nvim_lua" },
					{
						name = "buffer",
						options = {
							keyword_pattern = [[\k\+]],
						},
					},
				},
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
					}),
				},
			})
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
		},
	},

	"simrat39/symbols-outline.nvim",
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					file_sorter = require("telescope.sorters").get_fzy_sorter,
				},
				extensions = {
					bibtex = {
						format = "markdown",
						global_files = { "/home/languitar/Nextcloud/notes/zotero.bib" },
					},
				},
				pickers = {
					live_grep = {
						additional_args = function(opts)
							return { "--hidden", "--glob", "!.git/" }
						end,
					},
				},
			})
			telescope.load_extension("bibtex")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-bibtex.nvim",
		},
	},
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				select = {
					backend = { "telescope" },
				},
			})
		end,
		event = "VeryLazy",
	},
	{
		"KabbAmine/zeavim.vim",
		config = function()
			vim.g.zv_file_types = { py = "python" }
		end,
	},
	{
		"janko-m/vim-test",
		config = function()
			vim.g["test#strategy"] = "neovim"
		end,
	},
	{
		"andythigpen/nvim-coverage",
		config = function()
			require("coverage").setup()
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"mfussenegger/nvim-dap",
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
		dependencies = { "nvim-treesitter/nvim-treesitter", "mfussenegger/nvim-dap" },
	},
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			local dap = require("dap-python")
			dap.setup("/usr/bin/python3")
			dap.test_runner = "pytest"
		end,
		dependencies = { "mfussenegger/nvim-dap" },
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		config = function()
			require("telescope").load_extension("dap")
		end,
		dependencies = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
	},

	{
		"mickael-menu/zk-nvim",
		config = function()
			require("zk").setup({
				picker = "telescope",
			})
			require("telescope").load_extension("zk")
		end,
		dependencies = { "nvim-telescope/telescope.nvim" },
	},

	-- SCMs
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"folke/which-key.nvim",
		},
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local wk = require("which-key")
					wk.register({
						g = {
							s = { [[<cmd>lua require"gitsigns".stage_hunk()<CR>]], "Stage hunk" },
							u = { [[<cmd>lua require"gitsigns".undo_stage_hunk()<CR>]], "Undo stage hunk" },
							p = { [[<cmd>lua require"gitsigns".preview_hunk()<CR>]], "Preview hunk" },
							r = { [[<cmd>lua require"gitsigns".reset_hunk()<CR>]], "Rest hunk" },
							d = { [[<cmd>Gitsigns toggle_deleted<CR>]], "Toggle deleted lines" },
						},
					}, { prefix = "<leader>", buffer = bufnr })
					wk.register({
						c = { [[<cmd>Gitsigns next_hunk<CR>]], "Next hunk" },
					}, { prefix = "]", buffer = bufnr })
					wk.register({
						c = { [[<cmd>Gitsigns prev_hunk<CR>]], "Next hunk" },
					}, { prefix = "[", buffer = bufnr })
				end,
			})
		end,
	},
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"shumphrey/fugitive-gitlab.vim",
	{
		"linrongbin16/gitlinker.nvim",
		config = function()
			require("gitlinker").setup()
		end,
	},
	"sodapopcan/vim-twiggy",
	"rbong/vim-flog",
	"rhysd/git-messenger.vim",
})
