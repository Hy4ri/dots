return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local function file_with_icon()
      local filename = vim.fn.expand("%:t")
      if filename == "" then
        return "[No Name]"
      end
      local ext = vim.fn.expand("%:e")
      local icon = require("nvim-web-devicons").get_icon(filename, ext, { default = true })
      return string.format("%s %s", icon, filename)
    end

    require("lualine").setup({
      options = {
        theme = "iceberg_dark",
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          { "branch", icon = "" },
          {
            "diff",
            symbols = { added = "+", modified = "~", removed = "-" },
            colored = true,
            diff_color = {
              added = { fg = "#A3BE8C" },
              modified = { fg = "#EBCB8B" },
              removed = { fg = "#BF616A" },
            },
          },
        },
        lualine_c = {
          {
            file_with_icon,
            file_status = true,
            path = 0,
            symbols = { modified = "●", readonly = "", unnamed = "[No Name]" },
          },
        },
        lualine_x = {},
        lualine_y = { "location" },
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { file_with_icon },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    })
  end,
}
