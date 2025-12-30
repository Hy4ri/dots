return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("render-markdown").setup({
			render_modes = { "n", "no", "c", "t", "i", "ic" },
			checkbox = {
				enable = true,
				position = "inline",
			},
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
	end,
}
