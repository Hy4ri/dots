return {
  {
    "hy4ri/m57.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "vague-theme/vague.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vague").setup({
        colors = {
          bg = "",
        },
      })
    end
  },
}

