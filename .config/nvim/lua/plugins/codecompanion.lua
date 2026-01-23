vim.pack.add({ "https://github.com/olimorris/codecompanion.nvim", "https://github.com/nvim-lua/plenary.nvim" })

-- Defer setup until first use
local setup_done = false
local function ensure_setup()
	if setup_done then
		return
	end
	setup_done = true
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
end

-- Setup on first command use
vim.api.nvim_create_autocmd("CmdUndefined", {
	pattern = "CodeCompanion*",
	once = true,
	callback = ensure_setup,
})
