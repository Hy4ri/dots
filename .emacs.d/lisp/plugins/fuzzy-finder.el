;;; fuzzy-finder.el --- Fuzzy finder configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2024

;; Author: Hy4ri
;; Keywords: fuzzy-finder, search

;;; Commentary:

;; Fuzzy finder configuration for Emacs
;; Mirroring the Neovim snacks.picker setup from .config/nvim/lua/plugins/snacks.lua
;;
;; Neovim uses snacks.nvim for file/buffer picking
;; Emacs equivalent: vertico + consult + orderless

;;; Code:

;; ========================================================================
;; Vertico (Vertical completion UI)
;; ========================================================================
;; Vertico provides a minimalist vertical completion UI
;; Base for modern completion interface in Emacs

(use-package vertico
  :init
  (vertico-mode)
  :config
  ;; Cycle through candidates
  (setq vertico-cycle t)
  ;; Show more candidates
  (setq vertico-count 20))

;; ========================================================================
;; Orderless (Flexible matching)
;; ========================================================================
;; Orderless provides flexible matching for completions
;; Allows space-separated patterns in any order

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; ========================================================================
;; Marginalia (Rich annotations)
;; ========================================================================
;; Marginalia adds helpful annotations to completion candidates
;; Shows file sizes, dates, documentation, etc.

(use-package marginalia
  :init
  (marginalia-mode)
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle)))

;; ========================================================================
;; Consult (Enhanced commands)
;; ========================================================================
;; Consult provides enhanced versions of Emacs commands
;; Equivalent to snacks.picker functions in Neovim

(use-package consult
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ; orig. bookmark-jump
         
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ; orig. abbrev-prefix-mark
         ("C-M-#" . consult-register)
         
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ; orig. yank-pop
         
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ; orig. goto-line
         ("M-g o" . consult-outline)               ; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ; needed by consult-line to detect isearch
         
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ; orig. next-matching-history-element
         ("M-r" . consult-history))                ; orig. previous-matching-history-element
  
  :hook (completion-list-mode . consult-preview-at-point-mode)
  
  :init
  ;; Optionally configure the register formatting
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  
  ;; Optionally tweak the register preview window
  (advice-add #'register-preview :override #'consult-register-window)
  
  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  
  :config
  ;; Configure preview
  (setq consult-preview-key 'any)
  (consult-customize
   consult-theme
   :preview-key '(:debounce 0.2 any))
  
  ;; Use ripgrep for faster search if available
  (when (executable-find "rg")
    (setq consult-ripgrep-args "rg --null --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --no-heading --with-filename --line-number --search-zip")))

;; ========================================================================
;; Embark (Contextual actions)
;; ========================================================================
;; Embark provides contextual actions on completion candidates
;; Like a right-click menu for minibuffer completions

(use-package embark
  :bind
  (("C-." . embark-act)         ; Pick some comfortable binding
   ("C-;" . embark-dwim)        ; Good alternative: M-.
   ("C-h B" . embark-bindings)) ; Alternative for `describe-bindings'
  
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; ========================================================================
;; Leader Key Bindings for Fuzzy Finder
;; ========================================================================
;; Map leader key combinations to fuzzy finder functions
;; Equivalent to snacks picker keymaps in Neovim

(with-eval-after-load 'general
  (leader-def
    ;; Pickers (equivalent to snacks.picker functions)
    "sp" '(execute-extended-command :which-key "Command picker")
    "sb" '(consult-buffer :which-key "Buffer picker")
    "sf" '(project-find-file :which-key "Files picker")
    "sg" '(consult-ripgrep :which-key "Grep picker")
    "ss" '(ispell-word :which-key "Spelling picker")
    "so" '(consult-recent-file :which-key "Recent files picker")
    
    ;; File explorer
    ;; Equivalent to: function() Snacks.explorer() end
    "e" '(dired-jump :which-key "File explorer")
    "fe" '(dired-jump :which-key "File explorer")))

;; ========================================================================
;; Project.el Integration
;; ========================================================================
;; Enhanced project management
;; Works with fuzzy finder for project-wide searches

(use-package project
  :straight (:type built-in)
  :config
  ;; Set project search path
  (setq project-switch-commands
        '((project-find-file "Find file")
          (project-find-regexp "Find regexp")
          (project-dired "Dired")
          (magit-project-status "Magit"))))

;; ========================================================================
;; Recentf (Recent files)
;; ========================================================================
;; Track recently opened files
;; Used by consult-recent-file

(use-package recentf
  :straight (:type built-in)
  :init
  (recentf-mode 1)
  :config
  (setq recentf-max-saved-items 100)
  (setq recentf-max-menu-items 15)
  ;; Exclude some files from recent list
  (add-to-list 'recentf-exclude "/tmp/")
  (add-to-list 'recentf-exclude "/ssh:"))

;; ========================================================================
;; Savehist (Save minibuffer history)
;; ========================================================================
;; Persist minibuffer history between sessions

(use-package savehist
  :straight (:type built-in)
  :init
  (savehist-mode 1)
  :config
  (setq history-length 1000)
  (setq savehist-additional-variables
        '(search-ring regexp-search-ring)))

(provide 'fuzzy-finder)
;;; fuzzy-finder.el ends here
