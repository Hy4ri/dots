return {
  {
    "ficcdaf/ashen.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
  },
  { 
    'datsfilipe/vesper.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('vesper').setup({
        transparent = true,
      })
    end
  },
  {
    "tiagovla/tokyodark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = true,
    },
  },
}

