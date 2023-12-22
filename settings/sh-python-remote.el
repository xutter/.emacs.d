;;;;;;;;;;;
;; Python
;;;;;;;;;;;

(use-package lsp-pyright
  :ensure t
  :defer t
  :config
  (lsp-register-client
   (make-lsp-client
    :new-connection
    (lsp-tramp-connection
     (lambda ()
       (cons "pyright-langserver" ;; (executable-find "pyright-langserver" t)
	     lsp-pyright-langserver-command-args)))
    :major-modes '(python-mode)
    :server-id 'pyright-remote
    :remote? t
    :multi-root lsp-pyright-multi-root
    :priority -1
;;     :initialization-options
;;     (setq lsp--uri-file-prefix "file://")
    :initialized-fn
    (lambda (workspace)
      (with-lsp-workspace workspace
	;; we send empty settings initially, LSP server will ask for the
	;; configuration of each workspace folder later separately
	(lsp--set-configuration
	 (make-hash-table :test 'equal))))
    :notification-handlers
    (lsp-ht ("pyright/beginProgress" 'lsp-pyright--begin-progress-callback)
            ("pyright/reportProgress" 'lsp-pyright--report-progress-callback)
            ("pyright/endProgress" 'lsp-pyright--end-progress-callback))))
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

(provide 'about-lsp-python)