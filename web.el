; CSS mode 
(use-package css-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.less\\'" . css-mode)))

(add-hook 'css-mode-hook
      (lambda ()
        (setq tab-width 2)))

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; adjust indents for web-mode to 2 spaces
; (defun my-web-mode-hook ()
;   "Hooks for Web mode. Adjust indents"
;   ;;; http://web-mode.org/
;   (setq web-mode-markup-indent-offset 2)
;   (setq web-mode-css-indent-offset 2)
;   (setq web-mode-code-indent-offset 2))
; (add-hook 'web-mode-hook  'my-web-mode-hook)

;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

; use js2-mode for js
(use-package js2-mode
  :ensure t
  :config
  (setq js2-basic-offset 2))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

; use rjsx-mode for jsx
(use-package rjsx-mode
  :ensure t
  :config
  (setq js2-basic-offset 2))

(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . rjsx-mode))

; Temporary to see if this works well for autocompleting etc. in js
(add-to-list 'load-path "/home/trst2284/code/tern/emacs/")
(autoload 'tern-mode "tern.el" nil t)
(autoload 'tern-mode "tern-auto-complete.el" nil t)

(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

; (add-to-list 'company-backends 'company-tern)
