; elpy (python) mode
(use-package elpy
  :ensure t
  :config
  (elpy-enable)
  (setenv "WORKON_HOME" "~/miniconda3/envs")
  (pyvenv-mode 1))


; Ein
(use-package ein
    :ensure t)
