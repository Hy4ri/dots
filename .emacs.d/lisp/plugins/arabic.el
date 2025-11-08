;;; arabic.el --- Arabic language support -*- lexical-binding: t; -*-

;; Copyright (C) 2024

;; Author: Hy4ri
;; Keywords: arabic, bidi, i18n

;;; Commentary:

;; Arabic language support configuration for Emacs
;; Mirroring the Arabic support from Neovim config
;; - keymaps.lua: Arabic toggle functionality
;; - options.lua: opt.arabicshape = true

;;; Code:

;; ========================================================================
;; Bidirectional Text Support
;; ========================================================================
;; Enable bidirectional text editing for Arabic

;; Enable bidi support (built-in Emacs feature)
;; Equivalent to: opt.arabicshape = true
(setq-default bidi-display-reordering t)
(setq bidi-paragraph-direction 'left-to-right) ; Default to LTR

;; ========================================================================
;; Arabic Input Methods
;; ========================================================================
;; Configure Arabic keyboard input

;; Arabic input method
(require 'arabic)

;; Load Arabic input methods
(set-language-environment "Arabic")

;; Default to English but allow easy switching
(setq default-input-method "arabic")

;; ========================================================================
;; Arabic Font Configuration
;; ========================================================================
;; Set appropriate fonts for Arabic display

(defun setup-arabic-fonts ()
  "Setup fonts for proper Arabic display.
Configure Arabic script fonts for better rendering."
  (interactive)
  (when (display-graphic-p)
    ;; Set Arabic font (change to your preferred Arabic font)
    ;; Common Arabic fonts: "Arabic Typesetting", "Scheherazade", "Amiri", "Noto Sans Arabic"
    (set-fontset-font t 'arabic
                      (font-spec :family "Noto Sans Arabic" :size 14)
                      nil 'prepend)
    
    ;; Also set for extended Arabic
    (set-fontset-font t 'arabic-extra
                      (font-spec :family "Noto Sans Arabic" :size 14)
                      nil 'prepend)))

;; Apply Arabic fonts on startup
(add-hook 'after-init-hook #'setup-arabic-fonts)

;; ========================================================================
;; Toggle Arabic Input Mode
;; ========================================================================
;; Toggle between English and Arabic input
;; Equivalent to: keymap.set("n", "<leader>ar", function() ... end)

(defun toggle-arabic-input ()
  "Toggle between Arabic and English input methods.
Equivalent to the Arabic toggle in Neovim keymaps."
  (interactive)
  (if current-input-method
      (progn
        (deactivate-input-method)
        (message "Switched to English input"))
    (activate-input-method "arabic")
    (message "Switched to Arabic input (العربية)")))

;; ========================================================================
;; Toggle Arabic Display Direction
;; ========================================================================
;; Toggle text direction between LTR and RTL

(defun toggle-arabic-direction ()
  "Toggle between left-to-right and right-to-left text direction.
Useful for editing predominantly Arabic text."
  (interactive)
  (if (eq bidi-paragraph-direction 'left-to-right)
      (progn
        (setq bidi-paragraph-direction 'right-to-left)
        (message "Text direction: Right-to-Left (→←)"))
    (setq bidi-paragraph-direction 'left-to-right)
    (message "Text direction: Left-to-Right (←→)")))

;; ========================================================================
;; Arabic-specific Settings
;; ========================================================================

;; Proper shaping of Arabic characters
;; Equivalent to: opt.arabicshape = true
(setq arabic-shape-mode t)

;; Enable composition for proper Arabic ligatures
(global-font-lock-mode 1)

;; Auto-detection of Arabic in text
(add-hook 'text-mode-hook
          (lambda ()
            (when (string-match-p "[\u0600-\u06FF]" (buffer-string))
              (activate-input-method "arabic")
              (message "Arabic text detected - Arabic input enabled"))))

;; ========================================================================
;; Leader Key Bindings for Arabic
;; ========================================================================

(with-eval-after-load 'general
  (leader-def
    "ar" '(toggle-arabic-input :which-key "Toggle Arabic input")
    "ad" '(toggle-arabic-direction :which-key "Toggle text direction")
    "af" '(setup-arabic-fonts :which-key "Setup Arabic fonts")))

;; ========================================================================
;; Evil Mode Integration
;; ========================================================================
;; Make Arabic work smoothly with Evil mode

(with-eval-after-load 'evil
  ;; Disable right-to-left in evil normal mode for better control
  (add-hook 'evil-insert-state-entry-hook
            (lambda ()
              (when current-input-method
                (activate-input-method current-input-method))))
  
  (add-hook 'evil-normal-state-entry-hook
            (lambda ()
              (when current-input-method
                (deactivate-input-method)))))

;; ========================================================================
;; Arabic Text Object Navigation
;; ========================================================================
;; Better navigation for Arabic text with Evil

(with-eval-after-load 'evil
  ;; Visual line movement respects bidi text
  (define-key evil-motion-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-motion-state-map (kbd "k") 'evil-previous-visual-line)
  
  ;; Word movement respects Arabic word boundaries
  (modify-syntax-entry ?ا "w")  ; Alef
  (modify-syntax-entry ?ب "w")  ; Ba
  (modify-syntax-entry ?ت "w")  ; Ta
  (modify-syntax-entry ?ث "w")  ; Tha
  ;; Add more Arabic letters as needed
  )

;; ========================================================================
;; Spell Checking for Arabic
;; ========================================================================
;; Configure spell checking for Arabic text

(with-eval-after-load 'ispell
  ;; Add Arabic dictionary if available
  (add-to-list 'ispell-dictionary-alist
               '("arabic"
                 "[[:alpha:]]"
                 "[^[:alpha:]]"
                 "[']"
                 nil
                 nil
                 nil
                 utf-8)))

;; ========================================================================
;; Display Information
;; ========================================================================

(defun arabic-support-info ()
  "Display information about Arabic support in Emacs.
Show current settings and available commands."
  (interactive)
  (message "Arabic Support:")
  (message "- Toggle Arabic input: SPC ar")
  (message "- Toggle text direction: SPC ad")
  (message "- Current input method: %s"
           (if current-input-method current-input-method "English"))
  (message "- Text direction: %s"
           (if (eq bidi-paragraph-direction 'right-to-left) "RTL" "LTR"))
  (message "- Bidi display: %s" (if bidi-display-reordering "enabled" "disabled")))

(provide 'arabic)
;;; arabic.el ends here
