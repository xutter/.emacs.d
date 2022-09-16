;;;;;;;;;
;; yaml
;;;;;;;;;
(use-package yaml-mode
  :ensure t
  :mode (("\\.yaml\\'" . yaml-mode)
	 ("\\.yml\\'" . yaml-mode)))

(provide 'about-lsp-yaml)