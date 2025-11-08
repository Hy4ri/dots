;;; copilot.el --- GitHub Copilot configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2024

;; Author: Hy4ri
;; Keywords: copilot, ai

;;; Commentary:

;; GitHub Copilot configuration for Emacs
;; Mirroring the Neovim Copilot setup from .config/nvim/lua/plugins/copilot.lua
;;
;; Provides AI-powered code completion suggestions

;;; Code:

;; ========================================================================
;; Copilot.el
;; ========================================================================
;; GitHub Copilot integration for Emacs
;; Equivalent to copilot.lua in Neovim

(use-package copilot
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :hook (prog-mode . copilot-mode)
  :config
  ;; Keybindings for copilot
  ;; Equivalent to:
  ;;   accept = "<C-y>"
  ;;   accept_word = "<M-y>"
  ;;   next = "<M-]>"
  ;;   prev = "<M-[>"
  ;;   dismiss = "<C-]>"
  (define-key copilot-completion-map (kbd "C-y") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "M-y") 'copilot-accept-completion-by-word)
  (define-key copilot-completion-map (kbd "M-]") 'copilot-next-completion)
  (define-key copilot-completion-map (kbd "M-[") 'copilot-previous-completion)
  (define-key copilot-completion-map (kbd "C-]") 'copilot-clear-overlay)
  
  ;; Auto-trigger suggestions
  ;; Equivalent to: auto_trigger = true
  (setq copilot-idle-delay 0.5)
  
  ;; Don't show copilot in certain modes
  (add-to-list 'copilot-disable-predicates
               (lambda ()
                 (or (evil-insert-state-p)
                     (and (bound-and-true-p company-mode)
                          company-candidates)))))

;; ========================================================================
;; Copilot Toggle Function
;; ========================================================================
;; Toggle copilot on/off
;; Equivalent to: keymap.set("n", "<leader>uc", "<cmd>copilot toggle<cr>")

(defun toggle-copilot ()
  "Toggle GitHub Copilot on/off.
Equivalent to :Copilot toggle in Neovim."
  (interactive)
  (if (bound-and-true-p copilot-mode)
      (progn
        (copilot-mode -1)
        (message "Copilot disabled"))
    (copilot-mode 1)
    (message "Copilot enabled")))

;; ========================================================================
;; Leader Key Binding
;; ========================================================================

(with-eval-after-load 'general
  (leader-def
    "uc" '(toggle-copilot :which-key "Toggle Copilot")))

;; ========================================================================
;; Copilot Authentication Helper
;; ========================================================================
;; Helper message for first-time setup

(defun copilot-setup-instructions ()
  "Display instructions for setting up GitHub Copilot.
Run this function if copilot authentication fails."
  (interactive)
  (message "GitHub Copilot Setup:")
  (message "1. Run M-x copilot-login")
  (message "2. Follow the browser prompts to authenticate")
  (message "3. Return to Emacs after authentication")
  (message "For more info: https://github.com/zerolfx/copilot.el"))

;; ========================================================================
;; Alternative: ChatGPT Integration
;; ========================================================================
;; Optional ChatGPT integration for AI assistance

(use-package gptel
  :commands (gptel gptel-menu)
  :config
  (setq gptel-model "gpt-4")
  (setq gptel-default-mode 'org-mode))

(provide 'copilot)
;;; copilot.el ends here
