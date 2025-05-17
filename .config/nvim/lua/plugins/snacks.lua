return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		animate = { enabled = false },
		bigfile = { enabled = true },
		git = { enabled = true },
		indent = { enabled = true },
		quickfile = { enabled = true },
		words = { enabled = true },
	},
}
