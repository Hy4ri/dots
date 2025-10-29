return {
  {
    "hy4ri/m57.nvim",
    lazy = false,
    priority = 1000,
  },
  { 
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        transparent = true,
      })
    end
  },
}

