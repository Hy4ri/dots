vim.pack.add({ "https://github.com/monaqa/dial.nvim" })

local augend = require("dial.augend")
require("dial.config").augends:register_group({
	default = {
		augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
		augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
		augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
		augend.constant.alias.bool, -- true <-> false
		augend.semver.alias.semver, -- semantic versioning (1.2.3, etc.)
	},
})

-- Keymaps
-- stylua: ignore start
vim.keymap.set("n", "<C-a>", function() return require("dial.map").inc_normal() end, { expr = true, desc = "Increment" })
vim.keymap.set("n", "<C-x>", function() return require("dial.map").dec_normal() end, { expr = true, desc = "Decrement" })
-- stylua: ignore stop
