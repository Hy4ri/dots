vim.pack.add({ "https://github.com/olimorris/codecompanion.nvim", "https://github.com/nvim-lua/plenary.nvim" })

require("codecompanion").setup({
	strategies = {
		chat = {
			adapter = "copilot",
			keymaps = {
				clear = {
					modes = { n = "gX" },
					description = "Clear chat",
				},
			},
		},
		inline = {
			adapter = "copilot",
			keymaps = {
				accept_change = {
					modes = { n = "<leader>ay" },
					description = "Accept the suggested change",
				},
				always_accept = {
					modes = { n = "<leader>aY" },
					description = "Accept and enable auto mode",
				},
				reject_change = {
					modes = { n = "<leader>an" },
					description = "Reject the suggested change",
				},
			},
		},
	},
})
