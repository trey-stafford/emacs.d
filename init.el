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
(general-define-key :prefix "SPC"
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

  :ensure t)

; Magit
(use-package magit
  :ensure t)

(use-package evil-magit
  :ensure t)
(general-define-key "C-X g" 'magit-status)

; Evil-mode remaps
(general-define-key "C-k" 'evil-window-up
		    "C-j" 'evil-window-down
		    "C-h" 'evil-window-left
		    "C-l" 'evil-window-right)

(general-define-key :prefix "SPC"
		    "k" 'evil-window-increase-height
		    "j" 'evil-window-decrease-height
		    "h" 'evil-window-increase-width
		    "l" 'evil-window-decrease-width)

(general-define-key "C-z" `help)

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
(general-define-key "g-t" `helm-etags-select)
