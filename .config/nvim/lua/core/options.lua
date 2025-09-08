local opt = vim.opt
local g = vim.g

-- Set to true if you have a Nerd Font installed and selected in the terminal
g.have_nerd_font = true

-- Snacks animations
-- Set to `false` to globally disable all snacks animations
g.snacks_animate = false

-- do shaping for Arabic characters
opt.arabicshape = true

-- enable system clipboard
opt.clipboard = "unnamedplus"

-- make 'autoindent' use existing indent structure
opt.copyindent = true

-- (optional) cursorline has no effect if transparent.nvim is enable
opt.cursorline = true

-- global statusline
opt.laststatus = 3

-- disable cmd messages
opt.showmode = false

-- scrolloff for cursor
opt.scrolloff = 8

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- statusline characters
opt.fillchars = { eob = " " }

-- enhance searching
opt.ignorecase = true
opt.smartcase = true

-- mouse
opt.mouse = "a"

-- numberline
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = false

-- disable highlight search
opt.hlsearch = true

-- wrap
opt.wrap = false

-- enbale signcolumn
opt.signcolumn = "yes"

-- default split from bottom-right
opt.splitbelow = true
opt.splitright = true

-- enable guicolors
opt.termguicolors = true

-- file recovery
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 300

-- Decrease mapped sequence wait time
opt.timeoutlen = 500
opt.ttimeoutlen = 10

-- Sets how neovim will display certain whitespace characters in the editor.
opt.list = true
opt.listchars = { space = "·", tab = "··", trail = "·" }

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- cleaner cmd
opt.shortmess = "filnxtToOFc"

-- cmd sugg
opt.wildmenu = true
opt.wildmode = "longest:full,full"

-- no new comment
opt.formatoptions = "jcroql"

-- Completion.
opt.completeopt = "menu,menuone,noselect,noinsert"

-- Status line.
opt.cmdheight = 1

opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

-- folds
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
