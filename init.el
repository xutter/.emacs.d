(setq package-archives '(("gnu"          . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa"        . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
                         ("org"          . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

(server-start)

(tool-bar-mode -1)

(menu-bar-mode -1)

;; Show paren 
(show-paren-mode 1)

;; Disable error alert
(setq visible-bell 1)

(package-initialize)
(global-linum-mode)

(visual-line-mode 1)
(set-default 'truncate-lines t)

;;(when (member "Source Code Pro" (font-family-list))
;;  (set-frame-font "Source Code Pro-10" t t))
;; ============================================================
;; Setting English Font
(set-face-attribute 'default nil :font "SauceCodePro Nerd Font-12")
(set-fontset-font t 'unicode "Segoe UI Emoji" nil 'prepend)
;; Setting Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
		    charset
		    (font-spec :family "宋体" :size 16)))
;;(setq fonts '("Consolas" "仿宋"))
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
  :init (setq markdown-command "C:\\prog\\Pandoc\\pandoc.exe"))

(use-package inkpot-theme
  :ensure t
  :init
  (load-theme 'inkpot t))

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
(global-set-key (kbd "C-c t") 'treemacs)
(global-set-key (kbd "C-;") 'comment-line)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(use-package projectile
  :diminish projectile-mode
  :hook
  (after-init . projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (setq projectile-project-search-path '("~/foo/projects" "~/foo/reports"))
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
  :diminish eldoc-mode)

(use-package lsp-mode
  :ensure t
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
       	 (go-mode . lsp-deferred)
         (c++-mode . lsp-deferred)
	 (python-mode . lsp-deferred)
         (yaml-mode . lsp-deferred)
         ;; (tex-mode .lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :custom
  (lsp-diagnostics-provider :capf)
  (lsp-headerline-breadcrumb-enable t)
  (lsp-headerline-breadcrumb-segments '(project file symbols))
  (lsp-lens-enable nil)
  (lsp-disabled-clients '((python-mode . pyls)))
  :init
  (setq lsp-keymap-prefix "C-l") ;; Or 'C-l', 's-l'
  :commands (lsp lsp-deferred))
;;Set up before-save hooks to format buffer and add/delete imports.
;;Make sure you don't have other gofmt/goimports hooks enabled.

;; Provides visual help in the buffer 
;; For example definitions on hover. 
;; The `imenu` lets me browse definitions quickly.
(use-package lsp-ui
  :ensure t
  :defer t
  :after lsp-mode
  :custom
  (lsp-ui-doc-show-with-cursor nil)
  :config
  (setq lsp-ui-sideline-enable nil
	lsp-ui-doc-delay 2
	lsp-ui-doc-position 'bottom)
  :hook (lsp-mode . lsp-ui-mode)
  :bind (:map lsp-ui-mode-map
	      ("C-c i" . lsp-ui-imenu)))

;; if you are helm user
(use-package helm-lsp
  :ensure t
  :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-treemacs
  :ensure t
  :after
  (lsp-mode treemacs)
  :commands lsp-treemacs-errors-list)

(use-package yasnippet
  :ensure t)
(yas-global-mode 1)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

;; optional if you want which-key integration
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Integration with the debug server 
(use-package dap-mode
  :ensure t
  :defer t
  :after lsp-mode
  :config
  (dap-auto-configure-mode))

;;Company mode is a standard completion package that works well with lsp-mode.
;;company-lsp integrates company mode completion with lsp-mode.
;;completion-at-point also works out of the box but doesn't support snippets.

(use-package company
  :ensure t
  :defer t
  :diminish
  :config
  (setq company-dabbrev-other-buffers t
        company-dabbrev-code-other-buffers t
	company-idle-delay 0
	company-minimum-prefix-length 1)
  :hook ((text-mode . company-mode)
         (prog-mode . company-mode)))

(use-package company-lsp
  :ensure t
  :commands company-lsp)

;; C++-mode language protocol
(setq lsp-clangd-binary-path "C:\\prog\\LLVM\\bin\\clangd.exe")

;; YAML
(use-package yaml-mode
  :ensure t
  :mode (("\\.yaml\\'" . yaml-mode)))

;; Latex
(use-package lsp-latex
  :ensure t
  :config
  (with-eval-after-load "tex-mode"
    (add-hook 'tex-mode-hook 'lsp)
    (add-hook 'latex-mode-hook 'lsp))
  (with-eval-after-load "yatex"
    (add-hook 'yatex-mode-hook 'lsp))
  (with-eval-after-load "bibtex"
    (add-hook 'bibtex-mode-hook 'lsp)))

;;Golang
(use-package go-mode
  :ensure t
  :mode (("\\.go\\'" . go-mode))
  :init
  (add-hook 'go-mode-hook
            (lambda ()
              (setq tab-width 4)
              (setq indent-tabs-mode nil)
	      (add-hook 'before-save-hook #'lsp-format-buffer t t)
	      (add-hook 'before-save-hook #'lsp-organize-imports t t)))
  :hook
  ((outline-mode . go-mode)))
;; Built-in Python utilities
(use-package python
  :ensure t
  :config
  ;; Remove guess indent python message
  (setq python-indent-guess-indent-offset-verbose nil)
  ;; Use IPython when available or fall back to regular Python 
  (cond
   ((executable-find "ipython")
    (progn
      (setq python-shell-buffer-name "IPython")
      (setq python-shell-interpreter "ipython")
      (setq python-shell-interpreter-args "-i --simple-prompt")))
   ((executable-find "python3")
    (setq python-shell-interpreter "python3"))
   ((executable-find "python2")
    (setq python-shell-interpreter "python2"))
   (t
    (setq python-shell-interpreter "python3"))))

;; Hide the modeline for inferior python processes
(use-package inferior-python-mode
  :ensure nil
  :hook (inferior-python-mode . hide-mode-line-mode))

;; Required to hide the modeline 
(use-package hide-mode-line
  :ensure t
  :defer t)
;; Required to easily switch virtual envs 
;; via the menu bar or with `pyvenv-workon` 
;; Setting the `WORKON_HOME` environment variable points 
;; at where the envs are located. I use miniconda. 
(use-package pyvenv
  :ensure t
  :defer t
  :config
  ;; Setting work on to easily switch between environments
  (setenv "WORKON_HOME" (expand-file-name "C:\\prog\\Miniconda3\\envs"))
  ;; Display virtual envs in the menu bar
  (setq pyvenv-menu t)
  ;; Restart the python process when switching environments
  (add-hook 'pyvenv-post-activate-hooks (lambda ()
					  (pyvenv-restart-python)))
  :hook (python-mode . pyvenv-mode))
;; Python pyright
(use-package lsp-pyright
  :ensure t
  :defer t
  :config
  (setq lsp-clients-python-library-directories
	'("C:\\prog\\Miniconda3\\pkgs"
	  "C:\\prog\\Miniconda3\\Lib"
	  "C:\\proj\\Miniconda3\\Lib\site-packages"))
  (setq lsp-pyright-disable-language-service nil
	lsp-pyright-disable-organize-imports nil
	lsp-pyright-auto-import-completions t
	lsp-pyright-use-library-code-for-types t
	lsp-pyright-auto-search-paths t
	lsp-pyright-venv-path "C:\\ProgramData\\Miniconda3\\envs")
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))  ; or lsp-deferred

(require 'font-lock)
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

;;For ruby
(setq ruby-ls "solargraph")
(add-to-list 'load-path "~/.emacs.d/elpa/solargraph/")
(require 'solargraph)
;;(define-key ruby-mode-map (kbd "M-i") 'solargraph:complete)
;;Auto-complete setup

(require 'ac-solargraph)
;;(define-key ruby-mode-map (kbd "M-i") 'solargraph:complete)
;;(require 'tide)

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
 '(custom-safe-themes
   '("e7ba99d0f4c93b9c5ca0a3f795c155fa29361927cadb99cfce301caf96055dfd" "3b8284e207ff93dfc5e5ada8b7b00a3305351a3fb222782d8033a400a48eca48" "d6692db3e3ba6dbfd61473ad89794abe234fa2eceed977dcff279fda96316e2e" default))
 '(package-selected-packages
   '(lsp-latex counsel-projectile lsp-pyright twilight-theme zenburn-theme inkpot-theme all-the-icons-dired all-the-icons-ivy all-the-icons-completion all-the-icons-ibuffer all-the-icons-ivy-rich treemacs-all-the-icons all-the-icons counsel-etags yaml-mode yaml pcre2el auto-complete reveal-in-osx-finder org-re-reveal-ref solarized-theme swiper ruby-tools web-mode which-key ## js3-mode imenus ox-reveal helm-flycheck rjsx-mode js2-mode tide avy-flycheck helm ccls ivy-avy company-lsp lsp-ivy flycheck lsp-ui dap-mode lsp-mode slime python-mode lorem-ipsum)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;Set your lisp system and optionally, some contribs
(setq inferior-lisp-program "c:\\prog\\SteelBankCommonLisp\\sbcl.exe")
(setq slime-contribs '(slime-fancy))
