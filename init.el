; Set where automatically generated customization will be placed.
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(require 'package)

; Add repos to the package list
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

; automatically install pacakges
; With the use-package system
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

; Now we can ensure the markdown-mode
; package is automatically installed
(use-package markdown-mode
    :ensure t)

(use-package general
    :ensure t)
(setq general-default-keymaps 'evil-normal-state-map)

; Relative line numbers
(use-package relative-line-numbers
  :ensure t
  :config
  (global-relative-line-numbers-mode))

; Not currently working, but I think this is (almost) how a custom formatter is defined and set.
;(defun relative-line-numbers-formatter (offset)
;  "The default formatting function.                                                                                        
;Return the absolute value of OFFSET, converted to string."
;  (concat (number-to-string (abs offset)) " -"))

;(customize-set-variable relative-line-numbers-format relative-line-numbers-formatter)

; Theme
(use-package darkburn-theme
  :ensure t
  :config
  (load-theme 'darkburn t))

; Evil mode.
(use-package evil
  :ensure t
  :config
  (evil-mode t))

; Helm
(use-package helm
  :ensure t
  :config
  (helm-mode t)
  (helm-linum-relative-mode t))
(require 'helm-config)
(general-define-key "M-x" 'helm-M-x)
; SPC-f will open the find-file menu
(general-define-key :prefix "SPC"
		    "f" 'helm-locate)

; Projectile
(use-package projectile
  :ensure t
  :config
    (projectile-mode t)
    (setq projectile-completion-system 'helm
          projectile-switch-project-action 'helm-projectile))

; Ignore these directories (TODO: This can probably go above.)
;(add-to-list 'projectile-globally-ignored-directories '("node_modules" ".sass-cache"))

(general-define-key :prefix ";"
		    "p" 'projectile-find-file
		    "P" 'projectile-find-file-other-window
		    "d" 'projectile-find-dir
		    "D" 'projectile-find-dir-other-window
		    "g" 'helm-projectile-grep
		    "o" 'helm-projectile-switch-project
		    "b" 'helm-projectile-switch-to-buffer)

(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))

; YAML mode
(use-package yaml-mode
  :ensure t)

; elpy (python) mode
(use-package elpy
  :ensure t
  :config
  (elpy-enable)
  (setenv "WORKON_HOME" "~/miniconda3/envs")
  (pyvenv-mode 1))
; TODO: eventually try running flycheck with elpy. See https://github.com/jorgenschaefer/elpy/issues/137


; Improved Debugger
(use-package realgud
  :ensure t)

; Record gifs
(use-package camcorder
  :ensure t)

; Auto highlighting. TODO: need to fix.
(use-package auto-highlight-symbol
  :ensure t)
(general-define-key "C-z" 'auto-highlight-symbol-mode)
(setq ahs-idle-interval 0)

; Magit
(use-package magit
  :ensure t)

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
		    

; Evil-mode remaps
(general-define-key "C-k" 'evil-window-up
		    "C-j" 'evil-window-down
		    "C-h" 'evil-window-left
		    "C-l" 'evil-window-right)

(general-define-key :prefix "["
		    "k" 'evil-window-increase-height
		    "j" 'evil-window-decrease-height
		    "h" 'evil-window-increase-width
		    "l" 'evil-window-decrease-width)

(general-define-key "C-q" `help)

; Turn off the toolbar, menubar, scrollbar, and startup message.
(tool-bar-mode -1)
(menu-bar-mode -99)
(toggle-scroll-bar -1)
(setq inhibit-startup-message t)

; Display buffer list by pressing SPC-B
(general-define-key :prefix "SPC"
    "B" `helm-buffers-list)

; ansi Shell colors
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

; Go to def
(general-define-key "g t" `helm-etags-select)
(general-define-key :prefix ";"
		    "t" `projectile-find-tag)


; Hightlight matching enclosing brakets
(show-paren-mode 1)
(setq show-paren-delay 0)


; Set the tag command that projectile will use.
;(setq projectile-tags-command "ctags-exuberant -Rea -f \"%s\" %s")
(setq projectile-tags-command "find . \( -name '*.rb' -o -name '*.py' -o -name '*.js' \) -exec etags -a {} \;")



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
    "w" `widen
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

; Turn on pretty symbols in org mode by default.
(customize-set-variable 'org-pretty-entities t)

; Set the list of org TODO states.
; (<letetr>) == shortcut key
; (<letter>!) == log time
; (<letter>@) == log time and prompt for a note
; (<letter>@/!) == log time, prompt for a note, and log time when state is left.
(setq org-todo-keywords
      '((sequence "TODO(t)" "IN-PROGRESS(p)" "WAITING(w@/!)" "|" "DONE(d)" "CANCELED(c@)")))

; Make indenting sensible.
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

; Set the backup file location (TODO: perhaps place this elsewhere)
(setq backup-directory-alist
    `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
    `((".*" ,temporary-file-directory t)))

; The following line would disable symbolic link lock files. May be necessary to prevent rsync problems when provisioning machines.
; (setq create-lockfiles nil)

