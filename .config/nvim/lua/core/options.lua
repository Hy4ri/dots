-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Snacks animations
-- Set to `false` to globally disable all snacks animations
vim.g.snacks_animate = false

-- do shaping for Arabic characters
vim.opt.arabicshape = true

-- enable system clipboard
vim.opt.clipboard = "unnamedplus"

-- make 'autoindent' use existing indent structure
vim.opt.copyindent = true

-- (optional) cursorline has no effect if transparent.nvim is enable
vim.opt.cursorline = true

-- global statusline
vim.opt.laststatus = 3

-- disable cmd messages
vim.opt.showmode = false

-- scrolloff for cursor
vim.opt.scrolloff = 8

-- Indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- statusline characters
vim.opt.fillchars = { eob = " " }

-- enhance searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- mouse
vim.opt.mouse = "a"

-- numberline
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.ruler = false

-- disable highlight search
vim.opt.hlsearch = true

-- wrap
vim.opt.wrap = false

-- enbale signcolumn
vim.opt.signcolumn = "yes"

-- default split from bottom-right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- enable guicolors
vim.opt.termguicolors = true

-- file recovery
vim.opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
vim.opt.updatetime = 300

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { space = "·", tab = "  ↦", trail = "·" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- cleaner cmd
vim.opt.shortmess = "filnxtToOFc"

-- cmd sugg
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

-- no new comment
vim.opt.formatoptions = "jcroql"

-- Completion.
vim.opt.completeopt = "menu,menuone,noselect,noinsert"

-- Status line.
vim.opt.cmdheight = 1

vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- folds

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
