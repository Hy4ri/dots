local map = vim.keymap.set

-- stylua: ignore start

--leader Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Disable arrows
map({ "n", "i" }, "<left>", '<cmd>echo "Use h to move!!"<CR>')
map({ "n", "i" }, "<right>", '<cmd>echo "Use l to move!!"<CR>')
map({ "n", "i" }, "<up>", '<cmd>echo "Use k to move!!"<CR>')
map({ "n", "i" }, "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Navigate between splits using Ctrl + h/j/k/l
map("n", "<M-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<M-j>", "<C-w>j", { desc = "Move to lower split" })
map("n", "<M-k>", "<C-w>k", { desc = "Move to upper split" })
map("n", "<M-l>", "<C-w>l", { desc = "Move to right split" })

-- splits
map("n", "<leader>sv", "<C-w>v", { desc = "Split Vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split Horizontally" })

-- Arabic Support
map("n", "<leader>ar", function()
	if vim.opt.keymap:get() == "arabic" then
		vim.cmd("set noarabic")
	else
		vim.cmd("set arabic")
	end
end)

-- Keeping the cursor centered.
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Powerful <esc>.
map({ "i", "s", "n" }, "<esc>", function()
	if require("luasnip").expand_or_jumpable() then
		require("luasnip").unlink_current()
	end
	vim.cmd("noh")
	return "<esc>"
end, { expr = true })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- buffers
map({"n","t"}, "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map({"n","t"}, "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
-- map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

-- Copy and paste
map("x", "p", "zp")
map("x", "y", "zy")
map("x", "P", "zP")
map("n", "yY", function()
	vim.fn.setreg("+", table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"))
end) -- copy all to clipboard

-- Search in selection
map("c", "/", function()
	return vim.fn.getcmdtype():match("[/?]")
			and vim.fn.getcmdline() == ""
			and vim.api.nvim_replace_termcodes("<C-c><Esc>/\\%V", true, true, true)
		or "/"
end, { expr = true, desc = "Search within visual selection" })

-- Move highlighted text
map("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move highlighted text down", silent = true })
map("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move highlighted text up", silent = true })
map("x", ">", ">gv", { desc = "Indent highlighted text right" })
map("x", "<", "<gv", { desc = "Indent highlighted text left" })

-- Fix J cursor placment
map("n", "J", "mzJ`z")

-- Picker
 map("n", "<leader>sp","<cmd>FzfLua builtin<cr>", { desc = "Pickers" })
 map("n", "<leader>sb", "<cmd>FzfLua buffers<cr>", { desc = "Buffer Picker" })
 map("n", "<leader>sf","<cmd>FzfLua files<cr>" , { desc = "Files Picker" })
 map("n", "<leader>sg", "<cmd>FzfLua live_grep_native<cr>", { desc = "Grep Pickers" })
 map("n", "<leader>ss", "<cmd>FzfLua spellcheck<cr>" , { desc = "Spelling Pickers" })

-- Quicker options
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Write" })
map("n", "<leader>q", "<cmd>bd<cr>", { desc = "Quit" })
map("n", "<leader>r", ":%s/", { noremap = true }, { desc = "Replace in file" })
map("x", "<leader>r", ":s/", { noremap = true }, { desc = "Replace in file" })
map("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "U", "<C-r>", { desc = "Redo" })
map("n", "<leader>X", "<cmd>!chmod +x %<CR>", { desc = "Executable script", silent = true })
map("n", "-", "<CMD>Yazi<CR>", { desc = "Open parent directory" })

-- terminal in a new buffer
map("n", "<leader>t",
function ()
    vim.cmd("enew")
    vim.cmd("terminal")
end
  , { desc = "Open parent directory" })

-- do math with bc on selected text
vim.keymap.set("v", "<Leader>b", function()
  local _, ls, cs = unpack(vim.fn.getpos("'<"))
  local _, le, ce = unpack(vim.fn.getpos("'>"))
  local lines = vim.api.nvim_buf_get_text(0, ls-1, cs-1, le-1, ce, {})
  local text = table.concat(lines, "\n")
  local output = vim.fn.system("echo '" .. text .. "' | bc -l"):gsub("\n", "")

  vim.api.nvim_buf_set_text(0, ls-1, cs-1, le-1, ce, {output})
end, { desc = "Calculate selection with bc" })

-- Toggle options
map("n", "<leader>uc", "<cmd>Copilot toggle<cr>", { desc = "toggle copilot" })
map("n", "<leader>ug", ":lua MiniDiff.toggle_overlay()<cr>", { desc = "Source Config" })
map("n", "<leader>ut", "<cmd>TransparentToggle<CR>", { desc = "Transparancy Toggle" })
map('n', '<leader>uw', ':set invwrap<CR>', { desc = 'Toggle Word Wrap' })
map('n', '<leader>ud', function()
    local is_enabled = vim.diagnostic.is_enabled()
    vim.diagnostic.enable(not is_enabled)
    local status = is_enabled and "Disabled" or "Enabled"
    vim.notify("Diagnostics " .. status, vim.log.levels.INFO)
end, { desc = 'Toggle All Diagnostics' })

-- stylua: ignore end
