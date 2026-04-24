; Projectile
(use-package counsel
  :ensure t)

(use-package counsel-projectile
  :ensure t)

; Using counsel-projectile as the completion interface (ivy-based).
; helm-projectile keybindings replaced with counsel/projectile equivalents.
(use-package projectile
  :ensure t
  :config
    (projectile-mode t)
    (setq projectile-completion-system 'ivy
          projectile-switch-project-action 'counsel-projectile-switch-project))

(use-package helm-ag
  :ensure t)

(general-define-key :prefix ";"
		    "p" 'projectile-find-file
		    "P" 'projectile-find-file-other-window
		    "d" 'projectile-find-dir
		    "D" 'projectile-find-dir-other-window
		    "g" 'helm-ag
		    "o" 'counsel-projectile-switch-project
		    "b" 'projectile-switch-to-buffer)

(use-package helm-projectile
  :ensure t)

; Hopefully temporary
; see: https://github.com/bbatsov/projectile/issues/1183
(setq projectile-mode-line
         '(:eval (format " Projectile[%s]"
                        (projectile-project-name))))
