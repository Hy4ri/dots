return {
	{
		"nvim-mini/mini.comment",
		version = "*",
		config = function()
			require("mini.comment").setup()
		end,
	},
	{
		"nvim-mini/mini.surround",
		version = "*",
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		"nvim-mini/mini.cmdline",
		version = "*",
		config = function()
			require("mini.cmdline").setup({
				autocomplete = {
					enable = true,
				},
				autocorrect = {
					enable = true,
				},
				autopeek = {
					enable = true,
					n_context = 1,
				},
			})
		end,
	},
	{
		"nvim-mini/mini.extra",
		version = "*",
		config = function()
			require("mini.extra").setup()
		end,
	},
	{
		"nvim-mini/mini.hipatterns",
		version = "*",
		config = function()
			local hipatterns = require("mini.hipatterns")
			local hi_words = require("mini.extra").gen_highlighter.words
			require("mini.hipatterns").setup({
				highlighters = {
					todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
					fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
					note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),
					hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
					warn = hi_words({ "WARN", "Warn", "warn" }, "MiniHipatternsHack"),

					hex_color = hipatterns.gen_highlighter.hex_color(),
					rgb_color = {
						pattern = "rgb%(%d+,%s*%d+,%s*%d+%)",
						group = function(_, match)
							local r, g, b = match:match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
							local hex = string.format("#%02x%02x%02x", r, g, b)
							return hipatterns.compute_hex_color_group(hex, "bg")
						end,
					},
				},
			})
		end,
	},
	{
		"nvim-mini/mini.icons",
		version = "*",
		config = function()
			require("mini.icons").setup()
		end,
	},
	{
		"nvim-mini/mini.indentscope",
		version = "*",
		config = function()
			require("mini.indentscope").setup({
				draw = { animation = nil, priority = 5, delay = 0 },
				symbol = "│",
			})
		end,
	},
	{
		"nvim-mini/mini.notify",
		version = "*",
		config = function()
			require("mini.notify").setup()
			vim.notify = require("mini.notify").make_notify()
		end,
	},
	{
		"nvim-mini/mini.jump",
		version = "*",
		config = function()
			require("mini.jump").setup()
		end,
	},
	{
		"nvim-mini/mini.misc",
		version = "*",
		config = function()
			require("mini.misc").setup({
				make_global = { "setup_termbg_sync" },
			})
			require("mini.misc").setup_termbg_sync()
			-- require("mini.misc").setup_auto_root()
		end,
	},
}
