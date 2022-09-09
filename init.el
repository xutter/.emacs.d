;; package
(require 'package)

(setq package-archives '(("gnu"          . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa"        . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("stable-melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/stable-melpa/")))

(when (< emacs-major-version 27)
    (package-initialize))
;; (package-refresh-contents)


;; Start as a server when first start
;; (server-start)

(setq treemacs-no-load-time-warnings t)

;; load configure file, almost executable's path
(load-file "~/.emacs.d/config.el")
;; hightlight current line
(global-hl-line-mode 1)
;; disable toolbar
(tool-bar-mode -1)
;; disable menubar
(menu-bar-mode -1)
;; disable scrollbar
(if window-system
    (scroll-bar-mode -1))
;; show parenthesis matching
(show-paren-mode 1)
;; disable alert
(setq visible-bell 0)
;; show line num
(global-linum-mode)
;; show cursor position within line
(column-number-mode 1)
;; make lines wrap at word boundaries
;; (global-visual-line-mode 1)
;; nowrap the line
(toggle-truncate-lines 1)

;; replace yes and no to y and name
(fset 'yes-or-no-p 'y-or-n-p)

(unless (package-installed-p 'evil)
  (package-install 'evil))

(require 'evil)
;; (evil-mode 1)

(defun s-font ()
  (interactive)
  ;; Setting default font
  (set-face-attribute 'default nil :font "SauceCodePro Nerd Font-12")
  ;; Setting Chinese Font
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
		      charset
		      (font-spec :family "宋体" :size 20)
		      ;;(font-spec :family "宋体")
		      )))
(add-to-list 'after-make-frame-functions
	     (lambda (new-frame)
	       (select-frame new-frame)
	       (if window-system
		   (s-font))))
(if window-system
    (s-font))


;; make sure use-package is install and required
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)


;; setting for git
(use-package magit
  :ensure t)


;; setting for ssh
;; (use-package tramp
;;   :ensure t
;;   :init
;;   (setq tramp-ssh-controlmaster-options
;; 	"-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no"))


(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc"))

(use-package org
  :hook
  ((org-mode-hook outline-minor-mode))
  :mode (("\\.org\\'" . org-mode)))

(use-package org-bullets
  :ensure t
  :init
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; (use-package dracula-theme
;;   :ensure t
;;   :init
;;   (load-theme 'dracula t))


;; (use-package inkpot-theme
;;   :ensure t
;;   :init
;;   (load-theme 'molokai t))


(use-package avk-emacs-themes
  :ensure t
  :init
  (load-theme 'avk-daylight t))

;; (use-package solarized-theme
;;   :disabled
;;   :init
;;   (load-theme 'solarized-light t))


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
;; ----------------------------------------------------

;; Provides workspaces with file browsing (tree file viewer)
;; and project management when coupled with `projectile`.
(use-package treemacs
  :ensure t
  :defer t
  :config
  (setq treemacs-width 36
	treemacs-python-executable python-path)
  :bind ("C-c t" . treemacs))


(use-package diminish
  :ensure t)

(use-package projectile
  :diminish projectile-mode
  :hook
  (after-init . projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  ;; (setq projectile-project-search-path '("D:\\git\\" "D:\\CodeWarehouse"))
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
  :diminish eldoc-mode)


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


(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  (yas-reload-all)
  (add-hook 'minibuffer-inactive-mode-hook #'yas-minor-mode)
  (add-hook 'prog-mode-hook #'yas-minor-mode))

;; Integration with the debug server 
(use-package dap-mode
  :ensure t
  :defer t
  :after lsp-mode
  :commands dap-debug
  :hook ((python-mode . dap-ui-mode) (python-mode . dap-mode))
  :config
  (require 'dap-cpptools)
  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra))))


;; optional if you want which-key integration
(use-package which-key
  :ensure t
  :config
  (which-key-mode))


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


;;;;;;;;;
;; yaml
;;;;;;;;;
(use-package yaml-mode
  :ensure t
  :mode (("\\.yaml\\'" . yaml-mode)
	 ("\\.yml\\'" . yaml-mode)))

;;;;;;;;
;; C++
;;;;;;;;
(setq lsp-clangd-binary-path clangd-path)


(setq default-tab-width 4)
(setq tab-width 4)
(setq c-default-style "Linux")
(setq c-basic-offset 4)
(setq indent-tab-mode nil)
(setq inhibit-splash-screen t)
(setq debug-on-error 1)


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
    :initialization-options
    (setq lsp--uri-file-prefix "file://")
;;     :initialized-fn
;;     (lambda (workspace)
;;       (with-lsp-workspace workspace
;; 	;; we send empty settings initially, LSP server will ask for the
;; 	;; configuration of each workspace folder later separately
;; 	(lsp--set-configuration
;; 	 (make-hash-table :test 'equal))))
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
  (message ">>>> dd/load-venv\n" (get-buffer "*Message*"))
  (let ((root (projectile-project-root))
	(buff (get-buffer "*Message*")))
    (if root
        (progn
          (pyvenv-activate (lsp-pyright-locate-venv))
          (message "ACTIVATE_DIR: %s\n" (lsp-pyright-locate-venv))))))


;;;;;;;;;;;;
;; Scheme 
;;;;;;;;;;;;

(require 'cmuscheme)

(use-package paredit
  :ensure t)

;; push scheme interpreter path to exec-path
(push scheme-path exec-path)

;; scheme interpreter name
(setq scheme-program-name "scheme")

;; bypass the interactive question and start the default interpreter
(defun scheme-proc ()
  "Return the current Scheme process, starting one if necessary."
  (unless (and scheme-buffer
               (get-buffer scheme-buffer)
               (comint-check-proc scheme-buffer))
    (save-window-excursion
      (run-scheme scheme-program-name)))
  (or (scheme-get-process)
      (error "No current process. See variable `scheme-buffer'")))

(defun switch-other-window-to-buffer (name)
    (other-window 1)
    (switch-to-buffer name)
    (other-window 1))

(defun scheme-split-window ()
  (cond
   ((= 1 (count-windows))
    (split-window-vertically (floor (* 0.68 (window-height))))
    ;; (split-window-horizontally (floor (* 0.5 (window-width))))
    (switch-other-window-to-buffer "*scheme*"))
   ((not (member "*scheme*"
               (mapcar (lambda (w) (buffer-name (window-buffer w)))
                       (window-list))))
    (switch-other-window-to-buffer "*scheme*"))))

(defun scheme-send-last-sexp-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-last-sexp))

(defun scheme-send-definition-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-definition))

(add-hook 'scheme-mode-hook
  (lambda ()
    (paredit-mode 1)
    (define-key scheme-mode-map (kbd "<f5>") 'scheme-send-last-sexp-split-window)
    (define-key scheme-mode-map (kbd "<f6>") 'scheme-send-definition-split-window)))

(add-hook 'emacs-lisp-mode-hook
  (lambda ()
    (paredit-mode 1)
    (define-key scheme-mode-map (kbd "<f5>") 'scheme-send-last-sexp-split-window)
    (define-key scheme-mode-map (kbd "<f6>") 'scheme-send-definition-split-window)))

(require 'rainbow-delimiters)
(add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

(eldoc-add-command
 'paredit-backward-delete
 'parent-close-round)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d97a01782bb52080db89146b528036515b42513539659a00fbed472703e64330" "b494aae329f000b68aa16737ca1de482e239d44da9486e8d45800fd6fd636780" "be2e93e3bf85f91d3fc120cc6627360c8f4eae1829f8ce00e53d8d6eac29fee3" "0ab2aa38f12640ecde12e01c4221d24f034807929c1f859cbca444f7b0a98b3a" "776c1ab52648f98893a2aa35af2afc43b8c11dd3194a052e0b2502acca02bfce" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "d6692db3e3ba6dbfd61473ad89794abe234fa2eceed977dcff279fda96316e2e" default))
 '(package-selected-packages
   '(diminish compat gnu-elpa-keyring-update evil org-bullets avk-emacs-themes org rainbow-delimiters paredit molokai-theme anaconda-mode with-venv counsel-projectile dracula-theme ubuntu-theme cedit inkpot-theme counsel-gtags all-the-icons-dired all-the-icons-ibuffer spaceline-all-the-icons treemacs treemacs-icons-dired pcre2el 0blayout treemacs-all-the-icons counsel-etags ipython-shell-send grip-mode reveal-in-osx-finder org-re-reveal-ref solarized-theme swiper ruby-tools web-mode which-key ## js3-mode imenus ox-reveal helm-flycheck rjsx-mode js2-mode tide avy-flycheck helm ccls ivy-avy flycheck slime python-mode lorem-ipsum hydra helm-xref))
 '(safe-local-variable-values '((encoding . utf-8))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;Set your lisp system and optionally, some contribs
(setq inferior-lisp-program sbcl-path)
(setq slime-contribs '(slime-fancy))
(put 'upcase-region 'disabled nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (scheme . t)
   (python . t)))
