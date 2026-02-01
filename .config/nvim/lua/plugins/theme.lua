vim.pack.add({ "https://github.com/oskarnurm/koda.nvim" })

require("koda").setup({
	transparent = false,
	auto = true,
	cache = true,

	styles = {
		functions = { bold = true, italic = true },
		keywords = { bold = false, italic = false },
		comments = { bold = true, italic = true },
		strings = { bold = true, italic = false },
		constants = { bold = true, italic = false },
	},

	-- Override colors
	colors = {
		bg = "#121212",
		dim = "#222222",
		string = "#e2e2e2",
		const = "#990000",
		highlight = "#770000",
		success = "#A3BE8C",
		warning = "#EBCB8B",
		danger = "#BF616A",
	},
})

vim.cmd.colorscheme("koda")
