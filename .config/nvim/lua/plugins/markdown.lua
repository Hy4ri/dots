return {
	{
		"iamcco/markdown-preview.nvim",
		event = Verylazy,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.defer_fn(function()
				vim.cmd("call mkdp#util#install()")
			end, 0)
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		event = Verylazy,
		opts = {},
	},
}
