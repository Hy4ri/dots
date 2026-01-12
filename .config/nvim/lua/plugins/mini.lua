vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })

-- Surround
require("mini.surround").setup()

-- Cmdline
require("mini.cmdline").setup({
	autocomplete = { enable = false },
	autocorrect = { enable = true },
	autopeek = { enable = true, n_context = 1 },
})

-- Extra
require("mini.extra").setup()

-- HiPatterns
local hi_words = require("mini.extra").gen_highlighter.words
require("mini.hipatterns").setup({
	highlighters = {
		todo = hi_words({ "TODO" }, "MiniHipatternsTodo"),
		fixme = hi_words({ "FIXME" }, "MiniHipatternsFixme"),
		note = hi_words({ "NOTE" }, "MiniHipatternsNote"),
		hack = hi_words({ "HACK" }, "MiniHipatternsHack"),
		warn = hi_words({ "WARN" }, "MiniHipatternsHack"),
	},
})

-- Icons
require("mini.icons").setup()

-- Indent Scope
require("mini.indentscope").setup({
	draw = { animation = nil, priority = 5, delay = 0 },
	symbol = "│",
})

-- Notify
require("mini.notify").setup()
vim.notify = require("mini.notify").make_notify()

-- Jump
require("mini.jump").setup()

-- Misc
require("mini.misc").setup({
	make_global = { "setup_termbg_sync" },
})
require("mini.misc").setup_termbg_sync()
