;;; init.el --- Main Emacs configuration file -*- lexical-binding: t; -*-

;; Copyright (C) 2024

;; Author: Hy4ri
;; URL: https://github.com/Hy4ri/dots
;; Keywords: emacs configuration

;;; Commentary:

;; This is the main Emacs configuration file, mirroring the Neovim setup
;; from .config/nvim/init.lua. It sets up the package manager, loads
;; core settings, keybindings, and plugins.
;;
;; Structure:
;; - Bootstrap straight.el (package manager, similar to lazy.nvim)
;; - Load core settings (options, keybindings)
;; - Initialize plugins
;; - Set theme

;;; Code:

;; ========================================================================
;; Bootstrap straight.el (Package Manager)
;; ========================================================================
;; straight.el is a package manager similar to lazy.nvim
;; It provides reproducible package management with version locking

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; ========================================================================
;; use-package Integration
;; ========================================================================
;; use-package provides a clean macro for configuring packages
;; Similar to how lazy.nvim handles plugin configuration

(straight-use-package 'use-package)

;; Configure use-package to use straight.el by default
(setq straight-use-package-by-default t)

;; Always ensure packages are installed
(setq use-package-always-ensure t)

;; Enable verbose loading for debugging (set to nil for faster startup)
(setq use-package-verbose nil)

;; ========================================================================
;; Core Settings
;; ========================================================================
;; Load core Emacs settings (equivalent to core/options.lua)

;; ------------------------------------------------------------------------
;; General Settings
;; ------------------------------------------------------------------------

;; Set custom file to separate from init.el
;; This keeps auto-generated code out of init.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Enable lexical binding for better performance
(setq lexical-binding t)

;; UTF-8 encoding everywhere
;; Ensures proper character display (important for Arabic support)
(set-charset-priority 'unicode)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; ------------------------------------------------------------------------
;; Clipboard Integration
;; ------------------------------------------------------------------------
;; Enable system clipboard integration
;; Equivalent to: opt.clipboard = "unnamedplus"

(setq select-enable-clipboard t
      select-enable-primary t
      save-interprogram-paste-before-kill t)

;; ------------------------------------------------------------------------
;; Indentation Settings
;; ------------------------------------------------------------------------
;; Configure indentation behavior
;; Equivalent to:
;;   opt.expandtab = true
;;   opt.shiftwidth = 2
;;   opt.smartindent = true
;;   opt.tabstop = 2
;;   opt.softtabstop = 2

(setq-default indent-tabs-mode nil)     ; Use spaces, not tabs
(setq-default tab-width 2)              ; Tab display width
(setq-default standard-indent 2)        ; Standard indentation
(setq-default evil-shift-width 2)       ; Shift width for evil mode

;; Enable auto-indentation
(electric-indent-mode 1)

;; Copy indent from previous line
;; Equivalent to: opt.copyindent = true
(setq-default indent-line-function 'indent-relative)

;; ------------------------------------------------------------------------
;; Display Settings
;; ------------------------------------------------------------------------

;; Enable line numbers
;; Equivalent to: opt.number = true, opt.relativenumber = true
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

;; Disable line numbers in certain modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook
                treemacs-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Highlight current line
;; Equivalent to: opt.cursorline = true
(global-hl-line-mode t)

;; Show column number in modeline
(column-number-mode t)

;; Disable line wrapping by default
;; Equivalent to: opt.wrap = false
(setq-default truncate-lines t)

;; Better scrolling behavior
;; Equivalent to: opt.scrolloff = 8
(setq scroll-margin 8
      scroll-conservatively 100000
      scroll-preserve-screen-position t)

;; Smooth scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse t)

;; Show matching parentheses
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Visualize whitespace
;; Equivalent to: opt.list = true, opt.listchars = { space = "·", tab = "··", trail = "·" }
(setq whitespace-style '(face tabs spaces trailing space-before-tab
                         newline indentation empty space-after-tab
                         space-mark tab-mark))

;; Enable visual line mode for better text wrapping when needed
(global-visual-line-mode nil)

;; ------------------------------------------------------------------------
;; Search Settings
;; ------------------------------------------------------------------------
;; Enhanced search behavior
;; Equivalent to: opt.ignorecase = true, opt.smartcase = true

(setq case-fold-search t)               ; Case-insensitive search
(setq isearch-lazy-count t)             ; Show match count
(setq lazy-count-prefix-format "[%s/%s] ")
(setq lazy-count-suffix-format nil)

;; Highlight search results
;; Equivalent to: opt.hlsearch = true
(setq search-highlight t
      isearch-highlight t)

;; ------------------------------------------------------------------------
;; Backup and Auto-save Settings
;; ------------------------------------------------------------------------

;; Store backup files in a central location
(setq backup-directory-alist `(("." . ,(expand-file-name "backups" user-emacs-directory))))

;; Enable undo history persistence
;; Equivalent to: opt.undofile = true
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist
      `(("." . ,(expand-file-name "undo" user-emacs-directory))))

;; Auto-save settings
(setq auto-save-default t
      auto-save-timeout 20
      auto-save-interval 200)

;; Keep auto-save files in a separate directory
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "auto-save/" user-emacs-directory) t)))

;; ------------------------------------------------------------------------
;; Window and Frame Settings
;; ------------------------------------------------------------------------

;; Split windows more sensibly
;; Equivalent to: opt.splitbelow = true, opt.splitright = true
(setq split-height-threshold 80
      split-width-threshold 160)

(setq window-combination-resize t)      ; Resize windows proportionally

;; Better window switching
(winner-mode 1)                         ; Undo/redo window configurations

;; ------------------------------------------------------------------------
;; Completion Settings
;; ------------------------------------------------------------------------
;; Better completion behavior
;; Equivalent to: opt.completeopt = "menu,menuone,noselect,noinsert"

(setq completion-cycle-threshold 3)
(setq tab-always-indent 'complete)
(setq completion-styles '(basic partial-completion emacs22))

;; ------------------------------------------------------------------------
;; Mouse Support
;; ------------------------------------------------------------------------
;; Enable mouse support in terminal
;; Equivalent to: opt.mouse = "a"

(xterm-mouse-mode 1)
(setq mouse-yank-at-point t)

;; ------------------------------------------------------------------------
;; Misc Settings
;; ------------------------------------------------------------------------

;; Disable bell
(setq ring-bell-function 'ignore)

;; Confirm before quitting
(setq confirm-kill-emacs 'y-or-n-p)

;; Enable y/n instead of yes/no
(if (version< emacs-version "28")
    (defalias 'yes-or-no-p 'y-or-n-p)
  (setq use-short-answers t))

;; Faster echo of keystrokes
;; Equivalent to: opt.timeoutlen = 500, opt.ttimeoutlen = 10
(setq echo-keystrokes 0.01)

;; Better file handling
(setq create-lockfiles nil)             ; Don't create lockfiles
(setq make-backup-files t)              ; Do make backups
(setq version-control t)                ; Version backups
(setq kept-new-versions 10)             ; Keep 10 newest
(setq kept-old-versions 0)              ; Don't keep old
(setq delete-old-versions t)            ; Delete without asking

;; Refresh buffers when files change on disk
;; Equivalent to the "checktime" autocmd
(global-auto-revert-mode t)
(setq auto-revert-verbose nil)

;; Update time display
;; Equivalent to: opt.updatetime = 300
(setq idle-update-delay 0.3)

;; Increase max output size for commands
(setq read-process-output-max (* 1024 1024)) ; 1MB

;; ========================================================================
;; Evil Mode Setup (Vim Emulation)
;; ========================================================================
;; Evil mode provides Vim-like editing in Emacs
;; This makes the transition from Neovim more seamless

(use-package evil
  :init
  ;; Enable evil mode before loading
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)       ; Required by evil-collection
  (setq evil-want-C-u-scroll t)         ; C-u for scrolling up
  (setq evil-want-C-d-scroll t)         ; C-d for scrolling down
  (setq evil-want-Y-yank-to-eol t)      ; Y yanks to end of line
  (setq evil-respect-visual-line-mode t) ; Better visual line movement
  (setq evil-undo-system 'undo-tree)    ; Use undo-tree
  (setq evil-search-module 'evil-search) ; Evil search
  (setq evil-split-window-below t)      ; Split below
  (setq evil-vsplit-window-right t)     ; Split right
  :config
  (evil-mode 1)
  
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  
  ;; Set initial states for certain modes
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

;; Evil collection provides evil bindings for many modes
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Undo tree for better undo/redo
;; Provides visual undo tree (similar to Neovim's undo behavior)
(use-package undo-tree
  :config
  (global-undo-tree-mode)
  (setq undo-tree-auto-save-history t))

;; ========================================================================
;; Keybindings
;; ========================================================================
;; Configure keybindings (equivalent to core/keymaps.lua)

;; ------------------------------------------------------------------------
;; Leader Key Setup
;; ------------------------------------------------------------------------
;; Set leader key to Space (equivalent to vim.g.mapleader = " ")

(use-package general
  :config
  (general-create-definer leader-def
    :states '(normal visual insert emacs)
    :prefix "SPC"
    :global-prefix "C-SPC"))

;; ------------------------------------------------------------------------
;; General Keybindings
;; ------------------------------------------------------------------------

(with-eval-after-load 'evil
  ;; Disable arrow keys to encourage hjkl usage
  ;; Equivalent to keymap.set({ "n", "i" }, "<left>", '<cmd>echo "Use h to move!!"<CR>')
  (define-key evil-normal-state-map (kbd "<left>") 
    (lambda () (interactive) (message "Use h to move!!")))
  (define-key evil-normal-state-map (kbd "<right>") 
    (lambda () (interactive) (message "Use l to move!!")))
  (define-key evil-normal-state-map (kbd "<up>") 
    (lambda () (interactive) (message "Use k to move!!")))
  (define-key evil-normal-state-map (kbd "<down>") 
    (lambda () (interactive) (message "Use j to move!!")))
  
  (define-key evil-insert-state-map (kbd "<left>") 
    (lambda () (interactive) (message "Use h to move!!")))
  (define-key evil-insert-state-map (kbd "<right>") 
    (lambda () (interactive) (message "Use l to move!!")))
  (define-key evil-insert-state-map (kbd "<up>") 
    (lambda () (interactive) (message "Use k to move!!")))
  (define-key evil-insert-state-map (kbd "<down>") 
    (lambda () (interactive) (message "Use j to move!!")))
  
  ;; Keep cursor centered when scrolling
  ;; Equivalent to: keymap.set("n", "<C-d>", "<C-d>zz")
  (define-key evil-normal-state-map (kbd "C-d") 
    (lambda () (interactive) (evil-scroll-down nil) (evil-scroll-line-to-center nil)))
  (define-key evil-normal-state-map (kbd "C-u") 
    (lambda () (interactive) (evil-scroll-up nil) (evil-scroll-line-to-center nil)))
  
  ;; Keep search centered
  ;; Equivalent to: keymap.set("n", "n", "nzzzv")
  (define-key evil-normal-state-map (kbd "n") 
    (lambda () (interactive) (evil-search-next) (evil-scroll-line-to-center nil)))
  (define-key evil-normal-state-map (kbd "N") 
    (lambda () (interactive) (evil-search-previous) (evil-scroll-line-to-center nil)))
  
  ;; Better J behavior - join lines without moving cursor
  ;; Equivalent to: keymap.set("n", "J", "mzJ`z")
  (define-key evil-normal-state-map (kbd "J")
    (lambda () (interactive) (save-excursion (evil-join (point) (1+ (point))))))
  
  ;; Redo with U
  ;; Equivalent to: keymap.set("n", "U", "<C-r>")
  (define-key evil-normal-state-map (kbd "U") 'evil-redo))

;; ------------------------------------------------------------------------
;; Leader Key Mappings
;; ------------------------------------------------------------------------

(leader-def
  ;; File operations
  "w" '(save-buffer :which-key "Save file")
  "q" '(save-buffers-kill-terminal :which-key "Quit Emacs")
  
  ;; Buffer operations
  ;; Equivalent to: keymap.set("n", "<S-h>", "<cmd>bprevious<cr>")
  "bd" '(kill-current-buffer :which-key "Delete buffer")
  
  ;; Search and replace
  ;; Equivalent to: keymap.set("n", "<leader>r", ":%s/")
  "r" '(query-replace :which-key "Replace in buffer")
  
  ;; Terminal
  ;; Equivalent to: keymap.set("n", "<leader>t", "<cmd>split | terminal<CR>")
  "t" '(eshell :which-key "Terminal")
  
  ;; Make file executable
  ;; Equivalent to: keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>")
  "x" '((lambda () (interactive) 
          (shell-command (concat "chmod +x " (buffer-file-name))))
        :which-key "Make executable"))

;; Buffer navigation
;; Equivalent to Shift+h and Shift+l for buffer switching
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "H") 'previous-buffer)
  (define-key evil-normal-state-map (kbd "L") 'next-buffer))

;; ========================================================================
;; Hooks (Autocmds)
;; ========================================================================
;; Configure hooks equivalent to core/autocmd.lua

;; ------------------------------------------------------------------------
;; Highlight on Yank
;; ------------------------------------------------------------------------
;; Equivalent to: TextYankPost autocmd

(use-package evil-goggles
  :config
  (evil-goggles-mode)
  (setq evil-goggles-duration 0.1))

;; ------------------------------------------------------------------------
;; Restore Cursor Position
;; ------------------------------------------------------------------------
;; Go to last location when opening a buffer
;; Equivalent to: BufReadPost autocmd

(save-place-mode 1)
(setq save-place-file (expand-file-name "places" user-emacs-directory))

;; ------------------------------------------------------------------------
;; Auto-resize Windows
;; ------------------------------------------------------------------------
;; Resize splits if window got resized
;; Equivalent to: VimResized autocmd

(add-hook 'window-size-change-functions
          (lambda (_frame)
            (balance-windows)))

;; ------------------------------------------------------------------------
;; Disable Auto Comments
;; ------------------------------------------------------------------------
;; Disable automatic comment continuation
;; Equivalent to: FileType autocmd for formatoptions

(setq-default comment-auto-fill-only-comments t)
(add-hook 'prog-mode-hook
          (lambda ()
            (setq-local comment-auto-fill-only-comments nil)))

;; ========================================================================
;; Theme Configuration
;; ========================================================================
;; Load and configure color themes

;; Enable true color support
;; Equivalent to: opt.termguicolors = true
(unless (display-graphic-p)
  (xterm-mouse-mode 1))

;; ========================================================================
;; Plugin Configurations
;; ========================================================================
;; Configure all plugins (equivalent to lua/plugins/)

;; ------------------------------------------------------------------------
;; Which-key: Show available keybindings
;; ------------------------------------------------------------------------
;; Displays available keybindings in a popup

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; ========================================================================
;; Load Additional Configuration Files
;; ========================================================================

;; Load plugin configurations from separate files
;; This keeps init.el organized and modular

;; Load custom Lisp files if they exist
(when (file-exists-p (expand-file-name "lisp" user-emacs-directory))
  (add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
  (add-to-list 'load-path (expand-file-name "lisp/plugins" user-emacs-directory)))

;; Load plugin configurations
;; Similar to how Neovim loads plugins from lua/plugins/

;; Load theme configuration (equivalent to theme.lua)
(require 'theme nil t)

;; Load completion configuration (equivalent to blink.lua)
(require 'completion nil t)

;; Load LSP configuration (equivalent to lspconfig.lua)
(require 'lsp nil t)

;; Load tree-sitter configuration (equivalent to treesitter.lua)
(require 'treesitter nil t)

;; Load modeline configuration (equivalent to lualine.lua)
(require 'modeline nil t)

;; Load fuzzy finder configuration (equivalent to snacks.lua picker)
(require 'fuzzy-finder nil t)

;; Load git integration (equivalent to gitsigns.lua)
(require 'git nil t)

;; Load utility plugins (surround, comment, colorizer, oil, trouble, conform)
(require 'utilities nil t)

;; Load Copilot configuration (equivalent to copilot.lua)
(require 'copilot nil t)

;; Load markdown configuration (equivalent to markdown.lua)
(require 'markdown nil t)

;; Load Arabic support (from keymaps.lua and options.lua)
(require 'arabic nil t)

;; ========================================================================
;; Final Setup Message
;; ========================================================================

(message "Emacs configuration loaded successfully!")
(message "This configuration mirrors the Neovim setup from .config/nvim/")
(message "Leader key: SPC (in normal/visual mode) or C-SPC (globally)")

;;; init.el ends here
