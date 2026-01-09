vim.pack.add({ "https://github.com/mikavilpas/yazi.nvim" })
vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })

vim.g.loaded_netrwPlugin = 1

require("yazi").setup({
	open_for_directories = true,
})
