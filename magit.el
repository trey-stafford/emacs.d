; Magit
(use-package magit
  :ensure t)
(setq magit-diff-refine-hunk 'all)

(use-package evil-magit
  :ensure t)
(general-define-key :prefix ","
		    "g" 'magit-status
		    "l" 'magit-log-buffer-file
		    "c" 'magit-show-refs
		    "L" 'magit-log-current
		    "b" 'magit-blame
		    "p" 'magit-push-popup
		    "u" 'magit-pull-from-upstream
		    "d" 'magit-diff-buffer-file-popup)

; use CTL-K/J to move rebase lines up and down in magit.
(with-eval-after-load 'git-rebase
  (evil-magit-define-key evil-magit-state 'git-rebase-mode-map "C-K" 'git-rebase-move-line-up)
  (evil-magit-define-key evil-magit-state 'git-rebase-mode-map "C-J" 'git-rebase-move-line-down))
