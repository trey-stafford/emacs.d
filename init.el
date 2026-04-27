; Load package configuraiton (use-package, repos)
(load "~/.emacs.d/packages.el")
; Set where automatically generated customization will be placed.
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

; Get the execution PATH from the shell
(use-package exec-path-from-shell
  :ensure t)
(exec-path-from-shell-initialize)

; https://emacs-lsp.github.io/lsp-mode/page/performance/#adjust-gc-cons-threshold
(setq gc-cons-threshold 100000000)
; https://emacs-lsp.github.io/lsp-mode/page/performance/#increase-the-amount-of-data-which-emacs-reads-from-the-process
(setq read-process-output-max (* 1024 1024)) ;; 1mb

; Now we can ensure the markdown-mode
; package is automatically installed
(use-package markdown-mode
    :ensure t)

(use-package jsonnet-mode
    :ensure t)

(use-package general
    :ensure t)
(setq general-default-keymaps 'evil-normal-state-map)

; undo-tree: required by evil's undo system.
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode))

; Evil mode.
(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode t)
  (setq evil-toggle-key 'nil)
  ; TODO: ensure this works as expected.
  ; (global-undo-tree-mode)
  (evil-set-undo-system 'undo-tree)
  )

(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init '(dired calc calendar ediff)))

;; Make evil-mode up/down operate in screen lines instead of logical lines
(define-key evil-motion-state-map "j" 'evil-next-visual-line)
(define-key evil-motion-state-map "k" 'evil-previous-visual-line)
;; Also in visual mode
(define-key evil-visual-state-map "j" 'evil-next-visual-line)
(define-key evil-visual-state-map "k" 'evil-previous-visual-line)

; Helm
(use-package helm
  :ensure t
  :config
  (helm-mode t))
(general-define-key "M-x" 'helm-M-x)
; SPC-f will open the find-file menu
(general-define-key :prefix "SPC"
                    "f" 'helm-locate
                    "r" 'helm-show-kill-ring)

(load "~/.emacs.d/projectile.el")

; YAML mode
(use-package yaml-mode
  :ensure t)

; Improved Debugger
(use-package realgud
  :ensure t)

; Auto highlighting.
(use-package auto-highlight-symbol
  :ensure t)
(general-define-key "C-z" 'auto-highlight-symbol-mode)
(setq ahs-idle-interval 0)

(load "~/.emacs.d/magit.el")

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

(load "~/.emacs.d/python.el")

; Hightlight matching enclosing brakets
(show-paren-mode 1)
(setq show-paren-delay 0)

; Set the tag command that projectile will use.
;(setq projectile-tags-command "ctags-exuberant -Rea -f \"%s\" %s")
(setq projectile-tags-command "find . \( -name '*.rb' -o -name '*.py' -o -name '*.js' \) -exec etags -a {} \;")

(load "~/.emacs.d/org.el")

; Make indenting sensible.
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

; Set the backup file location (TODO: perhaps place this elsewhere)
(setq backup-directory-alist
    `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
    `((".*" ,temporary-file-directory t)))


; Otherwise disabled
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)

; Use visual line mode everywhere.
(setq visual-line-mode t)

; zoom window
(use-package zoom-window
    :ensure t
    :config
    (setq zoom-window-mode-line-color "DarkGreen"))

; Toggle zoom with SPC-z
(general-define-key :prefix "SPC"
		    "z" 'zoom-window-zoom)

; imenu with SPC-m
(general-define-key :prefix "SPC"
		    "m" 'helm-imenu)

; Set default column fill to 80 chars
(setq-default fill-column 80)

; Make dired report space in human readable way
(setq dired-listing-switches "-alh")

; Set global font size
; (set-face-attribute 'default nil :height 110)
(set-face-attribute 'default nil :height 90)

(defun increase-font-height ()
  "docstring"
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height (+ (face-attribute 'default :height) 10)))

(defun decrease-font-height ()
  "docstring"
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height (- (face-attribute 'default :height) 10)))

(general-define-key :prefix "SPC"
            "-" 'decrease-font-height
            "=" 'increase-font-height)

; TODO: http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html#!
; Flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(load "~/.emacs.d/web.el")

(use-package puppet-mode
  :ensure t)


(use-package company
  :ensure t)

; Ace window makes switching windows easy
(use-package ace-window
  :ensure t)

; Make ace-window selectors be home-row keys
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

; space-a activates ace-window
(general-define-key :prefix "SPC"
		    "a" 'ace-window)

; ruby
(load "~/.emacs.d/ruby.el")

; Keep the clipboard from other programs in the killring.
(setq save-interprogram-paste-before-kill t)


(use-package indent-guide
  :ensure t)
(indent-guide-global-mode)

; Perspective (workspaces in emacs)
(use-package perspective
  :ensure t
  :init
  ;; Must be set before persp-mode is activated
  (setq persp-mode-prefix-key (kbd "C-c M-p"))
  :config
  (persp-mode 1))

(use-package persp-projectile
  :ensure t)

(general-define-key :prefix "SPC"
                    "w" 'persp-switch
                    "l" 'persp-next
                    "h" 'persp-prev
                    "p" 'projectile-persp-switch-project)


; Show the current buffer's path in the frame's title.
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

; Make inline code markdown easier to read:
(set-face-attribute 'markdown-inline-code-face nil :foreground "#000")

; Create a keybinding for opening the current directory in dired
(general-define-key :prefix "SPC"
                    "d" '(lambda()
                           (interactive)
                           (dired ".")))

; Make the kill ring hold more than the default 60 entries.
(setq kill-ring-max 200)
(put 'upcase-region 'disabled nil)

; Don't create lockfiles because it is SUPER annoying to have provisioning stop
; due to symlinks without referants
(setq create-lockfiles nil)

; Stop showing recent commits in the magit status
(magit-add-section-hook 'magit-status-sections-hook
                        'magit-insert-unpushed-to-upstream
                        'magit-insert-unpushed-to-upstream-or-recent
                        'replace)

; Force a confirmation when closing emacs.
(setq confirm-kill-emacs 'y-or-n-p)

(general-define-key :prefix "SPC"
                    "k" 'delete-frame)

; evil-surround: used for surrounding a region w/ e.g., quotes
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

; spell checking
(global-set-key (kbd "<f8>") 'ispell-word)

; yasnippet
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t)

; Use swiper for conducting searches.
(use-package swiper-helm
    :ensure t)
(general-define-key "/" `swiper-helm)

; Use company mode.
(add-hook 'after-init-hook 'global-company-mode)

; Display relative line numbers.
(global-display-line-numbers-mode 't)
(setq display-line-numbers-type 'relative)
(setq display-line-numbers-current-absolute 't)

; elm

(use-package elm-mode
  :ensure t
  :mode ("\\.elm\\'" . elm-mode)
  :config
  (setq elm-format-on-save t))

; docker
(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

(use-package fill-function-arguments
  :ensure t)

;; Use system trash
(setq delete-by-moving-to-trash 't)
(setq trash-directory "/tmp/")


; If another dired window is open, set the default copy location to that
; location.
(setq dired-dwim-target 't)

; Preserve modification time when copying files w/ dired
(setq dired-copy-preserve-time 't)

; Set `.qmd` files (Quatro executable slides)
(add-to-list 'auto-mode-alist '("\\.qmd\\'" . markdown-mode))

; Start persp-mode
(persp-mode)

; Auto-revert remote files
(setq auto-revert-remote-files 't)

; Theme
(use-package monokai-theme
  :ensure t
  :config
  (load-theme 'monokai t))

; Default markdown face is gray which makes it difficult to read against a black
; background.
; (set-face-background 'markdown-inline-code-face "green")
(set-face-foreground 'markdown-inline-code-face "red")

(tool-bar-mode -1)
(menu-bar-mode -99)
(toggle-scroll-bar -1)
(setq inhibit-startup-message t)
