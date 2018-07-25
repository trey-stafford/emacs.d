; Magit
(use-package magit
  :ensure t)
(setq magit-diff-refine-hunk 'all)

(use-package evil-magit
  :ensure t)

; use CTL-K/J to move rebase lines up and down in magit.
(with-eval-after-load 'git-rebase
  (evil-magit-define-key evil-magit-state 'git-rebase-mode-map "C-K" 'git-rebase-move-line-up)
  (evil-magit-define-key evil-magit-state 'git-rebase-mode-map "C-J" 'git-rebase-move-line-down))

; git-timemachine
(use-package git-timemachine
  :ensure t)

; override evil-mode bindings
; see https://github.com/emacs-evil/evil/issues/511
(eval-after-load 'git-timemachine
  '(progn
     (evil-make-overriding-map git-timemachine-mode-map 'normal)
     ;; force update evil keymaps after git-timemachine-mode loaded
     (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps)))

; git related keybindings.
(general-define-key :prefix ","
		    "g" 'magit-status
		    "l" 'magit-log-buffer-file
		    "c" 'magit-show-refs
		    "L" 'magit-log-current
		    "b" 'magit-blame
		    "p" 'magit-push-popup
		    "u" 'magit-pull-from-upstream
		    "d" 'magit-diff-buffer-file-popup
            "t" 'git-timemachine-toggle)
