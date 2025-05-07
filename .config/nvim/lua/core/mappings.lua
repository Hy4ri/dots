-- map leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local keymap = vim.keymap
local opts = { silent = true, noremap = true }

-- Clear highlights on search when pressing <Esc> in normal mode
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

--Disable arrow keys in normal mode
keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>', opts)
keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>', opts)
keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>', opts)
keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>', opts)

-- Telescope
keymap.set("n", "<leader>sf", "<cmd> Telescope find_files <cr>", opts)
keymap.set("n", "<leader>sg", "<cmd> Telescope live_grep <cr>", opts)
keymap.set("n", "<leader>sh", "<cmd> Telescope help_tags  <cr>", opts)
keymap.set('n', '<leader>sk', "<cmd> Telescope keymaps <cr>", opts)
keymap.set('n', '<leader>sw', "<cmd> Telescope grep_string <cr>", opts)
keymap.set('n', '<leader>so', "<cmd> Telescope oldfiles‎ <cr>", opts)

keymap.set("n", "<leader>fc", function()
	require("telescope.builtin").find_files({
		cwd = "~/.config/nvim/",
	})
end, opts)
