;;;;;;;;;;;
;; Golang
;;;;;;;;;;;
(use-package go-mode
  :ensure t
  :mode (("\\.go\\'" . go-mode))
  :init
  (add-hook 'go-mode-hook
	    (lambda ()
	      (setq tab-width 4)
              (setq indent-tabs-mode nil)))
  (add-hook 'go-mode-hook 'outline-minor-mode))


;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(provide 'about-lsp-go)
