;;; modeline.el --- Modeline/statusline configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2024

;; Author: Hy4ri
;; Keywords: modeline, statusline

;;; Commentary:

;; Modeline (statusline) configuration for Emacs
;; Mirroring the Neovim lualine setup from .config/nvim/lua/plugins/lualine.lua
;;
;; Neovim uses lualine.nvim for an enhanced statusline
;; Emacs equivalent: doom-modeline or telephone-line

;;; Code:

;; ========================================================================
;; Doom Modeline
;; ========================================================================
;; Doom modeline provides a modern, feature-rich modeline
;; Equivalent to lualine.nvim in Neovim

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
  ;; Basic configuration
  (setq doom-modeline-height 30)           ; Height of the modeline bar
  (setq doom-modeline-bar-width 4)         ; Width of the bar on the left
  (setq doom-modeline-icon t)              ; Display icons (requires all-the-icons)
  (setq doom-modeline-major-mode-icon t)   ; Show major mode icon
  (setq doom-modeline-major-mode-color-icon t) ; Colorize major mode icon
  
  ;; Buffer information
  ;; Equivalent to lualine's file_with_icon and file_status
  (setq doom-modeline-buffer-file-name-style 'auto) ; Auto-shorten file paths
  (setq doom-modeline-buffer-state-icon t)  ; Show buffer state (modified, readonly)
  (setq doom-modeline-buffer-modification-icon t) ; Show modification indicator
  
  ;; LSP integration
  ;; Equivalent to lualine's lsp_client function
  (setq doom-modeline-lsp t)               ; Show LSP status
  (setq doom-modeline-lsp-icon t)          ; Show LSP icon
  
  ;; Git integration
  ;; Equivalent to lualine's branch and diff sections
  (setq doom-modeline-vcs-max-length 12)   ; Max length for branch name
  (setq doom-modeline-github t)            ; Show GitHub notifications
  (setq doom-modeline-buffer-encoding t)   ; Show buffer encoding
  
  ;; Checker (diagnostics)
  ;; Equivalent to lualine's diagnostics section
  (setq doom-modeline-checker-simple-format nil) ; Show detailed diagnostics
  (setq doom-modeline-number-limit 99)     ; Limit for displaying numbers
  
  ;; Time display
  ;; Equivalent to lualine's clock function
  (setq display-time-format "%I:%M")       ; 12-hour format
  (setq display-time-default-load-average nil) ; Don't show load average
  (display-time-mode 1)                    ; Enable time display
  
  ;; Minor modes display
  (setq doom-modeline-minor-modes nil)     ; Hide minor modes (cleaner look)
  
  ;; Position information
  ;; Equivalent to lualine's location
  (setq doom-modeline-percent-position t)  ; Show position percentage
  (setq doom-modeline-position-line-format '("L%l:C%c")) ; Line and column
  
  ;; Workspace/project
  (setq doom-modeline-project-detection 'auto) ; Auto-detect project
  (setq doom-modeline-persp-name t)        ; Show perspective name
  (setq doom-modeline-workspace-name t)    ; Show workspace name
  
  ;; File format
  ;; Equivalent to lualine's fileformat
  (setq doom-modeline-buffer-encoding t)   ; Show encoding (utf-8, unix, etc.)
  
  ;; Continuous updates
  (setq doom-modeline-enable-word-count nil) ; Don't count words
  (setq doom-modeline-indent-info nil))    ; Don't show indent info

;; ========================================================================
;; All the Icons (Required for icons in modeline)
;; ========================================================================
;; Provides icon support for doom-modeline
;; Equivalent to nvim-web-devicons in Neovim

(use-package all-the-icons
  :if (display-graphic-p)
  :config
  ;; Run M-x all-the-icons-install-fonts on first setup
  (unless (find-font (font-spec :name "all-the-icons"))
    (message "Run M-x all-the-icons-install-fonts to install icon fonts")))

;; ========================================================================
;; Macro Recording Indicator
;; ========================================================================
;; Show when recording a macro
;; Equivalent to lualine's recording_macro function

(defun show-macro-recording ()
  "Display macro recording status in the modeline.
Equivalent to the recording_macro function in lualine.lua"
  (when defining-kbd-macro
    (propertize (format " @%s" (char-to-string last-kbd-macro))
                'face '(:foreground "#BF616A" :weight bold))))

;; Add to modeline
(setq-default mode-line-format
              (append mode-line-format '((:eval (show-macro-recording)))))

;; ========================================================================
;; Search Count Display
;; ========================================================================
;; Show search results count (e.g., 2/5)
;; Equivalent to lualine's search_count function

;; Enable isearch match count display
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format " [%s/%s] ")
(setq lazy-count-suffix-format nil)

;; ========================================================================
;; Alternative: Telephone Line
;; ========================================================================
;; Another modeline option if doom-modeline is too heavy
;; Uncomment to use instead of doom-modeline

;; (use-package telephone-line
;;   :config
;;   (telephone-line-mode 1)
;;   (setq telephone-line-primary-left-separator 'telephone-line-flat
;;         telephone-line-secondary-left-separator 'telephone-line-flat
;;         telephone-line-primary-right-separator 'telephone-line-flat
;;         telephone-line-secondary-right-separator 'telephone-line-flat)
;;   (setq telephone-line-height 24)
;;   (setq telephone-line-lhs
;;         '((evil   . (telephone-line-evil-tag-segment))
;;           (accent . (telephone-line-vc-segment
;;                      telephone-line-process-segment))
;;           (nil    . (telephone-line-buffer-segment))))
;;   (setq telephone-line-rhs
;;         '((nil    . (telephone-line-misc-info-segment))
;;           (accent . (telephone-line-major-mode-segment))
;;           (evil   . (telephone-line-airline-position-segment)))))

;; ========================================================================
;; Modeline Refresh on Events
;; ========================================================================
;; Auto-update the modeline when certain events occur
;; Equivalent to the auto-update in lualine.lua

(add-hook 'after-save-hook #'force-mode-line-update)
(add-hook 'buffer-list-update-hook #'force-mode-line-update)

(provide 'modeline)
;;; modeline.el ends here
