;;; completion.el --- Completion configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2024

;; Author: Hy4ri
;; Keywords: completion, company

;;; Commentary:

;; Completion configuration for Emacs, mirroring the Neovim completion setup
;; from .config/nvim/lua/plugins/blink.lua
;;
;; Neovim uses:
;; - blink.cmp for completion
;; - LuaSnip for snippets
;; - friendly-snippets for snippet collection
;;
;; Emacs equivalent:
;; - company-mode for completion
;; - yasnippet for snippets
;; - yasnippet-snippets for snippet collection

;;; Code:

;; ========================================================================
;; Company Mode (Completion)
;; ========================================================================
;; Company (Complete Anything) provides text completion
;; Equivalent to blink.cmp in Neovim

(use-package company
  :diminish company-mode
  :hook (after-init . global-company-mode)
  :config
  ;; Basic company settings
  (setq company-minimum-prefix-length 1)  ; Start completion after 1 character
  (setq company-idle-delay 0.2)           ; Delay before showing completions (200ms)
  (setq company-show-quick-access t)      ; Show numbers for quick selection
  (setq company-selection-wrap-around t)  ; Wrap around in completion list
  
  ;; Completion behavior - equivalent to completion settings in blink.lua
  (setq company-require-match nil)        ; Don't require match (noselect)
  (setq company-auto-commit nil)          ; Don't auto-commit
  
  ;; Better sorting and filtering
  (setq company-transformers '(company-sort-by-occurrence))
  
  ;; Backend configuration
  ;; Equivalent to: sources = { default = { "lsp", "snippets", "path", "lazydev", "buffer" } }
  (setq company-backends
        '((company-capf           ; LSP and other completion-at-point backends
           company-yasnippet      ; Snippets
           company-files          ; File paths
           company-dabbrev-code   ; Code completion from open buffers
           company-keywords)      ; Language keywords
          (company-dabbrev)))     ; General text completion
  
  ;; Keybindings for company
  ;; Similar to 'super-tab' preset in blink.lua
  (define-key company-active-map (kbd "TAB") 'company-complete-selection)
  (define-key company-active-map (kbd "<tab>") 'company-complete-selection)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "C-d") 'company-show-doc-buffer)
  (define-key company-active-map (kbd "M-.") 'company-show-location))

;; ========================================================================
;; Company Box (Better UI)
;; ========================================================================
;; Provides a nicer UI for company-mode with icons
;; Equivalent to the appearance settings in blink.lua

(use-package company-box
  :hook (company-mode . company-box-mode)
  :config
  ;; Enable icons (equivalent to nerd_font_variant = "mono")
  (setq company-box-icons-alist 'company-box-icons-all-the-icons)
  (setq company-box-show-single-candidate t)
  (setq company-box-max-candidates 50)
  
  ;; Documentation display
  ;; Equivalent to: documentation = { auto_show = true, auto_show_delay_ms = 200 }
  (setq company-box-doc-enable t)
  (setq company-box-doc-delay 0.2))

;; ========================================================================
;; YASnippet (Snippets)
;; ========================================================================
;; YASnippet provides snippet expansion
;; Equivalent to LuaSnip in Neovim

(use-package yasnippet
  :diminish yas-minor-mode
  :hook (prog-mode . yas-minor-mode)
  :config
  ;; Enable yasnippet globally
  (yas-global-mode 1)
  
  ;; Keybindings for snippet expansion
  ;; These integrate with company-mode
  (define-key yas-minor-mode-map (kbd "C-c y") 'yas-expand)
  (define-key yas-minor-mode-map (kbd "C-c C-y") 'yas-expand))

;; ========================================================================
;; YASnippet Snippets Collection
;; ========================================================================
;; Collection of snippets for various languages
;; Equivalent to friendly-snippets in Neovim

(use-package yasnippet-snippets
  :after yasnippet
  :config
  ;; Load snippets from the collection
  ;; Equivalent to: require("luasnip.loaders.from_vscode").lazy_load()
  (yasnippet-snippets-initialize))

;; ========================================================================
;; Company YASnippet Integration
;; ========================================================================
;; Ensures snippets appear in company completion

(defun company-yasnippet-or-completion ()
  "Complete with yasnippet if possible, otherwise use company."
  (interactive)
  (or (yas-expand)
      (company-complete-common)))

;; ========================================================================
;; Auto-bracket Completion
;; ========================================================================
;; Automatically insert matching brackets
;; Equivalent to: accept = { auto_brackets = { enabled = true } }

(use-package elec-pair
  :straight (:type built-in)
  :config
  (electric-pair-mode 1))

;; ========================================================================
;; Fuzzy Matching
;; ========================================================================
;; Improve completion matching with fuzzy search
;; Equivalent to: fuzzy = { implementation = "lua" }

(use-package company-fuzzy
  :hook (company-mode . company-fuzzy-mode)
  :config
  (setq company-fuzzy-sorting-backend 'flx)
  (setq company-fuzzy-prefix-on-top nil)
  (setq company-fuzzy-trigger-symbols '("." "->" "<" "\"" "'" "@")))

;; Alternative: orderless for better fuzzy matching
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(provide 'completion)
;;; completion.el ends here
