vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

vim.cmd("packadd nvim-treesitter")

local ok, configs = pcall(require, "nvim-treesitter.configs")
if ok then
	configs.setup({
		ensure_installed = {
			"bash",
			"c",
			"cpp",
			"css",
			"go",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"rust",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		},
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
	})
else
	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			pcall(vim.treesitter.start)
		end,
	})
end
