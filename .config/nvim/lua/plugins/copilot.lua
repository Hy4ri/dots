return {
	"zbirenbaum/copilot.lua",
	event = "InsertEnter",
	cmd = "Copilot",
	dependencies = {
		"copilotlsp-nvim/copilot-lsp",
	},
	config = function()
		require("copilot").setup({
			panel = {
				enabled = false,
			},
			suggestion = {
				auto_trigger = true,
				hide_during_completion = false,
				keymap = {
					accept_line = "<M-y>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			nes = {
				enabled = false,
				auto_trigger = true,
				keymap = {
					accept = "<c-y>",
					dismiss = "<C-[>",
				},
			},
			workspace_folders = { "~/Documents/Projects" },
			copilot_model = "GPT-5.1-Codex",
			disable_limit_reached_message = false,
		})
	end,
}
