;;; early-init.el --- Early initialization configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2024

;; Author: Hy4ri
;; URL: https://github.com/Hy4ri/dots
;; Keywords: emacs configuration

;;; Commentary:

;; This file is loaded before the GUI is initialized and before the
;; regular init.el file. It's used for performance optimizations and
;; setting up the package manager.
;; 
;; This configuration mirrors the Neovim setup from .config/nvim/

;;; Code:

;; ========================================================================
;; Performance Optimizations
;; ========================================================================
;; These settings improve startup time by reducing garbage collection
;; during initialization and disabling some visual features initially.

;; Increase garbage collection threshold during startup
;; Equivalent to Neovim's memory management optimizations
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Restore garbage collection after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024) ; 16MB
                  gc-cons-percentage 0.1)))

;; ========================================================================
;; Native Compilation Settings
;; ========================================================================
;; Configure native compilation for better performance (Emacs 28+)

(when (featurep 'native-compile)
  ;; Silence native compilation warnings
  (setq native-comp-async-report-warnings-errors nil)
  ;; Set native compilation cache directory
  (setq native-comp-deferred-compilation t))

;; ========================================================================
;; Package Manager Initialization
;; ========================================================================
;; Disable package.el in favor of straight.el (similar to lazy.nvim)

(setq package-enable-at-startup nil)

;; ========================================================================
;; UI Optimizations
;; ========================================================================
;; Disable unnecessary UI elements early for faster startup
;; Similar to Neovim's minimal UI approach

;; Disable startup screen
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message user-login-name)

;; Disable unnecessary UI elements
(setq use-dialog-box nil)                 ; Disable dialog boxes
(setq use-file-dialog nil)                ; Disable file dialog
(setq inhibit-splash-screen t)            ; No splash screen
(setq inhibit-compacting-font-caches t)   ; Don't compact font caches

;; Disable tool bar, menu bar, and scroll bar early
;; Equivalent to Neovim's minimal UI
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; ========================================================================
;; Frame Settings
;; ========================================================================
;; Initial frame configuration

;; Set default frame parameters
(push '(fullscreen . maximized) default-frame-alist)  ; Start maximized

;; ========================================================================
;; Load Path
;; ========================================================================
;; Add custom load paths early

;; Add lisp directory to load path (for custom configurations)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;;; early-init.el ends here
