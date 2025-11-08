;;; utilities.el --- Utility plugins configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2024

;; Author: Hy4ri
;; Keywords: utilities, tools

;;; Commentary:

;; Utility plugins configuration for Emacs
;; Mirroring various Neovim utility plugins:
;; - surround.lua -> evil-surround
;; - comment.lua -> evil-nerd-commenter
;; - colorizer.lua -> rainbow-mode
;; - oil.lua -> dired enhancements
;; - trouble.lua -> flycheck
;; - conform.lua -> format-all

;;; Code:

;; ========================================================================
;; Evil Surround (Text object manipulation)
;; ========================================================================
;; Provides commands to manipulate surrounding delimiters
;; Equivalent to nvim-surround in Neovim

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1)
  
  ;; Add custom surround pairs
  ;; Example: Use 'f' for function calls
  (add-to-list 'evil-surround-pairs-alist
               '(?f . ("(" . ")"))))

;; ========================================================================
;; Evil Nerd Commenter (Commenting)
;; ========================================================================
;; Smart commenting for various file types
;; Equivalent to Comment.nvim in Neovim

(use-package evil-nerd-commenter
  :after evil
  :bind (("M-;" . evilnc-comment-or-uncomment-lines)
         :map evil-normal-state-map
         ("gc" . evilnc-comment-operator)
         ("gC" . evilnc-copy-and-comment-operator))
  :config
  ;; Comment line with gcc in normal mode
  (define-key evil-normal-state-map "gcc" 'evilnc-comment-or-uncomment-lines)
  (define-key evil-visual-state-map "gc" 'evilnc-comment-or-uncomment-lines))

;; ========================================================================
;; Rainbow Mode (Color visualization)
;; ========================================================================
;; Display color codes with their actual colors
;; Equivalent to nvim-colorizer.lua in Neovim

(use-package rainbow-mode
  :diminish rainbow-mode
  :hook ((css-mode . rainbow-mode)
         (html-mode . rainbow-mode)
         (sass-mode . rainbow-mode)
         (conf-mode . rainbow-mode))
  :config
  ;; Enable in all programming modes
  (add-hook 'prog-mode-hook
            (lambda ()
              (when (string-match-p "color\\|css\\|html" (symbol-name major-mode))
                (rainbow-mode 1)))))

;; ========================================================================
;; Format All (Code formatting)
;; ========================================================================
;; Automatically format code using various formatters
;; Equivalent to conform.nvim in Neovim

(use-package format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  ;; Format on save
  (setq format-all-formatters
        '(("Python" (black))
          ("Shell" (shfmt))
          ("Lua" (stylua))
          ("JavaScript" (prettier))
          ("TypeScript" (prettier))
          ("JSON" (prettier))
          ("HTML" (prettier))
          ("CSS" (prettier))
          ("Markdown" (prettier))))
  
  ;; Don't format on save for certain modes
  (setq format-all-show-errors 'warnings))

;; Alternative: Apheleia for async formatting
(use-package apheleia
  :config
  (apheleia-global-mode +1)
  
  ;; Configure formatters
  (setf (alist-get 'python-mode apheleia-mode-alist) 'black)
  (setf (alist-get 'lua-mode apheleia-mode-alist) 'stylua)
  (setf (alist-get 'sh-mode apheleia-mode-alist) 'shfmt))

;; ========================================================================
;; Dired Enhancements (File explorer)
;; ========================================================================
;; Enhanced file management with dired
;; Equivalent to oil.nvim in Neovim

(use-package dired
  :straight (:type built-in)
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump)
         :map dired-mode-map
         ;; Use 'h' to go up, 'l' to open (vim-like)
         ("h" . dired-up-directory)
         ("l" . dired-find-file))
  :config
  ;; Show human-readable file sizes
  (setq dired-listing-switches "-alh --group-directories-first")
  
  ;; Auto-refresh dired on file changes
  (setq dired-auto-revert-buffer t)
  
  ;; Copy and move files between dired buffers
  (setq dired-dwim-target t)
  
  ;; Hide details by default
  (add-hook 'dired-mode-hook 'dired-hide-details-mode))

;; Dired icons
(use-package all-the-icons-dired
  :if (display-graphic-p)
  :hook (dired-mode . all-the-icons-dired-mode))

;; Dired sidebar
(use-package dired-sidebar
  :commands (dired-sidebar-toggle-sidebar)
  :config
  (setq dired-sidebar-width 35)
  (setq dired-sidebar-theme 'icons))

;; ========================================================================
;; Flycheck (Syntax checking)
;; ========================================================================
;; On-the-fly syntax checking
;; Equivalent to diagnostics display in Neovim (trouble.nvim)

(use-package flycheck
  :hook (prog-mode . flycheck-mode)
  :config
  ;; Check on save and new line
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  
  ;; Display errors in a nice format
  (setq flycheck-display-errors-delay 0.3)
  
  ;; Use fringe indicators
  (setq flycheck-indication-mode 'left-fringe)
  
  ;; Error navigation keybindings
  (define-key flycheck-mode-map (kbd "M-n") 'flycheck-next-error)
  (define-key flycheck-mode-map (kbd "M-p") 'flycheck-previous-error))

;; Flycheck inline (show errors inline)
(use-package flycheck-inline
  :after flycheck
  :hook (flycheck-mode . flycheck-inline-mode))

;; ========================================================================
;; Flymake (Alternative to Flycheck)
;; ========================================================================
;; Built-in syntax checking (lighter than flycheck)
;; Can be used instead of flycheck

(use-package flymake
  :straight (:type built-in)
  :bind (:map flymake-mode-map
              ("M-n" . flymake-goto-next-error)
              ("M-p" . flymake-goto-prev-error)))

;; ========================================================================
;; Which Function Mode (Show current function in modeline)
;; ========================================================================
;; Display current function name in modeline

(use-package which-func
  :straight (:type built-in)
  :config
  (which-function-mode 1)
  (setq which-func-unknown "n/a"))

;; ========================================================================
;; Whitespace Cleanup
;; ========================================================================
;; Automatically clean up whitespace on save

(use-package ws-butler
  :hook (prog-mode . ws-butler-mode)
  :config
  ;; Only cleanup lines that were edited
  (setq ws-butler-keep-whitespace-before-point nil))

;; ========================================================================
;; Smartparens (Intelligent parentheses handling)
;; ========================================================================
;; Smart handling of parentheses, brackets, quotes
;; Works alongside electric-pair-mode

(use-package smartparens
  :hook (prog-mode . smartparens-mode)
  :config
  (require 'smartparens-config)
  
  ;; Highlight matching parens
  (show-smartparens-global-mode t)
  
  ;; Keybindings for slurp/barf
  (define-key smartparens-mode-map (kbd "C-M-f") 'sp-forward-sexp)
  (define-key smartparens-mode-map (kbd "C-M-b") 'sp-backward-sexp))

;; ========================================================================
;; Multiple Cursors
;; ========================================================================
;; Edit multiple locations simultaneously

(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)
         ("C-S-c C-S-c" . mc/edit-lines)))

;; ========================================================================
;; Helpful (Better help buffers)
;; ========================================================================
;; Enhanced help buffers with more information

(use-package helpful
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h C" . helpful-command)
         ("C-c C-d" . helpful-at-point)))

;; ========================================================================
;; Leader Key Bindings for Utilities
;; ========================================================================

(with-eval-after-load 'general
  (leader-def
    ;; Format
    "f" '(format-all-buffer :which-key "Format buffer")
    
    ;; Diagnostics (equivalent to trouble.nvim)
    "xx" '(flycheck-list-errors :which-key "List errors")
    "xn" '(flycheck-next-error :which-key "Next error")
    "xp" '(flycheck-previous-error :which-key "Previous error")
    
    ;; Toggle utilities
    "u" '(:ignore t :which-key "toggle")
    "uw" '(toggle-truncate-lines :which-key "Toggle wrap")
    "ul" '(display-line-numbers-mode :which-key "Toggle line numbers")
    "ud" '(flycheck-mode :which-key "Toggle diagnostics")))

;; ========================================================================
;; Make Script Executable
;; ========================================================================
;; Automatically make shell scripts executable
;; Equivalent to: keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>")

(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)

(provide 'utilities)
;;; utilities.el ends here
