return {
  "github/copilot.vim",
  config = function()
    -- Disable the default <Tab> accept mapping so we can bind our own keys
    vim.g.copilot_no_tab_map = true

    -- Common opts for keymaps
    local opts = { noremap = true, silent = true }

    -- Insert mode mappings
    -- Accept next suggested word: Alt-w  (Meta-w)
    vim.keymap.set("i", "<M-w>", "<Plug>(copilot-accept-word)", opts)
    -- Accept entire suggested line: Alt-y  (Meta-y)
    vim.keymap.set("i", "<M-y>", "<Plug>(copilot-accept-line)", opts)

    -- Cycle suggestions: Alt-] = next, Alt-[ = previous
    vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", opts)
    vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", opts)

    -- Dismiss current suggestion (followed from docs)
    vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)", opts)

    -- Explicitly request a suggestion (if you want to trigger one manually)
    vim.keymap.set("i", "<M-\\>", "<Plug>(copilot-suggest)", opts)

    -- Visual polish: subtle suggestion highlight (adjust hex color as you like)
    vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#555555", ctermfg = 8, force = true })

  end,
}
