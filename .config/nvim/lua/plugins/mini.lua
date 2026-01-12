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

-- Icons
require("mini.icons").setup()

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
