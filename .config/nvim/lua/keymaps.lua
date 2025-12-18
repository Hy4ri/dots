local keymap = vim.keymap

-- stylua: ignore start

--leader Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Disable arrows
keymap.set({ "n", "i" }, "<left>", '<cmd>echo "Use h to move!!"<CR>')
keymap.set({ "n", "i" }, "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap.set({ "n", "i" }, "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap.set({ "n", "i" }, "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Navigate between splits using Ctrl + h/j/k/l
keymap.set("n", "<M-h>", "<C-w>h", { desc = "Move to left split" })
keymap.set("n", "<M-j>", "<C-w>j", { desc = "Move to lower split" })
keymap.set("n", "<M-k>", "<C-w>k", { desc = "Move to upper split" })
keymap.set("n", "<M-l>", "<C-w>l", { desc = "Move to right split" })

-- splits
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split Vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split Horizontally" })

-- Arabic Support
keymap.set("n", "<leader>ar", function()
	if vim.opt.keymap:get() == "arabic" then
		vim.cmd("set noarabic")
	else
		vim.cmd("set arabic")
	end
end)

-- Keeping the cursor centered.
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
keymap.set({"n","t"}, "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
keymap.set({"n","t"}, "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

-- Copy and paste
keymap.set("x", "p", "zp")
keymap.set("x", "y", "zy")
keymap.set("x", "P", "zP")
keymap.set("n", "yY", function()
	vim.fn.setreg("+", table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"))
end) -- copy all to clipboard

-- Search in selection
vim.keymap.set("c", "/", function()
	return vim.fn.getcmdtype():match("[/?]")
			and vim.fn.getcmdline() == ""
			and vim.api.nvim_replace_termcodes("<C-c><Esc>/\\%V", true, true, true)
		or "/"
end, { expr = true, desc = "Search within visual selection" })

-- Move highlighted text
keymap.set("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move highlighted text down", silent = true })
keymap.set("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move highlighted text up", silent = true })

-- Fix J cursor placment
keymap.set("n", "J", "mzJ`z")

--Snacks
-- keymap.set("n", "<leader>sp", function() Snacks.picker() end, { desc = "Pickers" })
-- keymap.set("n", "<leader>sb", function() Snacks.picker.buffers() end, { desc = "Buffer Picker" })
-- keymap.set("n", "<leader>sf", function() Snacks.picker.files() end, { desc = "Files Picker" })
-- keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep Pickers" })
-- keymap.set("n", "<leader>ss", function() Snacks.picker.spelling() end, { desc = "Spelling Pickers" })
-- keymap.set("n", "<leader>so", function() Snacks.picker.recent() end, { desc = "Recent files Pickers" })

-- Quicker options
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Write" })
keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })
keymap.set("n", "<leader>r", ":%s/", { noremap = true }, { desc = "Replace in file" })
keymap.set("x", "<leader>r", ":s/", { noremap = true }, { desc = "Replace in file" })
keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })
keymap.set("n", "U", "<C-r>", { desc = "Redo" })
keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { desc = "Executable script", silent = true })
keymap.set("n", "-", "<CMD>Yazi<CR>", { desc = "Open parent directory" })

-- terminal in a new buffer
keymap.set("n", "<leader>t",
function ()
    vim.cmd("enew")
    vim.cmd("terminal")
end
  , { desc = "Open parent directory" })

-- Toggle options
keymap.set("n", "<leader>uc", "<cmd>Copilot toggle<cr>", { desc = "toggle copilot" })
keymap.set("n", "<leader>ug", ":lua MiniDiff.toggle_overlay()<cr>", { desc = "Source Config" })
keymap.set("n", "<leader>ut", "<cmd>TransparentToggle<CR>", { desc = "Transparancy Toggle" })
keymap.set('n', '<leader>uw', ':set invwrap<CR>', { desc = 'Toggle Word Wrap' })
keymap.set('n', '<leader>ud', function()
    local is_enabled = vim.diagnostic.is_enabled()
    vim.diagnostic.enable(not is_enabled)
    local status = is_enabled and "Disabled" or "Enabled"
    vim.notify("Diagnostics " .. status, vim.log.levels.INFO)
end, { desc = 'Toggle All Diagnostics' })

-- stylua: ignore end
