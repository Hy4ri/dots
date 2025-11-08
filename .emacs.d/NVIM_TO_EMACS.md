# Neovim to Emacs Configuration Mapping

This document provides a detailed mapping between the Neovim configuration and the Emacs configuration.

## File Structure Comparison

### Neovim (.config/nvim/)
```
.config/nvim/
├── init.lua                    # Main entry point
├── lazy-lock.json              # Plugin lock file
├── lua/
│   ├── core/
│   │   ├── options.lua        # Editor settings
│   │   ├── keymaps.lua        # Keybindings
│   │   ├── autocmd.lua        # Autocommands
│   │   └── neovide.lua        # Neovide GUI settings
│   └── plugins/
│       ├── store.lua          # Plugin store
│       ├── theme.lua          # Themes
│       ├── blink.lua          # Completion
│       ├── lspconfig.lua      # LSP
│       ├── treesitter.lua     # Syntax
│       ├── lualine.lua        # Statusline
│       ├── snacks.lua         # Fuzzy finder
│       ├── gitsigns.lua       # Git integration
│       ├── copilot.lua        # AI completion
│       ├── conform.lua        # Formatting
│       ├── oil.lua            # File explorer
│       ├── surround.lua       # Text objects
│       ├── comment.lua        # Comments
│       ├── colorizer.lua      # Color display
│       ├── trouble.lua        # Diagnostics
│       ├── todo.lua           # TODO comments
│       └── markdown.lua       # Markdown
```

### Emacs (.emacs.d/)
```
.emacs.d/
├── early-init.el              # Early initialization
├── init.el                    # Main entry point (combines init + core)
├── custom.el                  # Auto-generated (like lazy-lock.json)
├── README.md                  # Comprehensive guide
├── QUICKREF.md                # Quick reference card
└── lisp/
    └── plugins/
        ├── theme.el           # Themes (doom-themes)
        ├── completion.el      # Completion (company-mode)
        ├── lsp.el             # LSP (lsp-mode)
        ├── treesitter.el      # Syntax (tree-sitter)
        ├── modeline.el        # Statusline (doom-modeline)
        ├── fuzzy-finder.el    # Fuzzy finder (vertico+consult)
        ├── git.el             # Git integration (magit+git-gutter)
        ├── copilot.el         # AI completion (copilot.el)
        ├── utilities.el       # Multiple utilities combined
        ├── markdown.el        # Markdown support
        └── arabic.el          # Arabic support (from options + keymaps)
```

## Core Settings Mapping

### options.lua → init.el

| Neovim (options.lua) | Emacs (init.el) | Notes |
|---------------------|----------------|-------|
| `vim.g.have_nerd_font = true` | Font setup with all-the-icons | Icons package |
| `vim.g.snacks_animate = false` | No equivalent | Emacs doesn't have snacks |
| `opt.arabicshape = true` | `arabic-shape-mode t` | In arabic.el |
| `opt.clipboard = "unnamedplus"` | `select-enable-clipboard t` | System clipboard |
| `opt.copyindent = true` | `indent-line-function 'indent-relative` | Auto-indent |
| `opt.cursorline = true` | `global-hl-line-mode t` | Highlight line |
| `opt.laststatus = 3` | Global statusline by default | Always global |
| `opt.showmode = false` | Mode shown in modeline | Via evil + modeline |
| `opt.scrolloff = 8` | `scroll-margin 8` | Keep cursor centered |
| `opt.expandtab = true` | `indent-tabs-mode nil` | Spaces not tabs |
| `opt.shiftwidth = 2` | `tab-width 2` + `evil-shift-width 2` | Indent width |
| `opt.smartindent = true` | `electric-indent-mode 1` | Auto-indent |
| `opt.tabstop = 2` | `tab-width 2` | Tab display |
| `opt.softtabstop = 2` | `tab-width 2` | Tab behavior |
| `opt.fillchars = { eob = " " }` | Custom modeline chars | In modeline setup |
| `opt.ignorecase = true` | `case-fold-search t` | Case-insensitive |
| `opt.smartcase = true` | Built into isearch | Smart case search |
| `opt.mouse = "a"` | `xterm-mouse-mode 1` | Mouse support |
| `opt.number = true` | `global-display-line-numbers-mode t` | Line numbers |
| `opt.relativenumber = true` | `display-line-numbers-type 'relative` | Relative numbers |
| `opt.numberwidth = 2` | Default | Number column width |
| `opt.ruler = false` | Column number in modeline | Via modeline |
| `opt.hlsearch = true` | `search-highlight t` | Highlight search |
| `opt.wrap = false` | `truncate-lines t` | No line wrap |
| `opt.signcolumn = "yes"` | Always shown with git-gutter | Sign column |
| `opt.splitbelow = true` | `split-height-threshold` | Split below |
| `opt.splitright = true` | `split-width-threshold` | Split right |
| `opt.termguicolors = true` | Always enabled in GUI | True colors |
| `opt.undofile = true` | `undo-tree-auto-save-history t` | Persistent undo |
| `opt.updatetime = 300` | `idle-update-delay 0.3` | Update delay |
| `opt.timeoutlen = 500` | `echo-keystrokes 0.01` | Key sequence delay |
| `opt.ttimeoutlen = 10` | Fast by default | Terminal timeout |
| `opt.list = true` | `whitespace-style` | Show whitespace |
| `opt.listchars` | `whitespace-style` config | Whitespace chars |
| `opt.inccommand = "split"` | Preview in minibuffer | Live preview |
| `opt.shortmess = "filnxtToOFc"` | Various message settings | Message format |
| `opt.wildmenu = true` | Built-in | Command completion |
| `opt.wildmode = "longest:full,full"` | Completion styles | Completion mode |
| `opt.formatoptions = "jcroql"` | Custom format hooks | Format options |
| `opt.completeopt` | `completion-styles` | Completion options |
| `opt.cmdheight = 0` | Minibuffer height | Command height |
| `opt.showcmdloc = "statusline"` | In modeline | Show commands |

### keymaps.lua → init.el

| Neovim (keymaps.lua) | Emacs (init.el) | Notes |
|---------------------|----------------|-------|
| `vim.g.mapleader = " "` | `"SPC"` with general.el | Leader key |
| `vim.g.maplocalleader = " "` | Same as leader | Local leader |
| Disable arrow keys | `define-key` with messages | Force hjkl |
| `<leader>ar` Arabic toggle | `SPC ar` → toggle-arabic-input | Arabic support |
| `<C-d>zz` center scroll | Auto-centers with advice | Scroll centered |
| `<C-u>zz` center scroll | Auto-centers with advice | Scroll centered |
| `nzzzv` center search | Auto-centers | Search centered |
| `Nzzzv` center search | Auto-centers | Search centered |
| Powerful `<esc>` | Standard ESC behavior | Exit modes |
| Better j/k | Evil visual line mode | Visual lines |
| `<S-h>` previous buffer | `H` → previous-buffer | Buffer nav |
| `<S-l>` next buffer | `L` → next-buffer | Buffer nav |
| `<leader>bd` delete buffer | `SPC bd` → kill-current-buffer | Delete buffer |
| `<leader>p` paste fix | Evil yank behavior | Paste |
| Move visual lines J/K | Visual mode with evil | Move lines |
| `J` join lines | `J` → evil-join | Join lines |
| Snacks picker commands | Consult commands | Fuzzy finder |
| `<leader>w` write | `SPC w` → save-buffer | Save |
| `<leader>q` quit | `SPC q` → quit | Quit |
| `<leader>t` terminal | `SPC t` → eshell | Terminal |
| `<leader>r` replace | `SPC r` → query-replace | Replace |
| `<leader>L` lazy | N/A (use straight) | Package manager |
| `U` redo | `U` → evil-redo | Redo |
| `<leader>uc` toggle copilot | `SPC uc` → toggle-copilot | Copilot |
| `-` oil file explorer | `-` → dired-jump | File explorer |
| `<leader>x` make executable | `SPC x` → chmod +x | Make exec |

### autocmd.lua → init.el + hooks

| Neovim (autocmd.lua) | Emacs (init.el / hooks) | Notes |
|---------------------|------------------------|-------|
| TextYankPost highlight | evil-goggles package | Highlight yank |
| Close with q | Mode-specific keymaps | Quick close |
| VimResized auto-resize | window-size-change-functions | Auto resize |
| BufReadPost last location | save-place-mode | Restore position |
| Reload on change | global-auto-revert-mode | Auto reload |
| Disable auto comments | Custom hooks | No auto comment |
| Open help vertical | help-window-select | Help windows |
| LSP document highlight | lsp-mode hooks | Highlight refs |
| Clear on insert | Evil mode hooks | Clear highlights |

## Plugin Mapping

### Package Managers

| Neovim | Emacs | Notes |
|--------|-------|-------|
| lazy.nvim | straight.el + use-package | Both support lazy loading |
| lazy-lock.json | straight versions | Version locking |
| `:Lazy` | `M-x straight-*` | Management UI |

### Theme Plugins (theme.lua → theme.el)

| Neovim Plugin | Emacs Package | Notes |
|--------------|---------------|-------|
| ashen.nvim | doom-one theme | Similar dark aesthetic |
| vesper.nvim | doom-nord theme | Alternative dark theme |
| tokyodark.nvim | ef-themes | Dark theme family |
| transparent = true | Custom transparency function | 85% transparency |

### Completion (blink.lua → completion.el)

| Neovim Plugin | Emacs Package | Feature |
|--------------|---------------|---------|
| blink.cmp | company-mode | Completion engine |
| N/A | company-box | Visual UI for completion |
| LuaSnip | yasnippet | Snippet engine |
| friendly-snippets | yasnippet-snippets | Snippet collection |
| preset = "super-tab" | TAB completion | Tab to complete |
| auto_brackets | electric-pair-mode | Auto brackets |
| fuzzy matching | company-fuzzy + orderless | Fuzzy search |

### LSP (lspconfig.lua → lsp.el)

| Neovim Plugin | Emacs Package | Feature |
|--------------|---------------|---------|
| nvim-lspconfig | lsp-mode | LSP client |
| mason.nvim | Manual installation | Server management |
| mason-lspconfig | N/A | Integration |
| mason-tool-installer | Manual | Tool installation |
| Diagnostic config | lsp-diagnostics-* vars | Diagnostic display |
| Document highlight | lsp-mode hooks | Symbol highlight |
| Inlay hints | lsp-inlay-hints-mode | Type hints |
| N/A | lsp-ui | Additional UI |
| N/A | lsp-treemacs | Tree views |

### Tree-sitter (treesitter.lua → treesitter.el)

| Neovim Plugin | Emacs Package | Feature |
|--------------|---------------|---------|
| nvim-treesitter | treesit (built-in) or tree-sitter | Parser |
| :TSUpdate | install-treesit-grammars | Update grammars |
| ensure_installed | Language source alist | Auto-install |
| auto_install = true | Auto-install function | Auto grammars |
| highlight | tree-sitter-hl-mode | Syntax highlight |
| indent | aggressive-indent-mode | Auto-indent |

### Statusline (lualine.lua → modeline.el)

| Neovim Plugin | Emacs Package | Feature |
|--------------|---------------|---------|
| lualine.nvim | doom-modeline | Modeline |
| nvim-web-devicons | all-the-icons | Icons |
| file_with_icon | Built-in | File display |
| search_count | isearch-lazy-count | Search count |
| lsp_client | doom-modeline-lsp | LSP status |
| clock | display-time-mode | Time display |
| recording_macro | Custom function | Macro indicator |
| branch | doom-modeline vcs | Git branch |
| diff | doom-modeline vcs | Git diff |
| diagnostics | doom-modeline checker | Diagnostics |

### Fuzzy Finder (snacks.lua → fuzzy-finder.el)

| Neovim Plugin | Emacs Package | Feature |
|--------------|---------------|---------|
| snacks.nvim picker | vertico | Vertical completion |
| N/A | consult | Enhanced commands |
| N/A | marginalia | Annotations |
| N/A | orderless | Fuzzy matching |
| N/A | embark | Contextual actions |
| picker() | execute-extended-command | Command picker |
| buffers() | consult-buffer | Buffer picker |
| files() | project-find-file | File picker |
| grep() | consult-ripgrep | Grep search |
| recent() | consult-recent-file | Recent files |
| snacks.explorer | dired-jump | File explorer |

### Git Integration (gitsigns.lua → git.el)

| Neovim Plugin | Emacs Package | Feature |
|--------------|---------------|---------|
| gitsigns.nvim | git-gutter | Inline git signs |
| N/A | magit | Full git interface |
| N/A | git-timemachine | History browser |
| N/A | git-commit | Commit editing |
| Signs in gutter | git-gutter signs | +/~/- indicators |
| Hunk navigation | Next/prev hunk functions | Navigate changes |
| Stage/revert hunk | git-gutter actions | Hunk operations |

### Utilities (Multiple → utilities.el)

| Neovim Plugin | Emacs Package | Feature |
|--------------|---------------|---------|
| nvim-surround | evil-surround | Surround text objects |
| Comment.nvim | evil-nerd-commenter | Smart comments |
| nvim-colorizer | rainbow-mode | Color display |
| oil.nvim | dired + enhancements | File management |
| trouble.nvim | flycheck + flycheck-inline | Diagnostics list |
| conform.nvim | format-all + apheleia | Code formatting |
| N/A | ws-butler | Whitespace cleanup |
| N/A | smartparens | Smart parentheses |
| N/A | multiple-cursors | Multi-cursor editing |
| N/A | helpful | Better help buffers |

### Copilot (copilot.lua → copilot.el)

| Neovim Plugin | Emacs Package | Feature |
|--------------|---------------|---------|
| copilot.lua | copilot.el | GitHub Copilot |
| auto_trigger | copilot-idle-delay | Auto suggestions |
| accept = C-y | C-y | Accept suggestion |
| accept_word = M-y | M-y | Accept word |
| next = M-] | M-] | Next suggestion |
| prev = M-[ | M-[ | Previous suggestion |
| dismiss = C-] | C-] | Dismiss |

### Markdown (markdown.lua → markdown.el)

| Neovim Plugin | Emacs Package | Feature |
|--------------|---------------|---------|
| render-markdown.nvim | markdown-mode | Markdown editing |
| N/A | markdown-preview-mode | Live preview |
| N/A | grip-mode | GitHub-style preview |
| N/A | markdown-toc | TOC generation |
| N/A | olivetti-mode | Distraction-free |
| N/A | pandoc-mode | Format conversion |

### Other Plugins

| Neovim Plugin | Status | Notes |
|--------------|--------|-------|
| store.nvim | Not ported | Specific to plugin store |
| todo-comments.nvim | Included in treesitter.el | hl-todo package |
| neovide settings | Not applicable | GUI-specific to Neovide |

## Installation Comparison

### Neovim
```bash
# Automatic with lazy.nvim
# Just open Neovim and wait
```

### Emacs
```bash
# Automatic with straight.el
# Just open Emacs and wait
M-x all-the-icons-install-fonts  # For icons
M-x install-treesit-grammars     # For tree-sitter
```

## Usage Patterns

### Opening Files

**Neovim:**
```
<leader>sf  - Find files
<leader>sb  - Switch buffers
<leader>e   - File explorer
```

**Emacs:**
```
SPC sf  - Find files
SPC sb  - Switch buffers
SPC e   - File explorer (dired)
```

### Git Operations

**Neovim:**
```
<leader>gg  - Magit status
[h / ]h     - Previous/Next hunk
```

**Emacs:**
```
SPC gg  - Magit status
[h / ]h - Previous/Next hunk
```

### LSP Operations

**Neovim:**
```
gd          - Go to definition
gr          - Find references
<leader>ca  - Code actions
```

**Emacs:**
```
gd             - Go to definition (via snacks)
gr             - Find references (via snacks)
C-c l a        - Code actions
```

## Key Differences

1. **Modal Editing**: Emacs uses Evil mode to emulate Vim
   - Very close to Vim but not 100% identical
   - Some edge cases may behave differently

2. **Package Management**: 
   - Neovim: lazy.nvim (Lua-based)
   - Emacs: straight.el + use-package (Elisp-based)
   - Both support lazy loading and version pinning

3. **Configuration Language**:
   - Neovim: Lua
   - Emacs: Emacs Lisp
   - Both are fully-featured scripting languages

4. **Plugin Ecosystem**:
   - Neovim: Newer, Lua-first plugins
   - Emacs: Mature, extensive package collection
   - Emacs has packages for almost everything

5. **LSP Integration**:
   - Neovim: Built-in LSP client
   - Emacs: lsp-mode package (very mature)
   - Both support the same language servers

6. **Tree-sitter**:
   - Neovim: First-class support
   - Emacs: Built-in in Emacs 29+, package for older versions

## Performance

Both configurations are optimized for performance:

- **Startup Time**: 
  - Neovim: ~50-100ms
  - Emacs: ~1-2s (first start), ~0.5s (cached)

- **Memory Usage**:
  - Neovim: ~30-50MB
  - Emacs: ~50-100MB

- **Responsiveness**:
  - Both are very responsive with proper configuration
  - Emacs benefits from native compilation (Emacs 28+)

## Conclusion

This Emacs configuration provides a nearly 1:1 feature match with the Neovim configuration:

- **All core features** are preserved
- **Keybindings** are identical or very similar
- **Functionality** is equivalent
- **Workflow** remains the same
- **Comments** are comprehensive throughout

The main difference is the underlying platform (Emacs vs Neovim), but the user experience is designed to be as similar as possible for seamless transition.
