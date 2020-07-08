(setq package-archives '(("gnu"          . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("melpa"        . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			 ("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
			 ("org"          . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

(package-initialize)
(column-number-mode t)

(require 'use-package)

;;Lanage Server
(use-package lsp-mode
	     :ensure t
	     :commands (lsp lsp-deferred)
	     :hook (go-mode . lsp-deferred))
(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)

(use-package ccls
	     :hook ((c-mode c++-mode objc-mode cuda-mode) .
		    (lambda () (require 'ccls) (lsp))))

(setq ccls-executable "/usr/bin/ccls")

;;Golang
(defun lsp-go-install-save-hooks ()
	(add-hook 'before-save-hook #'lsp-format-buffer t t)
	(add-hook 'before-save-hook #'lsp-organize-imports t t))
(use-package go-mode
	     :ensure t
	     :mode (("\\.go\\'" . go-mode))
	     :init
	     (add-hook 'go-mode-hook #'lsp-go-install-save-hooks))

;;JavaScript, TypeScript, CoffeeScript
(require 'tide)

(dolist (hook (list
               'js2-mode-hook
               'rjsx-mode-hook
               'typescript-mode-hook
               ))
  (add-hook hook (lambda ()
                   ;; 初始化 tide
                   (tide-setup)
                   ;; 当 tsserver 服务没有启动时自动重新启动
                   (unless (tide-current-server)
                     (tide-restart-server))
                   )))

(setq-default tab-width 4)
(setq-default indent-tab-mode nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(rjsx-mode js2-mode tide avy-flycheck helm ccls ivy-avy company-lsp lsp-ivy flycheck lsp-ui dap-mode lsp-mode slime python-mode lorem-ipsum))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;Set your lisp system and optionally, some contribs
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))
