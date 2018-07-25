; elpy (python) mode
(use-package elpy
  :ensure t
  :config
  (elpy-enable)
  (setenv "WORKON_HOME" "~/miniconda3/envs")
  (pyvenv-mode 1))

; TODO only apply this keybinding in python-mode files
; (general-define-key
;  :keymaps 'python-mode
;  "g l" 'elpy-goto-definition)
(general-define-key "g l" 'elpy-goto-definition)

; Ein
(use-package ein
    :ensure t)
