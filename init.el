(setq package-archives '(("gnu"          . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa"        . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
                         ("org"          . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

(package-initialize)
(global-linum-mode)

(visual-line-mode 1)
(set-default 'truncate-lines t)

;;(when (member "Source Code Pro" (font-family-list))
;;  (set-frame-font "Source Code Pro-10" t t))
 ;; ============================================================
;; Setting English Font
(set-face-attribute 'default nil :font "Source Code Pro-10")
;; Setting Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
		    charset
		    (font-spec :family "仿宋" :size 15))) 
;;(setq fonts '("Consolas" "仿宋"))
;;(set-fontset-font t 'unicode "Segoe UI Emoji" nil 'prepend)
;;(set-face-attribute 'default nil :font
;;					(format "%s:pixelsize=%d" (car fonts) 14))
;;(set-face-attribute 'default nil :font (font-spec :family "Source Code Pro" :size 14))
;;(set-fontset-font t 'unicode (font-spec :family "Segoe UI Emoji" :size 14))
;;(set-fontset-font t '(#x2ff0 . #x9ffc) (font-spec :family "仿宋" :size 18 :weight 'bold))

(require 'use-package)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "C:\\Pandoc\\pandoc.exe"))

(use-package solarized-theme
  :ensure t
  :init
  (load-theme 'solarized-light t))

(use-package counsel
  :ensure t)

(use-package swiper
  :ensure t)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
(setq lsp-keymap-prefix "C-l")

(use-package lsp-mode
  :ensure t
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
       	 (go-mode . lsp-deferred)
         (c++-mode . lsp-deferred))
  :commands (lsp lsp-deferred))
;;Set up before-save hooks to format buffer and add/delete imports.
;;Make sure you don't have other gofmt/goimports hooks enabled.

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; optionally
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp
  :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list)

(use-package yasnippet
  :ensure t)
(yas-global-mode 1)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)
;; optionally if you want to use debugger
(use-package dap-mode
  :ensure t)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;;Company mode is a standard completion package that works well with lsp-mode.
;;company-lsp integrates company mode completion with lsp-mode.
;;completion-at-point also works out of the box but doesn't support snippets.

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

(use-package company-lsp
  :ensure t
  :commands company-lsp)

;; (use-package ccls
;;   :hook ((c-mode c++-mode objc-mode cuda-mode) . (lambda () (require 'ccls) (lsp))))
;; (setq ccls-executable "/usr/bin/ccls")
;;
(setq lsp-clangd-binary-path "C:\\LLVM\\bin\\clangd.exe")

(use-package lsp-python-ms
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-python-ms)
                         (lsp)))
  :init
  (setq lsp-python-ms-executable "D:\\git\\python-language-server\\output\\bin\\Release\\Microsoft.Python.LanguageServer.exe"))
;; (setq lsp-pyhon-ms-executable "D:\\git\\python-language-server-master\\output\\bin\\Release\\Microsoft.Python.LanguageServer.exe")

;;Golang
;;(defun lsp-go-install-save-hooks ()
;;  (add-hook 'before-save-hook #'lsp-format-buffer t t)
;;  (add-hook 'before-save-hook #'lsp-organize-imports t t))
;;(use-package go-mode
;;  :ensure t
;;  :mode (("\\.go\\'" . go-mode))
;;  ;;:init
;;  ;;(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
;;  :hook
;;  ((before-save . #'lsp-format-buffer)
;;   (before-save . #'lsp-organize-imports)))
;;JavaScript, TypeScript, CoffeeScript
;;(use-package tide
;;  :ensure t
;;  :init
;;  (setq tide-tsserver-executable "/usr/bin/tsserver"))
;;(defun setup-tide-mode()
;;  (interactive)
;;  (tide-setup)
;;  (flycheck-mode +1)
;;  (setq flycheck-check-syntax-automatically '(save-mode-enable))
;;  (tide-hl-identifier-mode +1)
;;  (company-mode +1))
;;(setq company-tooltip-align-annotations t)
;;(add-hook 'before-save-hook 'tide-format-before-save)
;;(add-hook 'typescript-mode-hook #'setup-tide-mode)
;;(add-hook 'js2-mode-hook #'setup-tide-mode)
;;(flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)
;;
;;For ruby
(setq ruby-ls "solargraph")
(add-to-list 'load-path "~/.emacs.d/elpa/solargraph/")
(require 'solargraph)
;;(define-key ruby-mode-map (kbd "M-i") 'solargraph:complete)
;;Auto-complete setup

(require 'ac-solargraph)
;;(define-key ruby-mode-map (kbd "M-i") 'solargraph:complete)
;;(require 'tide)

;;(dolist (hook (list
;;               'js2-mode-hook
;;               'rjsx-mode-hook
;;               'typescript-mode-hook
;;               ))
;;  (add-hook hook (lambda ()
;;                   ;; 初始化 tide
;;                   (tide-setup)
;;                   ;; 当 tsserver 服务没有启动时自动重新启动
;;                   (unless (tide-current-server)
;;                     (tide-restart-server))
;;                   )))
;;

(setq default-tab-width 4)
(setq tab-width 4)
(setq c-default-style "Linux")
(setq c-basic-offset 4)
(setq indent-tab-mode nil)
(setq inhibit-splash-screen t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(reveal-in-osx-finder org-re-reveal-ref solarized-theme swiper ruby-tools web-mode which-key ## js3-mode imenus ox-reveal helm-flycheck rjsx-mode js2-mode tide avy-flycheck helm ccls ivy-avy company-lsp lsp-ivy flycheck lsp-ui dap-mode lsp-mode slime python-mode lorem-ipsum)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;Set your lisp system and optionally, some contribs
(setq inferior-lisp-program "c:\\sbcl\\2.0.0\\sbcl.exe")
(setq slime-contribs '(slime-fancy))
