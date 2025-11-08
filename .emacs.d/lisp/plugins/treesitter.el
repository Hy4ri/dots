;;; treesitter.el --- Tree-sitter configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2024

;; Author: Hy4ri
;; Keywords: treesitter, syntax

;;; Commentary:

;; Tree-sitter configuration for Emacs
;; Mirroring the Neovim tree-sitter setup from .config/nvim/lua/plugins/treesitter.lua
;;
;; Tree-sitter provides better syntax highlighting and code understanding
;; Uses incremental parsing for better performance

;;; Code:

;; ========================================================================
;; Tree-sitter Setup (Emacs 29+)
;; ========================================================================
;; Emacs 29 includes built-in tree-sitter support
;; For older versions, use tree-sitter.el package

(use-package treesit
  :straight (:type built-in)
  :when (and (fboundp 'treesit-available-p)
             (treesit-available-p))
  :config
  ;; Enable tree-sitter based major modes when available
  ;; These modes provide better syntax highlighting and indentation
  (setq major-mode-remap-alist
        '((python-mode . python-ts-mode)
          (js-mode . js-ts-mode)
          (typescript-mode . typescript-ts-mode)
          (json-mode . json-ts-mode)
          (css-mode . css-ts-mode)
          (yaml-mode . yaml-ts-mode)
          (bash-mode . bash-ts-mode)
          (sh-mode . bash-ts-mode))))

;; ========================================================================
;; Tree-sitter Language Grammar Installation
;; ========================================================================
;; Automatically install tree-sitter language grammars
;; Equivalent to ensure_installed and auto_install in nvim-treesitter

(defvar treesit-language-source-alist
  '((bash "https://github.com/tree-sitter/tree-sitter-bash")
    (css "https://github.com/tree-sitter/tree-sitter-css")
    (html "https://github.com/tree-sitter/tree-sitter-html")
    (javascript "https://github.com/tree-sitter/tree-sitter-javascript")
    (json "https://github.com/tree-sitter/tree-sitter-json")
    (lua "https://github.com/Azganoth/tree-sitter-lua")
    (markdown "https://github.com/ikatyang/tree-sitter-markdown")
    (python "https://github.com/tree-sitter/tree-sitter-python")
    (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
    (yaml "https://github.com/ikatyang/tree-sitter-yaml"))
  "List of tree-sitter language grammar sources.
Equivalent to ensure_installed in nvim-treesitter config:
  ensure_installed = { 'lua', 'bash', 'json', 'yaml', 'markdown',
                       'markdown_inline', 'html', 'xml', 'php',
                       'css', 'python' }")

;; Function to install all language grammars
(defun install-treesit-grammars ()
  "Install all configured tree-sitter language grammars.
Equivalent to :TSUpdate in Neovim.
This may take a few minutes on first run."
  (interactive)
  (message "Installing tree-sitter language grammars...")
  (dolist (lang treesit-language-source-alist)
    (unless (treesit-language-available-p (car lang))
      (message "Installing grammar for %s..." (car lang))
      (treesit-install-language-grammar (car lang))))
  (message "Tree-sitter grammar installation complete!"))

;; Auto-install missing grammars when opening a file
;; Equivalent to auto_install = true
(defun auto-install-treesit-grammar ()
  "Automatically install tree-sitter grammar for current buffer if missing."
  (when (and (treesit-available-p)
             (treesit-language-available-p (treesit-parser-language (treesit-parser-create (intern (buffer-local-value 'major-mode (current-buffer)))))))
    (let ((lang (treesit-parser-language (treesit-parser-create (intern (buffer-local-value 'major-mode (current-buffer)))))))
      (unless (treesit-language-available-p lang)
        (message "Installing missing tree-sitter grammar for %s..." lang)
        (treesit-install-language-grammar lang)))))

;; ========================================================================
;; Tree-sitter.el (for Emacs < 29)
;; ========================================================================
;; Use tree-sitter.el package for older Emacs versions
;; Provides similar functionality to built-in tree-sitter

(use-package tree-sitter
  :unless (and (fboundp 'treesit-available-p)
               (treesit-available-p))
  :hook ((python-mode lua-mode sh-mode json-mode yaml-mode) . tree-sitter-mode)
  :config
  ;; Enable syntax highlighting with tree-sitter
  ;; Equivalent to: highlight = { enable = true }
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; Tree-sitter language grammars
(use-package tree-sitter-langs
  :unless (and (fboundp 'treesit-available-p)
               (treesit-available-p))
  :after tree-sitter
  :config
  ;; Automatically download and compile language grammars
  ;; Equivalent to auto_install = true
  (tree-sitter-require 'python)
  (tree-sitter-require 'lua)
  (tree-sitter-require 'bash)
  (tree-sitter-require 'json)
  (tree-sitter-require 'yaml)
  (tree-sitter-require 'css)
  (tree-sitter-require 'html))

;; ========================================================================
;; Enhanced Syntax Highlighting
;; ========================================================================
;; Additional packages for better syntax highlighting

;; Rainbow delimiters - colorize matching brackets
;; Helps visualize code structure (complementary to tree-sitter)
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Highlight TODO and similar keywords
;; Equivalent to todo-comments.nvim plugin
(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :config
  ;; Define keywords to highlight
  ;; Similar to todo-comments.nvim keywords
  (setq hl-todo-keyword-faces
        '(("TODO"   . "#EBCB8B")
          ("FIXME"  . "#BF616A")
          ("NOTE"   . "#A3BE8C")
          ("HACK"   . "#D08770")
          ("WARN"   . "#EBCB8B")
          ("WARNING" . "#EBCB8B")
          ("XXX"    . "#BF616A")
          ("BUG"    . "#BF616A"))))

;; ========================================================================
;; Indentation with Tree-sitter
;; ========================================================================
;; Tree-sitter provides better auto-indentation
;; Equivalent to: indent = { enable = true }

;; Aggressive indent mode for automatic indentation
(use-package aggressive-indent
  :hook (prog-mode . aggressive-indent-mode)
  :config
  ;; Don't indent in these modes
  (add-to-list 'aggressive-indent-excluded-modes 'python-mode))

;; ========================================================================
;; Compiler Check
;; ========================================================================
;; Warn if required compilers are missing
;; Equivalent to the gcc/make check in treesitter.lua

(defun check-treesit-compilers ()
  "Check if required compilers for tree-sitter are installed.
Equivalent to checking for gcc and make in Neovim config."
  (interactive)
  (let ((missing '()))
    (unless (executable-find "gcc")
      (push "gcc" missing))
    (unless (executable-find "make")
      (push "make" missing))
    (when missing
      (message "⚠️ Tree-sitter: Missing compilers: %s. Grammar compilation may fail."
               (string-join missing ", "))
      (message "Install with: sudo apt install build-essential (or equivalent)"))))

;; Run compiler check on startup
(add-hook 'emacs-startup-hook #'check-treesit-compilers)

;; ========================================================================
;; Language-specific Tree-sitter Configurations
;; ========================================================================

;; Python tree-sitter configuration
(add-hook 'python-ts-mode-hook
          (lambda ()
            ;; Enable additional features with tree-sitter
            (setq-local indent-tabs-mode nil)
            (setq-local tab-width 4)))

;; Lua tree-sitter configuration
(add-hook 'lua-ts-mode-hook
          (lambda ()
            (setq-local indent-tabs-mode nil)
            (setq-local tab-width 2)))

;; Bash tree-sitter configuration
(add-hook 'bash-ts-mode-hook
          (lambda ()
            (setq-local indent-tabs-mode nil)
            (setq-local tab-width 2)))

(provide 'treesitter)
;;; treesitter.el ends here
