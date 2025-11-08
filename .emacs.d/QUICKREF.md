# Emacs Quick Reference Card

This is a quick reference for the Emacs configuration that mirrors the Neovim setup.

## Leader Key Commands (SPC or C-SPC)

### File Operations
- `SPC w` - Save file
- `SPC q` - Quit Emacs
- `SPC x` - Make file executable

### Buffer Operations
- `SPC bd` - Delete buffer
- `H` - Previous buffer
- `L` - Next buffer

### Search and Navigation
- `SPC sf` - Find files (fuzzy)
- `SPC sb` - Switch buffers
- `SPC sg` - Grep in project (ripgrep)
- `SPC ss` - Search in current buffer
- `SPC so` - Recent files

### File Explorer
- `SPC e` or `SPC fe` - Open file explorer (dired)
- `-` - Open parent directory

### Git Operations
- `SPC gg` - Magit status
- `SPC gb` - Git blame
- `SPC gc` - Git commit
- `SPC gd` - Git diff
- `SPC gl` - Git log
- `SPC gt` - Git time machine
- `]h` / `[h` - Next/Previous git hunk

### LSP (Language Server Protocol)
- `C-c l r` - Rename symbol
- `C-c l a` - Code actions
- `C-c l f` - Format buffer
- `C-c l d` - Go to definition
- `C-c l R` - Find references
- `C-c l h` - Show documentation
- `SPC th` - Toggle inlay hints

### Formatting & Diagnostics
- `SPC f` - Format buffer
- `SPC xx` - List errors
- `SPC xn` - Next error
- `SPC xp` - Previous error

### Toggle Options
- `SPC uw` - Toggle line wrap
- `SPC ul` - Toggle line numbers
- `SPC ud` - Toggle diagnostics
- `SPC uc` - Toggle Copilot

### Arabic Support
- `SPC ar` - Toggle Arabic input
- `SPC ad` - Toggle text direction (LTR/RTL)
- `SPC af` - Setup Arabic fonts

### Markdown
- `SPC mp` - Preview markdown
- `SPC mt` - Generate table of contents
- `SPC mr` - Refresh TOC

### Replace
- `SPC r` - Query replace in buffer

## Evil Mode (Vim Emulation)

### Navigation
- `h/j/k/l` - Left/Down/Up/Right
- `w` / `b` - Word forward/backward
- `gg` / `G` - Top/Bottom of file
- `C-d` / `C-u` - Scroll down/up (auto-centered)
- `n` / `N` - Next/Previous search match (auto-centered)

### Editing
- `i` / `a` - Insert before/after cursor
- `I` / `A` - Insert at line start/end
- `o` / `O` - Open line below/above
- `v` / `V` - Visual mode / Visual line mode
- `y` / `d` / `c` - Yank/Delete/Change
- `p` / `P` - Paste after/before
- `u` / `U` - Undo / Redo
- `.` - Repeat last command

### Text Objects
- `ciw` - Change inner word
- `daw` - Delete a word
- `yis` - Yank inner sentence
- `cs"'` - Change surrounding " to '
- `ds"` - Delete surrounding "
- `ysiw"` - Surround word with "

### Comments
- `gcc` - Toggle comment on line
- `gc` (visual) - Toggle comment on selection

### Search
- `/pattern` - Search forward
- `?pattern` - Search backward
- `*` - Search word under cursor
- `#` - Search word under cursor (backward)

## Fuzzy Finder (Consult/Vertico)

### During Completion
- `C-n` / `C-p` - Next/Previous candidate
- `C-v` - View candidate (preview)
- `RET` - Select candidate
- `C-g` - Cancel

### Special Commands
- `C-x b` - Switch buffer (consult-buffer)
- `M-y` - Yank from kill ring
- `M-g i` - Jump to function/heading (imenu)
- `M-s r` - Ripgrep search

## Company Mode (Completion)

- `TAB` - Complete selection
- `C-n` / `C-p` - Next/Previous candidate
- `C-d` - Show documentation
- `M-.` - Show location
- `C-g` - Cancel

## Copilot

- `C-y` - Accept suggestion
- `M-y` - Accept word
- `M-]` / `M-[` - Next/Previous suggestion
- `C-]` - Dismiss suggestion

## Magit (Git)

- `s` - Stage file/hunk
- `u` - Unstage file/hunk
- `c c` - Commit
- `P p` - Push
- `F p` - Pull
- `d d` - Diff
- `l l` - Log
- `b b` - Switch branch
- `q` - Quit

## Dired (File Explorer)

- `RET` or `l` - Open file/directory
- `h` - Go up directory
- `m` - Mark file
- `u` - Unmark file
- `D` - Delete marked files
- `C` - Copy marked files
- `R` - Rename/Move marked files
- `+` - Create directory
- `g` - Refresh
- `q` - Quit

## Help System

- `C-h k` - Describe key
- `C-h f` - Describe function
- `C-h v` - Describe variable
- `C-h m` - Describe mode
- `C-h b` - Show all keybindings
- `C-h r` - Emacs manual

## Window Management

- `C-x 2` - Split horizontally
- `C-x 3` - Split vertically
- `C-x 0` - Close current window
- `C-x 1` - Close other windows
- `C-x o` - Switch to other window

## Emergency Commands

- `C-g` - Cancel current command
- `M-x recover-session` - Recover crashed session
- `M-x straight-rebuild-all` - Rebuild all packages
- `M-x emacs-init-time` - Show startup time

## Package Management

- `M-x straight-pull-all` - Update all packages
- `M-x straight-rebuild-all` - Rebuild all packages
- `M-x list-packages` - List installed packages

## Useful Functions

- `M-x toggle-transparency` - Toggle transparent background
- `M-x cycle-theme` - Cycle through themes
- `M-x install-treesit-grammars` - Install tree-sitter grammars
- `M-x copilot-login` - Authenticate Copilot
- `M-x lsp-doctor` - Diagnose LSP issues

## Configuration Files

- `~/.emacs.d/init.el` - Main configuration
- `~/.emacs.d/early-init.el` - Early initialization
- `~/.emacs.d/lisp/plugins/` - Plugin configurations
- `~/.emacs.d/custom.el` - Auto-generated settings

## Tips

1. **Which-key**: Press `SPC` and wait to see available commands
2. **Completion**: Press `TAB` in most places for completion
3. **Help**: Use `C-h` followed by any key for context help
4. **Undo**: Emacs has powerful undo with `C-/` or `u` in Evil
5. **Snippets**: Type snippet trigger and press `TAB` (e.g., `for` + `TAB`)
6. **LSP**: Most LSP commands start with `C-c l`
7. **Git**: All git operations in `SPC g` menu
8. **Arabic**: Toggle with `SPC ar`, works seamlessly with Evil mode

## Learning More

- Emacs Manual: `C-h r`
- Evil Tutorial: `M-x evil-tutor`
- Package Info: `C-h P package-name`
- Key Binding: `C-h k` then press the key

## Common Issues

**Packages not loading?**
- Run `M-x straight-pull-all` and restart

**Icons missing?**
- Run `M-x all-the-icons-install-fonts`

**LSP not working?**
- Install the language server (see README)
- Run `M-x lsp-doctor`

**Copilot not authenticating?**
- Run `M-x copilot-login`
- Check network and GitHub auth

**Slow startup?**
- Check `M-x emacs-init-time`
- Disable some plugins in init.el
