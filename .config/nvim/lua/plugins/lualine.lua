return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    ---------------------------------------------------------------------
    -- Custom lualine theme (edit colors here)
    ---------------------------------------------------------------------
    local theme = {
      normal = {
        a = { fg = "#121212", bg = "#990000", gui = "bold" },
        b = { fg = "#c2c2c2", bg = "#222222" },
        c = { fg = "#b2b2b2", bg = "#121212" },
      },
      insert = {
        a = { fg = "#e2e2e2", bg = "#990000", gui = "bold" },
        b = { fg = "#c2c2c2", bg = "#222222" },
        c = { fg = "#b2b2b2", bg = "#121212" },
      },
      visual = {
        a = { fg = "#990000", bg = "#121212", gui = "bold" },
        b = { fg = "#c2c2c2", bg = "#222222" },
        c = { fg = "#b2b2b2", bg = "#121212" },
      },
      replace = {
        a = { fg = "#121212", bg = "#990000", gui = "bold" },
        b = { fg = "#c2c2c2", bg = "#222222" },
        c = { fg = "#b2b2b2", bg = "#121212" },
      },
    }

    ---------------------------------------------------------------------
    -- Function: Display current file with icon
    ---------------------------------------------------------------------
    local function file_with_icon()
      local filename = vim.fn.expand("%:t")
      if filename == "" then
        return "[No Name]"
      end
      local ext = vim.fn.expand("%:e")
      local icon = require("nvim-web-devicons").get_icon(filename, ext, { default = true })
      return string.format("%s %s", icon, filename)
    end

    ---------------------------------------------------------------------
    -- Function: Show current search count (e.g., 2/5) only while searching
    ---------------------------------------------------------------------
    local function search_count()
      local search_pat = vim.fn.getreg("/")
      if search_pat == "" then
        return ""
      end
      if vim.v.hlsearch == 0 then
        return ""
      end
      local sc = vim.fn.searchcount({ maxcount = 0 })
      if sc.total == 0 then
        return ""
      end
      return string.format("%d/%d", sc.current, sc.total)
    end

    ---------------------------------------------------------------------
    -- Function: Show active LSP client name (e.g., "lua_ls")
    ---------------------------------------------------------------------
    local function lsp_client()
      local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then
        return "" -- Hide when no LSP attached
      end
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          return "" .. client.name
        end
      end
      return "" -- Hide if no LSP supports this filetype
    end

    ---------------------------------------------------------------------
    -- Function: Display current time (HH:MM)
    ---------------------------------------------------------------------
    local function clock()
      return os.date("%I:%M")
    end

    ---------------------------------------------------------------------
    -- Function: Show macro recording status (e.g., " q")
    ---------------------------------------------------------------------
    local function recording_macro()
      local reg = vim.fn.reg_recording()
      if reg == "" then
        return ""
      end
      return " @" .. reg
    end

    ---------------------------------------------------------------------
    -- Lualine setup
    ---------------------------------------------------------------------
    require("lualine").setup({
      options = {
        theme = theme,
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },

      -------------------------------------------------------------------
      -- Active sections layout
      -------------------------------------------------------------------
      sections = {
        -- Left side
        lualine_a = { "mode" }, -- Show current mode (e.g., NORMAL, INSERT)
        lualine_b = {
          {
            file_with_icon, -- Current file with icon
            file_status = true,
            path = 0,
            symbols = { modified = "●", readonly = "", unnamed = "[No Name]" },
          },
          { search_count }, -- Dynamic search counter
        },
        lualine_c = {
          { "branch", icon = "" }, -- Git branch
          {
            "diff", -- Show added/modified/removed lines from Git
            symbols = { added = "+", modified = "~", removed = "-" },
            diff_color = {
              added = { fg = "#A3BE8C" },
              modified = { fg = "#EBCB8B" },
              removed = { fg = "#BF616A" },
            },
          },
        },

        -- Right side
        lualine_x = {
          {
            "diagnostics", -- LSP diagnostics (errors, warnings, etc.)
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
            colored = true,
          },
          {
            lsp_client, -- Active LSP client name
          },
          {
            recording_macro, -- Macro recording indicator
            color = { fg = "#BF616A", gui = "bold" }, -- Red + bold when active
          },
          { "fileformat" }, -- File format (unix/dos)
        },
        lualine_y = {
          { "location" }, -- Cursor position (line:column)
        },
        lualine_z = {
          {
            clock, -- Current time
          },
        },
      },

      -------------------------------------------------------------------
      -- Inactive window sections (minimal)
      -------------------------------------------------------------------
      inactive_sections = {
        lualine_a = {},
        lualine_b = { file_with_icon },
        lualine_c = {},
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },

      -------------------------------------------------------------------
      -- No tabline or extensions used
      -------------------------------------------------------------------
      tabline = {},
      extensions = {},
    })

    ---------------------------------------------------------------------
    -- Auto-update the macro indicator
    ---------------------------------------------------------------------
    vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
      callback = function()
        vim.defer_fn(function()
          require("lualine").refresh({ place = { "statusline" } })
        end, 50)
      end,
    })
  end,
}
