; Magit


(use-package magit
  :ensure t)

; TODO: toggle for 'other-window' when in magit log/revision view. Currently
; hitting `q` kills magit completely (does not just close the revision
; buffer...)

(with-eval-after-load "map"
(dolist (map (list magit-status-mode-map
	       magit-log-mode-map
	       magit-diff-mode-map
	       magit-staged-section-map))
  ; TODO: why doesn't C-e work?
  (define-key map "e" 'evil-scroll-line-down)
  (define-key map "j" 'next-line)
  (define-key map "k" 'previous-line)
  ; TODO: why doesn't C-y work?
  (define-key map "y" 'evil-scroll-line-up)
  (define-key map "n" nil)
  (define-key map "p" nil)
  (define-key map "v" 'recenter-top-bottom)
  (define-key map "i" 'magit-section-toggle)
  (define-key map "V" 'evil-visual-line)
  (define-key map "x" 'magit-discard))
)

(setq magit-diff-refine-hunk 'all)

; (use-package evil-magit
;   :ensure t)

; use CTL-K/J to move rebase lines up and down in magit.
; (with-eval-after-load 'git-rebase
;   (evil-magit-define-key evil-magit-state 'git-rebase-mode-map "C-K" 'git-rebase-move-line-up)
;   (evil-magit-define-key evil-magit-state 'git-rebase-mode-map "C-J" 'git-rebase-move-line-down))

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


; Cause magit status to use the entire frame.
(setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)

(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defadvice magit-mode-quit-window (after magit-restore-screen activate)
  "Restores the previous window configuration and kills the magit buffer"
  (jump-to-register :magit-fullscreen))
