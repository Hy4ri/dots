vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })
vim.pack.add({ "https://github.com/copilotlsp-nvim/copilot-lsp" })

require("copilot").setup({
	panel = {
		enabled = false,
	},
	suggestion = {
		auto_trigger = false,
		hide_during_completion = false,
		keymap = {
			-- accept_line = "<M-y>",
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
	},
	nes = {
		enabled = true,
		auto_trigger = true,
		keymap = {
			accept = "<M-y>",
			dismiss = "<C-[>",
		},
	},
	workspace_folders = { "~/Documents/Projects" },
	disable_limit_reached_message = false,
})
