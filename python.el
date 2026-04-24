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
; Only start LSP if the buffer is currently visible, so that persp-mode
; restoring background buffers at startup does not trigger LSP for every
; saved project simultaneously.
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (when (get-buffer-window (current-buffer) t)
                            (lsp-deferred)))))

; Start LSP when switching to an already-open python buffer that hasn't initialized it yet.
(add-hook 'window-buffer-change-functions
          (lambda (_win)
            (when (and (derived-mode-p 'python-mode)
                       (not (bound-and-true-p lsp-mode)))
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
