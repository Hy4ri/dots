;;; markdown.el --- Markdown configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2024

;; Author: Hy4ri
;; Keywords: markdown

;;; Commentary:

;; Markdown configuration for Emacs
;; Mirroring the Neovim markdown setup from .config/nvim/lua/plugins/markdown.lua
;;
;; Provides enhanced markdown editing and rendering

;;; Code:

;; ========================================================================
;; Markdown Mode
;; ========================================================================
;; Major mode for editing Markdown files

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  ;; Use GitHub Flavored Markdown for README files
  (setq markdown-command "multimarkdown")
  :config
  ;; Enable syntax highlighting in code blocks
  (setq markdown-fontify-code-blocks-natively t)
  
  ;; Enable wiki links
  (setq markdown-enable-wiki-links t)
  
  ;; Enable math support
  (setq markdown-enable-math t)
  
  ;; Header scaling
  (setq markdown-header-scaling t)
  
  ;; Asymmetric header
  (setq markdown-asymmetric-header t)
  
  ;; Keybindings
  (define-key markdown-mode-map (kbd "C-c C-e") 'markdown-do)
  (define-key markdown-mode-map (kbd "C-c C-l") 'markdown-insert-link)
  (define-key markdown-mode-map (kbd "C-c C-i") 'markdown-insert-image))

;; ========================================================================
;; Markdown Preview
;; ========================================================================
;; Live preview of Markdown files in browser

(use-package markdown-preview-mode
  :commands (markdown-preview-mode markdown-preview-open-browser)
  :config
  ;; Auto-scroll preview with cursor
  (setq markdown-preview-auto-open nil)
  (setq markdown-preview-stylesheets
        '("https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.1.0/github-markdown.min.css")))

;; Alternative: grip-mode for GitHub-style preview
(use-package grip-mode
  :commands (grip-mode)
  :config
  ;; Use GitHub API for rendering
  (setq grip-preview-use-webkit t))

;; ========================================================================
;; Markdown TOC (Table of Contents)
;; ========================================================================
;; Automatically generate and update TOC

(use-package markdown-toc
  :after markdown-mode
  :commands (markdown-toc-generate-toc markdown-toc-refresh-toc)
  :config
  ;; Auto-update TOC on save
  (add-hook 'markdown-mode-hook
            (lambda ()
              (when (and (buffer-file-name)
                         (string-match-p "README\\.md\\'" (buffer-file-name)))
                (add-hook 'before-save-hook 'markdown-toc-refresh-toc nil t)))))

;; ========================================================================
;; Olivetti Mode (Distraction-free writing)
;; ========================================================================
;; Center text for better reading/writing experience

(use-package olivetti
  :commands olivetti-mode
  :hook (markdown-mode . olivetti-mode)
  :config
  (setq olivetti-body-width 100))

;; ========================================================================
;; Markdown Render Enhancements
;; ========================================================================
;; Enhanced inline rendering similar to render-markdown.nvim

;; Pretty symbols in markdown
(add-hook 'markdown-mode-hook
          (lambda ()
            ;; Display unicode symbols for markdown syntax
            (push '("- [ ]" . "☐") prettify-symbols-alist)
            (push '("- [X]" . "☑") prettify-symbols-alist)
            (push '("- [x]" . "☑") prettify-symbols-alist)
            (prettify-symbols-mode 1)))

;; Visual line mode for better text wrapping
(add-hook 'markdown-mode-hook 'visual-line-mode)

;; ========================================================================
;; Org Export to Markdown
;; ========================================================================
;; Export org-mode files to markdown

(use-package ox-md
  :straight (:type built-in)
  :after org)

;; ========================================================================
;; Pandoc Integration
;; ========================================================================
;; Use pandoc for format conversion

(use-package pandoc-mode
  :hook (markdown-mode . pandoc-mode)
  :config
  ;; Set pandoc data directory
  (setq pandoc-data-dir (expand-file-name "pandoc" user-emacs-directory)))

;; ========================================================================
;; Markdown Keybindings
;; ========================================================================

(with-eval-after-load 'general
  (general-define-key
   :states '(normal visual)
   :keymaps 'markdown-mode-map
   :prefix "SPC"
   "mp" '(markdown-preview-mode :which-key "Preview markdown")
   "mt" '(markdown-toc-generate-toc :which-key "Generate TOC")
   "mr" '(markdown-toc-refresh-toc :which-key "Refresh TOC")
   "me" '(markdown-export :which-key "Export markdown")
   "mo" '(olivetti-mode :which-key "Toggle Olivetti")))

;; ========================================================================
;; GFM (GitHub Flavored Markdown) Mode
;; ========================================================================
;; Special settings for GFM

(add-hook 'gfm-mode-hook
          (lambda ()
            ;; Enable spell checking
            (flyspell-mode 1)
            
            ;; Enable auto-fill for better formatting
            (auto-fill-mode 1)))

;; ========================================================================
;; Markdown Image Handling
;; ========================================================================
;; Display images inline

(add-hook 'markdown-mode-hook
          (lambda ()
            ;; Enable inline image display
            (when (display-graphic-p)
              (add-hook 'after-save-hook 'markdown-display-inline-images nil t))))

(provide 'markdown)
;;; markdown.el ends here
