return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	lazy = false,
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		-- 🛠 Warn if compilers are missing (for auto-install to succeed)
		if vim.fn.executable("gcc") == 0 or vim.fn.executable("make") == 0 then
			vim.schedule(function()
				vim.notify(
					"⚠️  Tree-sitter: Missing 'gcc' or 'make'. Auto-install may fail for some languages.\n install build-essential",
					vim.log.levels.WARN
				)
			end)
		end

		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"comment",
				"css",
				"diff",
				"html",
				"json",
				"lua",
				"luadoc",
				"make",
				"markdown",
				"markdown_inline",
				"php",
				"python",
				"toml",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			ignore_install = {},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
			},

			indent = {
				enable = true,
			},
		})
	end,
}
