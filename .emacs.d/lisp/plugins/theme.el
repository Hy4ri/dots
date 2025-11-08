;;; theme.el --- Theme configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2024

;; Author: Hy4ri
;; Keywords: theme, colors

;;; Commentary:

;; Theme configuration for Emacs, mirroring the Neovim theme setup
;; from .config/nvim/lua/plugins/theme.lua
;;
;; Neovim themes:
;; - ashen.nvim (ficcdaf/ashen.nvim) - primary theme
;; - vesper.nvim (datsfilipe/vesper.nvim)
;; - tokyodark.nvim (tiagovla/tokyodark.nvim)
;;
;; All themes configured with transparency enabled

;;; Code:

;; ========================================================================
;; Doom Themes
;; ========================================================================
;; Doom themes provides a collection of themes similar in aesthetic
;; to the Neovim themes configured

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t        ; Enable bold fonts
        doom-themes-enable-italic t)     ; Enable italic fonts
  
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  
  ;; Corrects (and improves) org-mode's native fontification
  (doom-themes-org-config))

;; ========================================================================
;; Modus Themes (Built-in Emacs 28+)
;; ========================================================================
;; High-contrast, accessible themes
;; Can serve as alternatives to the Neovim themes

(use-package modus-themes
  :straight (:type built-in)
  :config
  ;; Add customizations before loading the theme
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs t
        modus-themes-mixed-fonts t
        modus-themes-subtle-line-numbers t
        modus-themes-success-deuteranopia t))

;; ========================================================================
;; Nano Theme
;; ========================================================================
;; A modern, minimal theme similar to ashen.nvim's aesthetic

(use-package nano-theme
  :straight (nano-theme :type git :host github :repo "rougier/nano-theme")
  :defer t)

;; ========================================================================
;; Ef Themes
;; ========================================================================
;; Another set of elegant, colorful themes by the creator of Modus themes

(use-package ef-themes
  :defer t)

;; ========================================================================
;; Transparency Support
;; ========================================================================
;; Enable transparency to match Neovim's transparent = true setting

(defun set-transparency (alpha)
  "Set frame transparency to ALPHA (0-100).
This mimics the transparent background setting in the Neovim themes."
  (interactive "nAlpha value (0-100): ")
  (set-frame-parameter nil 'alpha alpha))

;; Function to toggle transparency
(defun toggle-transparency ()
  "Toggle transparency between opaque and transparent.
Equivalent to toggling transparent backgrounds in Neovim themes."
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (if (or (not alpha) (= alpha 100))
        (set-frame-parameter nil 'alpha 85)
      (set-frame-parameter nil 'alpha 100))))

;; ========================================================================
;; Theme Selection
;; ========================================================================
;; Load the default theme
;; Equivalent to: vim.cmd.colorscheme("ashen")

;; Using doom-one as it has similar aesthetics to ashen.nvim
;; Alternatives: doom-nord, doom-dark+, modus-vivendi
(load-theme 'doom-one t)

;; Set transparency (matching transparent = true in Neovim config)
;; Comment out if you prefer opaque background
(set-transparency 85)

;; ========================================================================
;; Theme Switching Functions
;; ========================================================================
;; Helper functions to switch between themes

(defvar my-themes '(doom-one doom-nord doom-dark+ modus-vivendi ef-winter)
  "List of themes to cycle through.
Equivalent to having multiple theme plugins in Neovim.")

(defvar my-current-theme-index 0
  "Index of the current theme in my-themes.")

(defun cycle-theme ()
  "Cycle through available themes.
Provides quick theme switching similar to :colorscheme in Neovim."
  (interactive)
  (setq my-current-theme-index (mod (1+ my-current-theme-index) (length my-themes)))
  (let ((theme (nth my-current-theme-index my-themes)))
    (mapc #'disable-theme custom-enabled-themes)
    (load-theme theme t)
    (message "Loaded theme: %s" theme)))

(provide 'theme)
;;; theme.el ends here
