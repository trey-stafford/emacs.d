; pyvenv: virtualenv support.
; WORKON_HOME can be set in the environment; falls back to ~/miniconda3/envs/.
(use-package pyvenv
  :ensure t
  :config
  (setenv "WORKON_HOME" (or (getenv "WORKON_HOME")
                            (expand-file-name "~/miniconda3/envs/")))
  (pyvenv-mode 1)
  (pyvenv-tracking-mode 1))

; lsp-mode: base LSP client (no python-mode hook here; lsp-pyright handles it).
(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :commands lsp)

; lsp-pyright: Pyright language server backend for lsp-mode.
; Provides diagnostics, go-to-definition, and autocomplete for Python.
; lsp-deferred defers startup until the buffer is actually visible and
; interacted with, so persp-mode restoring background buffers will not
; trigger LSP initialization for every saved project simultaneously.
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp-deferred))))

; lsp-ui: inline diagnostics, hover docs, and peek definitions.
(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode))

; helm-lsp: helm interface for LSP workspace symbols.
(use-package helm-lsp
  :ensure t
  :commands helm-lsp-workspace-symbol)
