vim.pack.add({ "https://github.com/folke/trouble.nvim" })

require("trouble").setup({})

-- Keymaps
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
-- stylua: ignore
vim.keymap.set( "n", "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
