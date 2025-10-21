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
  { 
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        falvour = "mocha",
        transparent_background = true,
        auto_integrations = true,
      })
    end
  },
  { "ellisonleao/gruvbox.nvim",
    priority = 1000 ,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
      })
    end
  }
}

