(setq package-archives '(("gnu"          . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa"        . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("stable-melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/stable-melpa/")
                         ("org"          . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

;; Start as a server when first start
(server-start)

;; disable toolbar
(tool-bar-mode -1)

;;disable menubar
(menu-bar-mode -1)

;; disable scrollbar
(scroll-bar-mode -1)

;; show parenthesis matching
(show-paren-mode 1)

;; disable 
(setq visible-bell 0)

(package-initialize)
(global-linum-mode)

(visual-line-mode 1)
(toggle-truncate-lines 1)

;; Setting English Font
(set-face-attribute 'default nil :font "SauceCodePro Nerd Font-10")
;; Setting Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
		    charset
		    (font-spec :family "宋体" :size 16))) 

(require 'use-package)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "C:\\Pandoc\\pandoc.exe"))
;; (use-package dracula-theme
;;   :ensure t
;;   :init
;;   (load-theme 'dracula t))
(use-package inkpot-theme
  :ensure t
  :init
  (load-theme 'inkpot t))
(use-package solarized-theme
  :disabled
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
(global-set-key (kbd "C-c s") 'counsel-etags-grep)
(global-set-key (kbd "C-;")   'comment-line)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(use-package lsp-mode
  :ensure t
  :commands
  (lsp lsp-deferred)
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
       	 (go-mode . lsp-deferred)
	 (c-mode . lsp-deferred)
         (c++-mode . lsp-deferred)
	 (python-mode . lsp-deferred)
	 (yaml-mode . lsp-deferred)
	 (latex-mode . lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :custom
  (lsp-diagnostics-provider :capf)
  (lsp-headerline-breadcrumb-enable t)
  (lsp-headerline-breadcrumb-segments '(project file symbols))
  (lsp-lens-enable nil)
  (lsp-disabled-clients '((python-mode . pyls)))
  :init
  (setq lsp-keymap-prefix "C-l") ;; Or 'C-l', 's-l'
  :commands
  (lsp lsp-deferred))

;; The default is 800 kilobytes. Measured in bytes
(setq gc-cons-threshold (* 100 1024 1024) ;; 100 MB
      read-process-output-max (* 1 1024 1024) ;; 1MB
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1) ;; clangd is fast
(use-package projectile
  :diminish projectile-mode
  :hook
  (after-init . projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (setq projectile-project-search-path '("D:\\git\\" "D:\\CodeWarehouse"))
  (setq projectile-switch-project-action #'projectile-dired)
  :custom
  (projectile-completion-system 'ivy)
  (projectile-dynamic-mode-line nil)
  (projectile-enable-caching t)
  (projectile-indexing-method 'hybrid)
  (projectile-track-known-projects-automatically nil))

(use-package counsel-projectile
  :ensure t
  :config (counsel-projectile-mode))

(use-package eldoc
  :ensure t
  :diminish eldoc-mode
  )

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
  (setq lsp-ui-doc-position 'bottom
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
(use-package yasnippet :ensure t)
(yas-global-mode 1)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

;; Integration with the debug server 
(use-package dap-mode
  :ensure t
  :defer t
  :after lsp-mode
  :config
  (dap-auto-configure-mode))

(use-package dap-cpptools) ;;to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Provides workspaces with file browsing (tree file viewer)
;; and project management when coupled with `projectile`.

(use-package treemacs
  :ensure t
  :defer t
  :config
  (setq treemacs-width 36)
  :bind ("C-c t" . treemacs))

;;Company mode is a standard completion package that works well with lsp-mode.
;;company-lsp integrates company mode completion with lsp-mode.
;;completion-at-point also works out of the box but doesn't support snippets.
;; Provides completion, with the proper backend
;; it will provide Python completion.
(use-package company
  :ensure t
  :defer t
  :diminish
  :config
  (setq company-idle-delay 0
        company-minimum-prefix-length 1
	company-dabbrev-other-buffers t
        company-dabbrev-code-other-buffers t
	lsp-completion-provider :capf)
  :hook ((text-mode . company-mode)
         (prog-mode . company-mode)
	 (scala-mode . company-mode)))

(require 'font-lock)

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

;;Golang

;;Set up before-save hooks to format buffer and add/delete imports.
;;Make sure you don't have other gofmt/goimports hooks enabled.
(use-package go-mode
  :ensure t
  :mode (("\\.go\\'" . go-mode))
  :init
  (add-hook 'go-mode-hook
	    (lambda ()
	      (setq tab-width 4)
              (setq indent-tabs-mode nil)))
  :hook
  ((outline-mode . go-mode)))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; For yaml
(use-package yaml-mode
  :ensure t
  :mode (("\\.yaml\\'" . yaml-mode)
	 ("\\.yml\\'" . yaml-mode)))

;; For C++
(setq lsp-clangd-binary-path "C:\\LLVM\\bin\\clangd.exe")
(setq lsp-clients-clangd-library-directories
      '("C:\\LLVM\\lib"
	"C:\\Microsoft\ Visual\ Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\lib\\x64"
	"C:\\Microsoft\ Visual\ Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include"
	"C:\\Program\ Files\ (x86)\\Windows Kits\\10\\Lib\\10.0.19041.0\\ucrt\\x64"
	"C:\\Program\ Files\ (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt"
	"C:\\Program\ Files\ (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\cppwinrt\\winrt"
	"C:\\Program\ Files\ (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\shared"
	"C:\\Program\ Files\ (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\um"
	"C:\\Program\ Files\ (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\winrt"))

;; For ruby
(setq ruby-ls "solargraph")
(add-to-list 'load-path "~/.emacs.d/elpa/solargraph/")
(require 'solargraph)
;;(define-key ruby-mode-map (kbd "M-i") 'solargraph:complete)
;;Auto-complete setup

(require 'ac-solargraph)
;;(define-key ruby-mode-map (kbd "M-i") 'solargraph:complete)

(setq default-tab-width 4)
(setq tab-width 4)
(setq c-default-style "Linux")
(setq c-basic-offset 4)
(setq indent-tab-mode nil)
(setq inhibit-splash-screen t)
(load-file "~/.emacs.d/python-config.el")
(setq treemacs-python-executable "C:/ProgramData/Miniconda3/python.exe")
;; (setq debug-on-error 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("0ab2aa38f12640ecde12e01c4221d24f034807929c1f859cbca444f7b0a98b3a" "776c1ab52648f98893a2aa35af2afc43b8c11dd3194a052e0b2502acca02bfce" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "d6692db3e3ba6dbfd61473ad89794abe234fa2eceed977dcff279fda96316e2e" default))
 '(package-selected-packages
   '(counsel-projectile dracula-theme ubuntu-theme cedit inkpot-theme counsel-gtags all-the-icons-dired all-the-icons-ibuffer spaceline-all-the-icons treemacs treemacs-icons-dired pcre2el 0blayout treemacs-all-the-icons counsel-etags ipython-shell-send grip-mode reveal-in-osx-finder org-re-reveal-ref solarized-theme swiper ruby-tools web-mode which-key ## js3-mode imenus ox-reveal helm-flycheck rjsx-mode js2-mode tide avy-flycheck helm ccls ivy-avy flycheck slime python-mode lorem-ipsum hydra helm-xref))
 '(safe-local-variable-values '((encoding . utf-8))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;Set your lisp system and optionally, some contribs
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))
