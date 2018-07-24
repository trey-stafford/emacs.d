; Org mode
(use-package org
  :ensure t
  :config
    (setq org-startup-indented t)
    (setq org-enforce-todo-dependencies t)
    (setq org-log-done 'time)
    (setq org-log-into-drawer 'LOGBOOK))

; evil-org
(use-package org-evil
  :ensure t)

; Dont' let 'invisible' edits go unnoticed
(setq org-catch-invisible-edits 'smart)

(defun org-new-item-below ()
  "Add a new list item"
  (interactive)
  (evil-append-line 1)
  (insert " ")
  (evil-force-normal-state)
  (org-insert-heading)
  (evil-insert 1))

(defun org-new-item-above ()
  "Add a new list item"
  (interactive)
  (evil-first-non-blank)
  (org-insert-heading)
  (evil-insert 1))

(defun org-new-checkbox-above ()
  "Add a new list item"
  (interactive)
  (evil-first-non-blank)
  (org-insert-heading)
  (insert "[ ] ")
  (org-update-statistics-cookies)
  (evil-insert 1))

(defun org-new-checkbox-below ()
  "Add a new list item"
  (interactive)
  (evil-append-line 1)
  (insert " ")
  (evil-force-normal-state)
  (org-insert-heading)
  (insert "[ ] ")
  (org-update-statistics-cookies)
  (evil-insert 1))

(defun org-in-progress-check ()
  "Puts a checkbox into an intermediate state"
  (interactive)
  (let ((current-prefix-arg '(16)))
  (call-interactively 'org-toggle-checkbox)))

; Keymaps for org mode.
(general-define-key :states '(normal)
    :keymaps 'org-mode-map
    :prefix "SPC"
    "C-k" `org-evil-motion-backward-heading
    "C-j" `org-evil-motion-forward-heading
    "K" `org-move-subtree-up
    "k" `org-move-item-up
    "J" `org-move-subtree-down
    "j" `org-move-item-down
    "n" `org-narrow-to-subtree
    "N" `org-narrow-to-block
;     "w" `widen  ; not good bc I use spc-w for persp-switch
    "h" `org-toggle-heading
    "o" `org-insert-heading-after-current
    "O" `org-insert-heading
    "i" 'org-new-item-below
    "I" 'org-new-item-above
    "X" 'org-in-progress-check
    "x" 'org-toggle-checkbox
    "c" 'org-new-checkbox-below
    "C" 'org-new-checkbox-above
    "l" 'org-open-at-point
    "t" 'org-todo)

; Set the list of org TODO states.
; (<letetr>) == shortcut key
; (<letter>!) == log time
; (<letter>@) == log time and prompt for a note
; (<letter>@/!) == log time, prompt for a note, and log time when state is left.
(setq org-todo-keywords
      '((sequence "TODO(t)" "IN-PROGRESS(p)" "WAITING(w@/!)" "|" "DONE(d)" "CANCELED(c@)")))
