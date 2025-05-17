local opt = vim.opt

-- do shaping for Arabic characters
opt.arabicshape = true

-- auto read
opt.autoread = true

-- enable system clipboard
opt.clipboard = "unnamedplus"

-- make 'autoindent' use existing indent structure
opt.copyindent = true

-- (optional) cursorline has no effect if transparent.nvim is enable
opt.cursorline = true

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

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
opt.updatetime = 400

-- Decrease mapped sequence wait time
opt.timeoutlen = 500

-- Sets how neovim will display certain whitespace characters in the editor.
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- cleaner cmd
opt.shortmess = "filnxtToOFc"

-- cmd sugg
opt.wildmenu = true
opt.wildmode = "longest:full,full"

-- no new comment
opt.formatoptions = "jcroql"
