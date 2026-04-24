; elpy (python) mode
; (use-package elpy
;   :ensure t
;   :config
;   (elpy-enable)
;   (setenv "WORKON_HOME" "~/miniconda3/envs")
;   (pyvenv-mode 1))

; Uncomment to enable 'black' auto-formatting on save. Has drawbacks.
; (add-hook 'elpy-mode-hook (lambda ()
;                             (add-hook 'before-save-hook
;                                       'elpy-black-fix-code nil t)))


; (flycheck-define-checker
;     python-mypy ""
;     :command ("mypy"
;               "--ignore-missing-imports"
;               "--python-version" "3.10"
;               source-original)
;     :error-patterns
;     ((error line-start (file-name) ":" line ": error:" (message) line-end))
;     :modes python-mode)
; 
; (add-to-list 'flycheck-checkers 'python-mypy t)
; (flycheck-add-next-checker 'python-mypy t)

; TODO only apply this keybinding in python-mode files
; (general-define-key
;  :keymaps 'python-mode
;  "g l" 'elpy-goto-definition)
; (general-define-key "g l" 'elpy-goto-definition)

; Ein
; (use-package ein
;     :ensure t)

; (use-package pyvenv
;   :ensure t
;   :config(pyvenv-mode 1))

(use-package pyvenv
  :ensure t
  :config
  (setenv "WORKON_HOME" "/home/trst2284/miniconda3/envs/")
  (pyvenv-mode 1)
  (pyvenv-tracking-mode 1))

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (
         ;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (python-mode . lsp)
         )
  :commands lsp)

(use-package helm-lsp :commands helm-lsp-workspace-symbol)
