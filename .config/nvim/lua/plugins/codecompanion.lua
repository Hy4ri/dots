vim.pack.add({ "https://github.com/olimorris/codecompanion.nvim" })
vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })

require("codecompanion").setup({
	strategies = {
		chat = {
			adapter = "gemini_cli",
			keymaps = {
				clear = {
					modes = { n = "gX" },
					description = "Clear chat",
				},
			},
		},
		inline = {
			adapter = "gemini_cli",
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

-- Keymaps
vim.keymap.set("n", "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle CodeCompanion chat" })
vim.keymap.set("x", "<leader>aa", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add to CodeCompanion chat" })