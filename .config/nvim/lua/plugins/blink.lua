vim.pack.add({ "https://github.com/saghen/blink.cmp" })
vim.pack.add({ "https://github.com/L3MON4D3/LuaSnip" })
vim.pack.add({ "https://github.com/rafamadriz/friendly-snippets" })
vim.pack.add({ "https://github.com/folke/lazydev.nvim" })

-- Load lazydev integration
require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})

-- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Setup blink.cmp
require("blink.cmp").setup({
	keymap = {
		preset = "super-tab",
	},
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = { auto_show = true },
		ghost_text = { enabled = vim.g.ai_cmp },
		list = {
			selection = { preselect = false, auto_insert = true },
			max_items = 10,
		},
		accept = {
			auto_brackets = {
				enabled = true,
			},
		},
		menu = {
			border = "bold",
			scrollbar = false,
			draw = {
				gap = 2,
				columns = {
					{ "kind_icon", "kind", gap = 1 },
					{ "label", "label_description", gap = 1 },
				},
			},
		},
	},
	sources = {
		default = { "lsp", "snippets", "path", "lazydev", "buffer" },
		providers = {
			lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
		},
	},
	snippets = { preset = "luasnip" },
	fuzzy = { implementation = "lua" },
	signature = { enabled = true },
	cmdline = { enabled = false },
})
