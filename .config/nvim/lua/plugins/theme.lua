vim.pack.add({ "https://github.com/oskarnurm/koda.nvim" })

require("koda").setup({
  transparent = true,
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
    const = "#990000",
  },
})

vim.cmd.colorscheme("koda")
