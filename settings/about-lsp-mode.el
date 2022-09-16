;; -------------------------------------------------------------
(use-package lsp-mode
  :ensure t
  :commands
  (lsp lsp-deferred)
  :hook
  ((go-mode . lsp-deferred)
   (c-mode . lsp-deferred)
   (c++-mode . lsp-deferred)
   (yaml-mode . lsp-deferred)
   (latex-mode . lsp-deferred)
   (ruby-mode . lsp-deferred)
   (python-mode . lsp-deferred)
   ;; if you want which-key integration
   (lsp-mode . lsp-enable-which-key-integration))
  :custom
  (lsp-diagnostics-provider :capf)
  (lsp-headerline-breadcrumb-enable t)
  (lsp-headerline-breadcrumb-segments '(project file symbols))
  (lsp-lens-enable nil)
  (setq lsp-enable-file-watchers nil)
  :init
  (setq lsp-keymap-prefix "C-l") ;; Or 'C-l', 's-l'
  (setq lsp-log-io t)
  :commands
  (lsp lsp-deferred)
  :config
  (setq lsp-pyright-log-level "trace")
  (setq lsp-enable-file-watchers nil)
  (setq gc-cons-threshold (* 100 1024 1024))
  (setq read-process-output-max (* 1 1024 1024))
)


;; The default is 800 kilobytes. Measured in bytes
(setq gc-cons-threshold (* 100 1024 1024) ;; 100 MB
      read-process-output-max (* 1 1024 1024) ;; 1MB
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1) ;; clangd is fast

;; Provides visual help in the buffer 
;; For example definitions on hover. 
;; The `imenu` lets me browse definitions quickly.
(use-package lsp-ui
  :ensure t
  :defer t
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-show-with-cursor nil)
  :config
  (setq
   lsp-ui-doc-enable nil
   lsp-ui-doc-header t
   lsp-ui-doc-include-signature t
   lsp-ui-doc-border (face-foreground 'default)
   lsp-ui-sideline-show-code-actions t
   lsp-ui-sideline-delay 0.05
   lsp-ui-doc-position 'bottom
   lsp-ui-sideline-enable nil
   lsp-ui-doc-delay 2)
  :bind (:map lsp-ui-mode-map
	      ("C-c i" . lsp-ui-imenu)))


;; if you are helm user
(use-package helm-lsp
  :commands helm-lsp-workspace-symbol)


;; if you are ivy user
(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)


(use-package lsp-treemacs
  :ensure t
  :after
  (lsp-mode treemacs)
  :commands
  lsp-treemacs-errors-list)


;; Integration with the debug server 
;; (use-package dap-mode
;;   :ensure t
;;   :defer t
;;   :after lsp-mode
;;   :commands dap-debug
;;   :hook ((python-mode . dap-ui-mode) (python-mode . dap-mode))
;;   :config
;;   (require 'dap-cpptools)
;;   (add-hook 'dap-stopped-hook
;;             (lambda (arg) (call-interactively #'dap-hydra))))

(require 'about-lsp-go)

(require 'about-lsp-cpp)

(require 'about-lsp-yaml)

(require 'about-lsp-python)

(provide 'about-lsp-mode)