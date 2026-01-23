vim.pack.add({ "https://github.com/stevearc/conform.nvim", "https://github.com/williamboman/mason.nvim" })

-- Pre-config command
vim.api.nvim_create_user_command("ConformInfo", function()
	require("conform").format()
end, {})

require("conform").setup({
	notify_on_error = false,
	formatters = {
		alejandra = {
			command = vim.fn.exepath("alejandra"),
		},
	},
	format_on_save = function(bufnr)
		local disable_filetypes = { c = true, cpp = true }
		if disable_filetypes[vim.bo[bufnr].filetype] then
			return nil
		else
			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		end
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		sh = { "shfmt" },
		python = { "black" },
		javascript = { "prettier" },
		nix = { "alejandra" },
		scss = { "prettier" },
		css = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		markdown = { "prettier" },
		go = { "gofumpt" },
		["_"] = { "trim_whitespace", "trim_newlines" },
	},
})
