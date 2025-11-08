# Emacs Configuration

This Emacs configuration mirrors the Neovim setup from `.config/nvim/`, providing a comprehensive development environment with extensive comments explaining each feature.

## Overview

This configuration is structured to be as close to a 1:1 match with the Neovim configuration as possible, using equivalent Emacs packages and settings.

## Structure

```
.emacs.d/
├── early-init.el          # Early initialization (performance optimizations)
├── init.el                # Main configuration file
├── lisp/
│   └── plugins/
│       ├── theme.el       # Theme configuration (ashen → doom-one)
│       ├── completion.el  # Completion (blink.cmp → company-mode)
│       ├── lsp.el         # LSP configuration (nvim-lspconfig → lsp-mode)
│       ├── treesitter.el  # Tree-sitter (nvim-treesitter → tree-sitter)
│       ├── modeline.el    # Modeline (lualine → doom-modeline)
│       ├── fuzzy-finder.el # Fuzzy finder (snacks.picker → vertico+consult)
│       ├── git.el         # Git integration (gitsigns → git-gutter+magit)
│       ├── utilities.el   # Utilities (surround, comment, etc.)
│       ├── copilot.el     # GitHub Copilot
│       ├── markdown.el    # Markdown support
│       └── arabic.el      # Arabic language support
├── custom.el              # Auto-generated custom settings
└── README.md              # This file
```

## Feature Mapping: Neovim → Emacs

### Core Settings (options.lua → init.el)

| Neovim Setting | Emacs Equivalent | Location |
|----------------|------------------|----------|
| `opt.clipboard = "unnamedplus"` | `select-enable-clipboard t` | init.el |
| `opt.number = true` | `global-display-line-numbers-mode t` | init.el |
| `opt.relativenumber = true` | `display-line-numbers-type 'relative` | init.el |
| `opt.cursorline = true` | `global-hl-line-mode t` | init.el |
| `opt.scrolloff = 8` | `scroll-margin 8` | init.el |
| `opt.expandtab = true` | `indent-tabs-mode nil` | init.el |
| `opt.shiftwidth = 2` | `evil-shift-width 2` | init.el |
| `opt.ignorecase = true` | `case-fold-search t` | init.el |
| `opt.smartcase = true` | Built into isearch | init.el |
| `opt.splitbelow = true` | `split-height-threshold` | init.el |
| `opt.splitright = true` | `split-width-threshold` | init.el |
| `opt.undofile = true` | `undo-tree-auto-save-history t` | init.el |
| `opt.updatetime = 300` | `idle-update-delay 0.3` | init.el |
| `opt.arabicshape = true` | `arabic-shape-mode t` | arabic.el |

### Keybindings (keymaps.lua → init.el)

| Neovim Keybinding | Emacs Equivalent | Description |
|-------------------|------------------|-------------|
| `<Space>` (leader) | `SPC` (with general.el) | Leader key |
| `<leader>w` | `SPC w` | Save file |
| `<leader>q` | `SPC q` | Quit |
| `<leader>r` | `SPC r` | Replace in buffer |
| `<leader>t` | `SPC t` | Terminal |
| `<leader>x` | `SPC x` | Make executable |
| `<leader>ar` | `SPC ar` | Toggle Arabic input |
| `<S-h>` / `<S-l>` | `H` / `L` | Buffer navigation |
| `<C-d>zz` | `C-d` (auto-center) | Scroll down centered |
| `<C-u>zz` | `C-u` (auto-center) | Scroll up centered |
| Arrow keys | Disabled with message | Force hjkl usage |

### Plugins

| Neovim Plugin | Emacs Equivalent | Config File |
|---------------|------------------|-------------|
| **lazy.nvim** | straight.el + use-package | init.el |
| **ashen.nvim** | doom-one theme | theme.el |
| **blink.cmp** | company-mode + company-box | completion.el |
| **LuaSnip** | yasnippet | completion.el |
| **nvim-lspconfig** | lsp-mode + lsp-ui | lsp.el |
| **mason.nvim** | Manual LSP installation | lsp.el |
| **nvim-treesitter** | tree-sitter-mode | treesitter.el |
| **lualine.nvim** | doom-modeline | modeline.el |
| **snacks.nvim (picker)** | vertico + consult | fuzzy-finder.el |
| **gitsigns.nvim** | git-gutter + magit | git.el |
| **nvim-surround** | evil-surround | utilities.el |
| **Comment.nvim** | evil-nerd-commenter | utilities.el |
| **nvim-colorizer** | rainbow-mode | utilities.el |
| **oil.nvim** | dired + enhancements | utilities.el |
| **trouble.nvim** | flycheck + flycheck-inline | utilities.el |
| **conform.nvim** | format-all / apheleia | utilities.el |
| **copilot.lua** | copilot.el | copilot.el |
| **render-markdown.nvim** | markdown-mode + preview | markdown.el |
| **todo-comments.nvim** | hl-todo | treesitter.el |

### Autocmds (autocmd.lua → init.el + hooks)

| Neovim Autocmd | Emacs Equivalent | Location |
|----------------|------------------|----------|
| TextYankPost (highlight) | evil-goggles | init.el |
| FileType (close with q) | mode-specific keybindings | Various |
| VimResized | window-size-change-functions | init.el |
| BufReadPost (last location) | save-place-mode | init.el |
| Auto-reload on change | global-auto-revert-mode | init.el |
| LSP document highlight | lsp-mode hooks | lsp.el |

## Installation

### Prerequisites

1. **Emacs 28.1 or later** (Emacs 29+ recommended for built-in tree-sitter)
2. **Git** (for package installation)
3. **Fonts**: Install a Nerd Font for icons (e.g., JetBrainsMono Nerd Font)

### Required External Tools

For full functionality, install these tools:

```bash
# LSP servers
npm install -g bash-language-server        # Bash LSP
pip install pyright                         # Python LSP
brew install lua-language-server            # Lua LSP (macOS)

# Formatters
pip install black isort                     # Python formatters
npm install -g prettier                     # JavaScript/JSON/etc formatter
brew install stylua                         # Lua formatter
brew install shfmt                          # Shell script formatter

# Search tools (optional but recommended)
brew install ripgrep fd                     # Fast search tools
```

### Setup Steps

1. **Backup existing configuration** (if any):
   ```bash
   mv ~/.emacs.d ~/.emacs.d.backup
   mv ~/.emacs ~/.emacs.backup  # if it exists
   ```

2. **Copy this configuration**:
   ```bash
   cp -r .emacs.d ~/.emacs.d
   ```

3. **Start Emacs**:
   ```bash
   emacs
   ```
   
   On first launch:
   - Packages will be automatically installed (takes a few minutes)
   - You may see warnings - this is normal during first installation
   - Wait for all packages to finish installing

4. **Install icon fonts**:
   ```
   M-x all-the-icons-install-fonts
   ```

5. **Setup GitHub Copilot** (optional):
   ```
   M-x copilot-login
   ```
   Follow the browser prompts to authenticate.

6. **Install tree-sitter grammars** (Emacs 29+):
   ```
   M-x install-treesit-grammars
   ```

### Post-Installation

After installation, restart Emacs for all changes to take effect.

## Usage

### Leader Key

The leader key is `SPC` (Space) in Normal and Visual modes, or `C-SPC` globally.

### Common Commands

| Command | Description |
|---------|-------------|
| `SPC w` | Save file |
| `SPC q` | Quit Emacs |
| `SPC sf` | Find files (fuzzy) |
| `SPC sb` | Switch buffers |
| `SPC sg` | Grep in project |
| `SPC e` | File explorer (dired) |
| `SPC gg` | Magit status |
| `SPC f` | Format buffer |
| `SPC uc` | Toggle Copilot |
| `SPC ar` | Toggle Arabic input |
| `H` / `L` | Previous/Next buffer |
| `C-c l r` | LSP rename |
| `C-c l a` | LSP code actions |

### Evil Mode (Vim Emulation)

This configuration uses Evil mode for Vim-like editing:

- All standard Vim motions work (hjkl, w, b, etc.)
- Visual mode with `v` and `V`
- Ex commands with `:`
- Registers, marks, macros all work as in Vim

### Package Management

- **Update packages**: `M-x straight-pull-all`, then restart Emacs
- **Rebuild packages**: `M-x straight-rebuild-all`
- **Check package status**: `M-x straight-check-all`

## Customization

### Changing Theme

Edit `lisp/plugins/theme.el`:

```elisp
;; Change the theme loaded on startup
(load-theme 'doom-nord t)  ; or doom-dark+, modus-vivendi, etc.
```

Or cycle themes interactively: `M-x cycle-theme`

### Adjusting Transparency

```elisp
;; In theme.el or init.el
(set-transparency 85)  ; 0-100, where 100 is opaque
```

Or toggle: `M-x toggle-transparency`

### Adding Custom Keybindings

Add to init.el or create a custom file:

```elisp
(leader-def
  "my-key" '(my-function :which-key "My description"))
```

### Disabling a Plugin

Comment out the `require` line in init.el:

```elisp
;; (require 'copilot nil t)  ; Disable Copilot
```

## Differences from Neovim Config

While this configuration aims for 1:1 parity, some differences exist:

1. **Package Manager**: Uses straight.el instead of lazy.nvim
   - Similar lazy-loading capabilities
   - Different syntax but same concept

2. **Modal Editing**: Uses Evil mode for Vim emulation
   - Very close to Neovim behavior
   - Some edge cases may differ

3. **Neovide Settings**: No direct Emacs equivalent for Neovide
   - GUI settings configured differently in Emacs

4. **Some Plugins**: Not all Neovim plugins have exact Emacs equivalents
   - Functionally equivalent alternatives are used
   - Core functionality is preserved

## Troubleshooting

### Packages Won't Install

1. Check internet connection
2. Try: `M-x straight-pull-all` then restart
3. Delete `~/.emacs.d/straight/` and restart

### Icons Not Showing

Run: `M-x all-the-icons-install-fonts`

### LSP Not Working

1. Ensure LSP server is installed (see Prerequisites)
2. Check: `M-x lsp-doctor`
3. Try: `M-x lsp-workspace-restart`

### Performance Issues

1. Increase garbage collection threshold in early-init.el
2. Disable some visual features (transparency, doom-modeline)
3. Use Emacs 29+ with native compilation

### Copilot Authentication Fails

1. Run: `M-x copilot-login`
2. Follow browser prompts carefully
3. Check: https://github.com/zerolfx/copilot.el for updates

## Learning Resources

- **Emacs Manual**: `C-h r` or `M-x info-emacs-manual`
- **Evil Guide**: `M-x evil-tutor`
- **Package Documentation**: `C-h P` (describe-package)
- **Key Bindings**: `C-h b` (describe-bindings)
- **Which-key**: Wait after `SPC` to see available commands

## Contributing

Feel free to customize this configuration for your needs. The modular structure makes it easy to add or remove features.

## Credits

This Emacs configuration is based on the Neovim configuration from this repository, adapted to use Emacs equivalents while maintaining the same functionality and workflow.

### Key Packages Used

- **Evil**: Vim emulation
- **straight.el & use-package**: Package management
- **lsp-mode**: LSP client
- **company-mode**: Completion
- **vertico & consult**: Fuzzy finding
- **magit**: Git interface
- **doom-modeline**: Status line
- **doom-themes**: Color themes

All packages are properly credited to their respective authors in the code comments.

## License

Same license as the original Neovim configuration.
