local keymap = vim.keymap

--leader Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Disable arrows
keymap.set({ "n", "i" }, "<left>", '<cmd>echo "Use h to move!!"<CR>')
keymap.set({ "n", "i" }, "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap.set({ "n", "i" }, "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap.set({ "n", "i" }, "<down>", '<cmd>echo "Use j to move!!"<CR>')

--Arabic Support
keymap.set("n", "<leader>ar", function()
	if vim.opt.keymap:get() == "arabic" then
		vim.cmd("set noarabic")
	else
		vim.cmd("set arabic")
	end
end)

--Keeping the cursor centered.
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Powerful <esc>.
keymap.set({ "i", "s", "n" }, "<esc>", function()
	if require("luasnip").expand_or_jumpable() then
		require("luasnip").unlink_current()
	end
	vim.cmd("noh")
	return "<esc>"
end, { expr = true })

-- better up/down
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- buffers
keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

-- Fix paste and delete
keymap.set("x", "<leader>p", "\"_dP")

-- Move highlighted text
keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = "Move highlighted text down"})
keymap.set("v", "K", ":m '>-2<CR>gv=gv", {desc = "Move highlighted text up"})

-- Fix J cursor placment
keymap.set("n", "J", "mzJ`z")

--Snacks
-- stylua: ignore
keymap.set("n", "<leader>sp", function() Snacks.picker() end, { desc = "Pickers" })
-- stylua: ignore
keymap.set("n", "<leader>sb", function() Snacks.picker.buffers() end, { desc = "Buffer Picker" })
-- stylua: ignore
keymap.set("n", "<leader>sf", function() Snacks.picker.files() end, { desc = "Files Picker" })
-- stylua: ignore
keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep Pickers" })
-- stylua: ignore
keymap.set("n", "<leader>ss", function() Snacks.picker.spelling() end, { desc = "Spelling Pickers" })
-- stylua: ignore
keymap.set("n", "<leader>so", function() Snacks.picker.recent() end, { desc = "Recent files Pickers" })

-- Quicker options
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Write" })
keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })
keymap.set("n", "<leader>t", "<cmd>split | terminal<CR>", { desc = "Split Terminal" })
keymap.set("n", "<leader>r", ":%s/", { noremap = true }, { desc = "Replace in file" })
keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })
keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })
keymap.set("n", "U", "<C-r>", { desc = "Redo" })
keymap.set("n", "<leader>uc", "<cmd>copilot toggle<cr>", { desc = "toggle copilot" })
keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Executable script", silent = true})

