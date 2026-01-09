vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })
vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })

require("render-markdown").setup({
	render_modes = { "n", "no", "c", "t", "i", "ic" },
	checkbox = {
		-- enable = true, -- Deprecated/Removed option causing error
		-- position = "inline", -- Deprecated/Removed option causing error
		-- defaults are usually fine, or check docs.
		-- Replacing with valid config if known, otherwise commenting out to rely on defaults.
		enabled = true,
	},
	latex = { enabled = false }, -- Missing parser, disable to silence warning
	-- html = { enabled = false }, -- Keeping html enabled, will fix parser in treesitter
	-- yaml = { enabled = false }, -- Keep yaml, fix parser
	code = {
		sign = true,
		border = "thin",
		position = "right",
		width = "block",
		above = "▁",
		below = "▔",
		language_left = "█",
		language_right = "█",
		language_border = "▁",
		left_pad = 1,
		right_pad = 1,
	},
	heading = {
		width = "block",
		backgrounds = {
			"MiniStatusLineModeNormal",
			"MiniStatusLineModeInsert",
			"MiniStatusLineModeReplace",
			"MiniStatusLineModeVisual",
			"MiniStatusLineModeCommand",
			"MiniStatusLineModeOther",
		},
		sign = true,
		left_pad = 1,
		right_pad = 0,
		position = "right",
		icons = {
			"",
			"",
			"",
			"",
			"",
			"",
		},
	},
})
