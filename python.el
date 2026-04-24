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
;
; The python-mode hook gates on (get-buffer-window ... t) so that
; persp-mode restoring background buffers at startup does NOT register
; an lsp-deferred idle timer for every saved project.  Only buffers
; that are already displayed in a window (i.e. explicitly opened by the
; user) get Pyright started immediately.
;
; my/lsp-on-python-buffer-visible handles the complementary case: when
; the user later switches to a perspective (or switches buffers) and a
; previously-restored Python buffer becomes visible for the first time,
; window-configuration-change-hook fires and LSP is started then.
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (when (get-buffer-window (current-buffer) t)
                            (lsp-deferred)))))

(defun my/lsp-on-python-buffer-visible ()
  "Start lsp-pyright for any visible Python buffer that has not yet
initialized LSP.  Called from window-configuration-change-hook so
that buffers restored by persp-mode get Pyright only once the user
actually navigates to their perspective."
  (walk-windows
   (lambda (win)
     (with-current-buffer (window-buffer win)
       (when (and (derived-mode-p 'python-mode)
                  (not (bound-and-true-p lsp-mode))
                  buffer-file-name)
         (require 'lsp-pyright)
         (lsp-deferred))))))

(add-hook 'window-configuration-change-hook #'my/lsp-on-python-buffer-visible)

; lsp-ui: inline diagnostics, hover docs, and peek definitions.
(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode))

; helm-lsp: helm interface for LSP workspace symbols.
(use-package helm-lsp
  :ensure t
  :commands helm-lsp-workspace-symbol)
