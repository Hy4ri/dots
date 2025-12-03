local opt = vim.opt
local g = vim.g

---- Text Editing & Indentation
opt.arabicshape = true -- Correctly displays Arabic characters' shapes.
opt.copyindent = true -- When auto-indenting, copies the indentation structure from the previous line.
opt.expandtab = true -- Converts all <Tab> key presses into spaces.
opt.shiftwidth = 2 -- Sets the width for indentation operations (like >> or <<) to 2 spaces.
opt.smartindent = true -- Enables "smart" indentation (e.g., automatically indenting after '{' in C-like files).
opt.autoindent = true -- Copies the indentation from the previous line when starting a new line.
opt.tabstop = 2 -- Sets the visual width of a <Tab> character to 2 spaces.
opt.softtabstop = 2 -- Makes the <Tab> key insert 2 spaces (works with `expandtab`).
opt.formatoptions = "jcroql" -- Controls various automatic formatting options (e.g., 'c' wraps comments).
opt.smoothscroll = true -- Makes scrolling smoother
opt.breakindent = true -- Indents wrapped lines to match code indentation
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode

---- Behavior & Performance
opt.clipboard = "unnamedplus" -- Uses the system clipboard (+) for all copy/paste operations.
opt.mouse = "a" -- Enables mouse support in all modes (clicking, scrolling, resizing splits).
opt.undofile = true -- Saves undo history to a file, allowing you to undo *after* closing and reopening a file.
opt.timeoutlen = 500 -- Reduces the time (to 500ms) Vim waits for you to complete a mapping (e.g., 'gd').
opt.ttimeoutlen = 10 -- Reduces the time (to 10ms) Vim waits for an ambiguous terminal key code.
opt.shortmess = "filnxtToOFc" -- Shortens the messages Vim displays (e.g., hiding the intro message).
opt.iskeyword:append("-") -- Treats hyphenated words as a single word for motions and text objects
opt.autoread = true -- Automatically reloads a file if it was changed outside of Neovim
opt.autowrite = false -- Automatically writes changes to a file when switching buffers or exiting Neovim
opt.splitbelow = true -- Makes new horizontal splits (e.g., :split) open *below* the current window.
opt.splitright = true -- Makes new vertical splits (e.g., :vsplit) open to the *right* of the current window.
opt.diffopt:append("vertical") -- Opens diffs in vertical splits
opt.diffopt:append("algorithm:patience") -- Uses the "patience" algorithm for better diffs
opt.diffopt:append("linematch:60") -- Improves diff algorithm for better diffs

---- UI - Visuals & Layout
opt.cursorline = true -- Highlights the entire line your cursor is currently on.
opt.laststatus = 3 -- Sets the status line to be *always* visible (global status line).
opt.showmode = false -- Disables the mode indicator (e.g., -- INSERT --) at the bottom.
opt.scrolloff = 8 -- Keeps 8 lines of context visible above and below the cursor when scrolling.
opt.number = true -- Shows absolute line numbers for every line.
opt.relativenumber = true -- Shows line numbers relative to the cursor (e.g., 1, 2, 3... away).
opt.numberwidth = 2 -- Sets the width of the line number column to 2 characters.
opt.ruler = false -- Hides the cursor position (row/col) from the bottom-right corner.
opt.wrap = false -- Disables automatic line wrapping; long lines will scroll horizontally.
opt.signcolumn = "yes" -- Always displays the "sign column" on the left (used for diagnostics, Git signs, etc.).
opt.list = true -- Enables the display of invisible characters.
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Defines characters for invisible items
opt.termguicolors = true -- Enables 24-bit "true color" support (requires a compatible terminal).
opt.cmdheight = 0 -- Hides the command line area (set to 0 lines).
opt.showcmdloc = "statusline" -- Shows pending commands in the status line instead of the (hidden) command line.
opt.fillchars = { -- It defines characters for folds, diffs, and hides the '~' at the end of the buffer.
	foldopen = "", -- Character for an open fold
	foldclose = "", -- Character for a closed fold
	fold = " ", -- Character for the fold column
	foldsep = " ", -- Character for fold separator
	diff = "╱", -- Character for diff mode
	eob = " ", -- Character for end-of-buffer lines (hides the '~')
}

---- Search & Replace
opt.ignorecase = true -- Makes all searches case-insensitive.
opt.smartcase = true -- Overrides 'ignorecase' if your search term contains an uppercase letter.
opt.hlsearch = true -- Automatically highlights all matches for your last search.
opt.incsearch = true -- Shows search matches as you type (incremental search).
opt.inccommand = "split" -- Shows a live preview of a substitute-command (`:s/.../.../`) in a split window.

---- Command Line & Completion
opt.wildmenu = true -- Enables an enhanced completion menu when typing commands or paths.
opt.wildmode = "longest:full,full"
opt.completeopt = "menuone,noinsert,noselect" -- Configures the autocompletion popup: 'menu' (show menu), 'menuone' (show even
-- with 1 match), 'noselect' (don't auto-select first entry), 'noinsert' (don't auto-insert text from the selection).

---- Plugins
g.snacks_animate = false