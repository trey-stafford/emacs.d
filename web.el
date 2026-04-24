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

; Guard the tern load-path addition: only add it if the directory exists.
(let ((tern-dir (expand-file-name "~/code/tern/emacs/")))
  (when (file-directory-p tern-dir)
    (add-to-list 'load-path tern-dir)
    (autoload 'tern-mode "tern.el" nil t)
    (autoload 'tern-mode "tern-auto-complete.el" nil t)
    (eval-after-load 'tern
       '(progn
          (require 'tern-auto-complete)
          (tern-ac-setup)))))

; TypeScript / TSX / JSX via tide
(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

(use-package web-mode
  :ensure t)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "jsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; configure jsx-tide checker to run after your default jsx checker
(flycheck-add-mode 'javascript-eslint 'web-mode)
(setq web-mode-markup-indent-offset 2)
(setq typescript-indent-level 2)
