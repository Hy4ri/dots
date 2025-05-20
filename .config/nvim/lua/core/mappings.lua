-- map leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local keymap = vim.keymap

-- arabic
keymap.set("n", "<leader>ar", function()
  if vim.opt.keymap:get() == "arabic" then
    vim.cmd("set noarabic")
  else
    vim.cmd("set arabic")
  end
end)

--Disable arrow keys in normal mode
keymap.set({ "n", "i" }, "<left>", '<cmd>echo "Use h to move!!"<CR>')
keymap.set({ "n", "i" }, "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap.set({ "n", "i" }, "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap.set({ "n", "i" }, "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Telescope
keymap.set("n", "<leader>sf", "<cmd> Telescope find_files <cr>")
keymap.set("n", "<leader>sg", "<cmd> Telescope live_grep <cr>")
keymap.set("n", "<leader>sh", "<cmd> Telescope help_tags  <cr>")
keymap.set("n", "<leader>sk", "<cmd> Telescope keymaps <cr>")
keymap.set("n", "<leader>sw", "<cmd> Telescope grep_string <cr>")
keymap.set("n", "<leader>so", "<cmd> Telescope oldfiles <cr>")
keymap.set("n", "<leader>sb", "<cmd>Telescope buffers<CR>")

-- oil
keymap.set("n", "<leader>e", "<cmd> Oil <cr>")

keymap.set("n", "<leader>fc", function()
  require("telescope.builtin").find_files({
    cwd = "~/.config/nvim/",
  })
end)

-- write
keymap.set("n", "<leader>w", "<cmd>w<CR>")

-- term
keymap.set("n", "<leader>t", "<cmd>split | terminal<CR>")

--  search replace
keymap.set("n", "<leader>r", ":%s/", { noremap = true })

-- quit
keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Keeping the cursor centered.
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Open the package manager.
keymap.set("n", "<leader>L", "<cmd>Lazy<cr>")

-- Switch between windows.
keymap.set("n", "<C-h>", "<C-w>h", { remap = true })
keymap.set("n", "<C-j>", "<C-w>j", { remap = true })
keymap.set("n", "<C-k>", "<C-w>k", { remap = true })
keymap.set("n", "<C-l>", "<C-w>l", { remap = true })

-- Poweful <esc>.
keymap.set({ "i", "s", "n" }, "<esc>", function()
  if require("luasnip").expand_or_jumpable() then
    require("luasnip").unlink_current()
  end
  vim.cmd("noh")
  return "<esc>"
end, { expr = true })

-- Make U opposite to u.
keymap.set("n", "U", "<C-r>")

-- commenting
keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })
