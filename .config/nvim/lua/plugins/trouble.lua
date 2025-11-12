return {
	"folke/trouble.nvim",
	event = "VeryLazy",
	opts = {},
	cmd = "Trouble",
	keys = {
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
	},
}
