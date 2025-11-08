;;; modeline.el --- Modeline/statusline configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2024

;; Author: Hy4ri
;; Keywords: modeline, statusline

;;; Commentary:

;; Modeline (statusline) configuration for Emacs
;; Mirroring the Neovim lualine setup from .config/nvim/lua/plugins/lualine.lua
;;
;; Neovim lualine features:
;; - Mode display (NORMAL, INSERT, etc.)
;; - File with icon and status
;; - Search count (dynamic)
;; - Git branch and diff
;; - LSP diagnostics
;; - LSP client name
;; - Macro recording indicator
;; - File format
;; - Cursor location
;; - Current time (HH:MM)
;;
;; Emacs equivalent: doom-modeline provides all these features

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
  
  ;; Buffer information (lualine_b equivalent)
  ;; Equivalent to lualine's file_with_icon and file_status
  (setq doom-modeline-buffer-file-name-style 'auto) ; Auto-shorten file paths
  (setq doom-modeline-buffer-state-icon t)  ; Show buffer state (modified, readonly)
  (setq doom-modeline-buffer-modification-icon t) ; Show modification indicator (●)
  
  ;; LSP integration (lualine_x equivalent)
  ;; Equivalent to lualine's lsp_client and diagnostics functions
  (setq doom-modeline-lsp t)               ; Show LSP status
  (setq doom-modeline-lsp-icon t)          ; Show LSP icon
  
  ;; Git integration (lualine_c equivalent)
  ;; Equivalent to lualine's branch and diff sections
  (setq doom-modeline-vcs-max-length 12)   ; Max length for branch name
  (setq doom-modeline-github t)            ; Show GitHub notifications
  
  ;; Checker (diagnostics) (lualine_x equivalent)
  ;; Equivalent to lualine's diagnostics section with error/warn/info/hint icons
  (setq doom-modeline-checker-simple-format nil) ; Show detailed diagnostics
  (setq doom-modeline-number-limit 99)     ; Limit for displaying numbers
  
  ;; Time display (lualine_z equivalent)
  ;; Equivalent to lualine's clock function showing HH:MM
  (setq display-time-format "%I:%M")       ; 12-hour format
  (setq display-time-default-load-average nil) ; Don't show load average
  (display-time-mode 1)                    ; Enable time display
  
  ;; Minor modes display
  (setq doom-modeline-minor-modes nil)     ; Hide minor modes (cleaner look)
  
  ;; Position information (lualine_y equivalent)
  ;; Equivalent to lualine's location (line:column)
  (setq doom-modeline-percent-position t)  ; Show position percentage
  (setq doom-modeline-position-line-format '("L%l:C%c")) ; Line and column
  
  ;; Workspace/project
  (setq doom-modeline-project-detection 'auto) ; Auto-detect project
  (setq doom-modeline-persp-name t)        ; Show perspective name
  (setq doom-modeline-workspace-name t)    ; Show workspace name
  
  ;; File format (lualine_x equivalent)
  ;; Equivalent to lualine's fileformat (unix/dos)
  (setq doom-modeline-buffer-encoding t)   ; Show encoding (utf-8, unix, etc.)
  
  ;; Continuous updates
  (setq doom-modeline-enable-word-count nil) ; Don't count words
  (setq doom-modeline-indent-info nil)     ; Don't show indent info
  
  ;; Mode line segments order (matching lualine layout)
  ;; Left: mode, file, search, git
  ;; Right: diagnostics, lsp, macro, format, location, time
  (setq doom-modeline-enable-word-count nil)
  (setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode)))

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
;; Show when recording a macro (like lualine's recording_macro)
;; Equivalent to lualine's recording_macro function with @register display

(defun show-macro-recording ()
  "Display macro recording status in the modeline.
Equivalent to the recording_macro function in lualine.lua.
Shows ' @q' format in red when recording to register q."
  (when defining-kbd-macro
    (let ((register (if (boundp 'last-kbd-macro-register)
                        (char-to-string last-kbd-macro-register)
                      (char-to-string (aref (this-command-keys) 0)))))
      (propertize (format " @%s" (or register ""))
                  'face '(:foreground "#BF616A" :weight bold)))))

;; Note: doom-modeline already has macro recording support built-in
;; The above function is provided for reference if custom implementation is needed

;; ========================================================================
;; Search Count Display
;; ========================================================================
;; Show search results count (e.g., 2/5)
;; Equivalent to lualine's search_count function

;; Enable isearch match count display (built-in feature)
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format " [%s/%s] ")
(setq lazy-count-suffix-format nil)

;; Note: doom-modeline includes search count display by default
;; This is just ensuring the format matches lualine

;; ========================================================================
;; Modeline Refresh on Events
;; ========================================================================
;; Auto-update the modeline when certain events occur
;; Equivalent to the auto-update in lualine.lua for RecordingEnter/RecordingLeave

(add-hook 'after-save-hook #'force-mode-line-update)
(add-hook 'buffer-list-update-hook #'force-mode-line-update)

;; Refresh modeline on macro recording events
(add-hook 'post-command-hook
          (lambda ()
            (when (or defining-kbd-macro executing-kbd-macro)
              (force-mode-line-update))))

(provide 'modeline)
;;; modeline.el ends here
