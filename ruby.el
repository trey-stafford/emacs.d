(use-package ruby-electric 
  :ensure t)

(eval-after-load "ruby-mode"
      '(add-hook 'ruby-mode-hook 'ruby-electric-mode))

(setq ruby-indent-level 2)

(use-package rvm
  :ensure t)
(rvm-use-default)
