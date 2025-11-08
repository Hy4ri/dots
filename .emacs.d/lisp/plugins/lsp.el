;;; lsp.el --- LSP configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2024

;; Author: Hy4ri
;; Keywords: lsp, language-server

;;; Commentary:

;; LSP (Language Server Protocol) configuration for Emacs
;; Mirroring the Neovim LSP setup from .config/nvim/lua/plugins/lspconfig.lua
;;
;; Neovim uses:
;; - nvim-lspconfig for LSP client
;; - mason.nvim for LSP server management
;; - mason-lspconfig.nvim for integration
;;
;; Emacs equivalent:
;; - lsp-mode or eglot for LSP client
;; - Manual server installation or use built-in server management

;;; Code:

;; ========================================================================
;; LSP Mode Configuration
;; ========================================================================
;; lsp-mode is a comprehensive LSP client for Emacs
;; Equivalent to nvim-lspconfig in Neovim

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((python-mode . lsp-deferred)
         (lua-mode . lsp-deferred)
         (sh-mode . lsp-deferred)
         (json-mode . lsp-deferred)
         (yaml-mode . lsp-deferred)
         (markdown-mode . lsp-deferred)
         (html-mode . lsp-deferred)
         (css-mode . lsp-deferred)
         (php-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :init
  ;; Set prefix for lsp-command-keymap (few alternatives - "C-c l", "C-l", "s-l")
  (setq lsp-keymap-prefix "C-c l")
  :config
  ;; Performance tuning
  (setq lsp-idle-delay 0.5)              ; Equivalent to updatetime = 300
  (setq lsp-log-io nil)                  ; Disable logging for performance
  (setq lsp-enable-file-watchers nil)    ; Disable file watchers
  (setq lsp-enable-folding t)            ; Enable folding
  (setq lsp-enable-snippet t)            ; Enable snippet support
  (setq lsp-enable-symbol-highlighting t) ; Enable symbol highlighting
  
  ;; Breadcrumb (shows current position in code)
  (setq lsp-headerline-breadcrumb-enable t)
  
  ;; Modeline integration
  (setq lsp-modeline-code-actions-enable t)
  (setq lsp-modeline-diagnostics-enable t)
  
  ;; Completion settings
  ;; Equivalent to completion capabilities from blink.cmp
  (setq lsp-completion-provider :capf)
  (setq lsp-completion-show-detail t)
  (setq lsp-completion-show-kind t)
  
  ;; Diagnostics configuration
  ;; Equivalent to vim.diagnostic.config() in Neovim
  (setq lsp-diagnostics-provider :auto)
  (setq lsp-diagnostics-flycheck-default-level 'error)
  
  ;; Signature help
  ;; Equivalent to: signature = { enabled = false } (but we enable it)
  (setq lsp-signature-auto-activate t)
  (setq lsp-signature-render-documentation t)
  
  ;; Lens (inline hints)
  (setq lsp-lens-enable t)
  
  ;; Semantic tokens
  (setq lsp-semantic-tokens-enable t))

;; ========================================================================
;; LSP UI Enhancements
;; ========================================================================
;; lsp-ui provides additional UI features for lsp-mode
;; Adds sideline information, documentation popups, etc.

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :config
  ;; Sideline configuration
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-sideline-update-mode 'point)
  
  ;; Documentation popup
  ;; Equivalent to documentation auto_show in blink.lua
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-position 'at-point)
  (setq lsp-ui-doc-delay 0.5)
  (setq lsp-ui-doc-show-with-cursor t)
  (setq lsp-ui-doc-show-with-mouse t)
  
  ;; Peek (definitions/references in popup)
  (setq lsp-ui-peek-enable t)
  (setq lsp-ui-peek-show-directory t)
  
  ;; Keybindings for lsp-ui
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

;; ========================================================================
;; LSP Treemacs Integration
;; ========================================================================
;; Provides tree view for symbols, errors, etc.

(use-package lsp-treemacs
  :after (lsp-mode treemacs)
  :commands lsp-treemacs-errors-list)

;; ========================================================================
;; LSP Servers Configuration
;; ========================================================================
;; Configure specific language servers
;; Equivalent to the servers table in lspconfig.lua

;; Lua Language Server
;; Equivalent to lua_ls configuration
(with-eval-after-load 'lsp-mode
  (setq lsp-lua-completion-call-snippet "Replace"))

;; ========================================================================
;; DAP Mode (Debugging)
;; ========================================================================
;; DAP (Debug Adapter Protocol) support
;; Optional but useful for debugging

(use-package dap-mode
  :after lsp-mode
  :commands dap-debug
  :config
  (dap-auto-configure-mode))

;; ========================================================================
;; LSP Keybindings
;; ========================================================================
;; Set up keybindings for LSP functions
;; Equivalent to the keymaps in the LspAttach autocmd

(with-eval-after-load 'lsp-mode
  (define-key lsp-mode-map (kbd "C-c l r") 'lsp-rename)
  (define-key lsp-mode-map (kbd "C-c l a") 'lsp-execute-code-action)
  (define-key lsp-mode-map (kbd "C-c l f") 'lsp-format-buffer)
  (define-key lsp-mode-map (kbd "C-c l d") 'lsp-find-definition)
  (define-key lsp-mode-map (kbd "C-c l D") 'lsp-find-declaration)
  (define-key lsp-mode-map (kbd "C-c l i") 'lsp-find-implementation)
  (define-key lsp-mode-map (kbd "C-c l t") 'lsp-find-type-definition)
  (define-key lsp-mode-map (kbd "C-c l R") 'lsp-find-references)
  (define-key lsp-mode-map (kbd "C-c l h") 'lsp-describe-thing-at-point))

;; ========================================================================
;; Inlay Hints Toggle
;; ========================================================================
;; Toggle inlay hints (type hints, parameter names, etc.)
;; Equivalent to: map("<leader>th", function() ... end, "Toggle Inlay Hints")

(defun toggle-lsp-inlay-hints ()
  "Toggle LSP inlay hints.
Equivalent to vim.lsp.inlay_hint.enable() toggle in Neovim."
  (interactive)
  (if (bound-and-true-p lsp-inlay-hints-mode)
      (lsp-inlay-hints-mode -1)
    (lsp-inlay-hints-mode 1))
  (message "LSP inlay hints %s" (if (bound-and-true-p lsp-inlay-hints-mode) "enabled" "disabled")))

;; Add to leader key
(with-eval-after-load 'general
  (leader-def
    "th" '(toggle-lsp-inlay-hints :which-key "Toggle inlay hints")))

;; ========================================================================
;; Document Highlight on Cursor Hold
;; ========================================================================
;; Highlight symbol references under cursor
;; Equivalent to the documentHighlight autocmds in Neovim

(add-hook 'lsp-mode-hook
          (lambda ()
            (when (lsp-feature? "textDocument/documentHighlight")
              (add-hook 'post-command-hook #'lsp-document-highlight nil t))))

;; ========================================================================
;; Diagnostic Display Settings
;; ========================================================================
;; Configure how diagnostics are displayed
;; Equivalent to vim.diagnostic.config() in Neovim

(with-eval-after-load 'lsp-mode
  ;; Set diagnostic symbols
  ;; Equivalent to the signs configuration with Nerd Font icons
  (setq lsp-diagnostics-attributes
        `((unnecessary :foreground "gray")
          (deprecated :strike-through t)))
  
  ;; Configure virtual text (inline diagnostics)
  ;; Equivalent to virtual_text settings
  (setq lsp-ui-sideline-diagnostic-max-line-length 100)
  (setq lsp-ui-sideline-diagnostic-max-lines 5))

;; ========================================================================
;; LSP Server Installation Helpers
;; ========================================================================
;; Helper functions to install LSP servers
;; Equivalent to Mason's ensure_installed functionality

(defun install-lua-lsp ()
  "Install Lua language server (lua-language-server).
Run this function to install the Lua LSP server manually."
  (interactive)
  (message "Please install lua-language-server using your package manager")
  (message "  macOS: brew install lua-language-server")
  (message "  Linux: Install via your distro's package manager")
  (message "  Or download from: https://github.com/LuaLS/lua-language-server"))

(defun install-python-lsp ()
  "Install Python language server (pyright).
Run this function to see instructions for installing Python LSP."
  (interactive)
  (message "Install Python LSP server with: pip install pyright")
  (message "Or use: pip install python-lsp-server"))

(defun install-bash-lsp ()
  "Install Bash language server.
Run this function to see instructions for installing Bash LSP."
  (interactive)
  (message "Install Bash language server with: npm install -g bash-language-server"))

(provide 'lsp)
;;; lsp.el ends here
