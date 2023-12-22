;;;;;;;;;;;
;; Python
;;;;;;;;;;;
(use-package lsp-pyright
  :ensure t
  :defer t
  :hook
  (python-mode . (lambda ()
		   (require 'lsp-pyright)
		   (lsp)
		   (autoload-venv))))

(add-hook 'python-mode-hook 'hs-minor-mode)

(use-package pyvenv
  :ensure t
  :init
  (pyvenv-mode 1))


(defun autoload-venv()
  (interactive)
  (if (and (projectile-project-root) (lsp-pyright-locate-venv))
      (progn
        (pyvenv-activate (lsp-pyright-locate-venv))
        (message "ACTIVATE_DIR: %s\n" (lsp-pyright-locate-venv)))))

(provide 'sh-lsp-python)