vim.pack.add({ "https://github.com/oskarnurm/koda.nvim" })
vim.pack.add({ "https://github.com/rebelot/kanagawa.nvim" })

require("koda").setup({
	italics = true,
	bold = true,
	colors = {
		bg = "#121212",
		fg = "#b0b0b0",
		line = "#272727",
		paren = "#4d4d4d",
		keyword = "#777777",
		dim = "#50585d",
		comment = "#50585d",
		border = "#ffffff",
		emphasis = "#ffffff",
		func = "#ffffff",
		string = "#e2e2e2",
		const = "#990000",
		highlight = "#770000",
		info = "#8ebeec",
		error = "#ff7676",
		success = "#A3BE8C",
		warning = "#EBCB8B",
		danger = "#BF616A",
	},
})

require("kanagawa").setup({
	transparent = true,
})

-- Apply theme
vim.cmd.colorscheme("koda")
