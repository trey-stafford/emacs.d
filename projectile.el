; Projectile
(use-package counsel
  :ensure t)

(use-package counsel-projectile
  :ensure t)

; TODO Using ivy for now because a change w/ helm (?) or projectile (?) has broken helm-projectile.
(use-package projectile
  :ensure t
  :config
    (projectile-mode t)
    (setq projectile-completion-system 'ivy
          projectile-switch-project-action 'counsel-projectile-switch-project))

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

; Hopefully temporary
; see: https://github.com/bbatsov/projectile/issues/1183
(setq projectile-mode-line
         '(:eval (format " Projectile[%s]"
                        (projectile-project-name))))
