;;; git.el --- Git integration configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2024

;; Author: Hy4ri
;; Keywords: git, version-control

;;; Commentary:

;; Git integration for Emacs
;; Mirroring the Neovim git setup from .config/nvim/lua/plugins/gitsigns.lua
;;
;; Neovim uses gitsigns.nvim for inline git decorations
;; Emacs equivalent: magit (full git interface) + git-gutter (inline signs)

;;; Code:

;; ========================================================================
;; Magit (Full-featured Git interface)
;; ========================================================================
;; Magit is the most powerful Git interface for Emacs
;; Provides a complete Git workflow

(use-package magit
  :commands magit-status
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch))
  :config
  ;; Show refined diffs for current hunk
  (setq magit-diff-refine-hunk 'all)
  
  ;; Show word-granularity differences
  (setq magit-diff-refine-ignore-whitespace t)
  
  ;; Auto-refresh magit buffers
  (setq magit-refresh-status-buffer t))

;; ========================================================================
;; Git Gutter (Inline git signs)
;; ========================================================================
;; Shows git diff information in the gutter (margin)
;; Equivalent to gitsigns.nvim in Neovim

(use-package git-gutter
  :diminish git-gutter-mode
  :hook (prog-mode . git-gutter-mode)
  :config
  ;; Update interval
  ;; Equivalent to opt.updatetime = 300 affecting gitsigns
  (setq git-gutter:update-interval 2)
  
  ;; Show signs in margin
  (setq git-gutter:window-width 2)
  (setq git-gutter:modified-sign "~")
  (setq git-gutter:added-sign "+")
  (setq git-gutter:deleted-sign "-")
  
  ;; Colors for signs
  (set-face-foreground 'git-gutter:modified "#EBCB8B") ; Yellow for modified
  (set-face-foreground 'git-gutter:added "#A3BE8C")    ; Green for added
  (set-face-foreground 'git-gutter:deleted "#BF616A")  ; Red for deleted
  
  ;; Enable in all buffers
  (global-git-gutter-mode +1))

;; Git gutter fringe (alternative - uses fringe instead of margin)
;; Uncomment if you prefer fringe display
;; (use-package git-gutter-fringe
;;   :after git-gutter
;;   :config
;;   (define-fringe-bitmap 'git-gutter-fr:added [224]
;;     nil nil '(center repeated))
;;   (define-fringe-bitmap 'git-gutter-fr:modified [224]
;;     nil nil '(center repeated))
;;   (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240]
;;     nil nil 'bottom))

;; ========================================================================
;; Diff-hl (Alternative to git-gutter)
;; ========================================================================
;; Another option for showing git diff in margin/fringe
;; Uncomment to use instead of git-gutter

;; (use-package diff-hl
;;   :hook ((prog-mode . diff-hl-mode)
;;          (dired-mode . diff-hl-dired-mode)
;;          (magit-post-refresh . diff-hl-magit-post-refresh))
;;   :config
;;   ;; Use margin instead of fringe
;;   (diff-hl-margin-mode))

;; ========================================================================
;; Git Time Machine
;; ========================================================================
;; Step through git history of a file
;; Browse previous versions of the current file

(use-package git-timemachine
  :commands git-timemachine
  :config
  (setq git-timemachine-show-minibuffer-details t))

;; ========================================================================
;; Git Commit Mode
;; ========================================================================
;; Enhanced git commit message editing
;; Part of magit but can be configured separately

(use-package git-commit
  :after magit
  :config
  ;; Enable spell checking in commit messages
  (add-hook 'git-commit-mode-hook 'flyspell-mode)
  
  ;; Highlight overlong summary lines
  (setq git-commit-summary-max-length 50)
  (setq git-commit-style-convention-checks
        '(non-empty-second-line overlong-summary-line)))

;; ========================================================================
;; Blamer (Git blame inline)
;; ========================================================================
;; Show git blame information inline
;; Similar to virtual text in gitsigns

(use-package blamer
  :straight (blamer :host github :repo "artawower/blamer.el")
  :commands blamer-mode
  :config
  (setq blamer-idle-time 0.5)
  (setq blamer-min-offset 70)
  (setq blamer-prettify-time-p t)
  (setq blamer-commit-formatter " • %s")
  
  ;; Customize face
  (set-face-attribute 'blamer-face nil
                      :foreground "#7a88cf"
                      :background nil
                      :italic t))

;; ========================================================================
;; Keybindings for Git Operations
;; ========================================================================
;; Add leader key bindings for git operations

(with-eval-after-load 'general
  (leader-def
    "g" '(:ignore t :which-key "git")
    "gg" '(magit-status :which-key "Magit status")
    "gb" '(magit-blame :which-key "Git blame")
    "gc" '(magit-commit :which-key "Git commit")
    "gd" '(magit-diff :which-key "Git diff")
    "gl" '(magit-log :which-key "Git log")
    "gp" '(magit-push :which-key "Git push")
    "gP" '(magit-pull :which-key "Git pull")
    "gt" '(git-timemachine :which-key "Time machine")
    "gh" '(git-gutter:next-hunk :which-key "Next hunk")
    "gH" '(git-gutter:previous-hunk :which-key "Previous hunk")
    "gs" '(git-gutter:stage-hunk :which-key "Stage hunk")
    "gr" '(git-gutter:revert-hunk :which-key "Revert hunk")))

;; ========================================================================
;; Git Gutter Keybindings (Evil mode integration)
;; ========================================================================
;; Add evil mode bindings for git operations

(with-eval-after-load 'evil
  ;; Navigate between hunks
  (define-key evil-normal-state-map (kbd "]h") 'git-gutter:next-hunk)
  (define-key evil-normal-state-map (kbd "[h") 'git-gutter:previous-hunk))

;; ========================================================================
;; Auto-refresh Git Status
;; ========================================================================
;; Automatically refresh git gutter when saving

(add-hook 'after-save-hook
          (lambda ()
            (when (and (bound-and-true-p git-gutter-mode)
                       (buffer-file-name))
              (git-gutter:update))))

(provide 'git)
;;; git.el ends here
