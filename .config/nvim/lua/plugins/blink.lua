vim.pack.add({ "https://github.com/saghen/blink.cmp" })
vim.pack.add({ "https://github.com/L3MON4D3/LuaSnip" })
vim.pack.add({ "https://github.com/rafamadriz/friendly-snippets" })
vim.pack.add({ "https://github.com/folke/lazydev.nvim" })
vim.pack.add({ "https://github.com/saghen/blink.indent" })

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
	cmdline = { enabled = true },
	completion = {
		keyword = { range = "prefix" },
		trigger = { show_on_backspace = false },
		list = {
			max_items = 15,
			selection = { preselect = true, auto_insert = false },
		},
		accept = {
			dot_repeat = true,
			create_undo_point = true,
			auto_brackets = {
				enabled = true,
				default_brackets = { "(", ")" },
			},
		},
		menu = {
			enabled = true,
			border = "bold",
			winblend = 0, -- transparency
			scrollbar = false,
			auto_show = true,
			draw = {
				align_to = "cursor",
				padding = 2,
				gap = 2,
				columns = {
					{ "kind_icon", "kind", gap = 1 },
					{ "label", "label_description", gap = 1 },
				},
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = { border = "single", winblend = 25, scrollbar = false },
		},
		ghost_text = { enabled = false },
	},
	signature = { enabled = false },
	fuzzy = { implementation = "lua" },
	sources = {
		default = { "lsp", "snippets", "path", "lazydev", "buffer" },
		providers = {
			lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
		},
	},
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "Nerd Font mono",
	},
	snippets = { preset = "luasnip" },
})

-- Indent
require("blink.indent").setup({
	mappings = {
		enabled = false,
	},
	static = {
		enabled = true,
		char = "│",
		highlights = { "BlinkIndent" },
	},
	scope = {
		enabled = true,
		char = "│",
		priority = 1000,
		highlights = { "BlinkIndentScope" },
	},
})
