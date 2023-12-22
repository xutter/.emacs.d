;; setting for git
;;(use-package magit
;;  :defer t)


;; setting for mind-map based on graphviz
(use-package graphviz-dot-mode
  :defer t)


;; setting for latex
(use-package auctex
  :defer t
  :config
  (setq TeX-auto-save t)
  (setq-default TeX-engine 'xetex))

;; setting for plantuml
(use-package plantuml-mode
  :mode
  ("\\.puml\\'" . plantuml-mode)
  :init
  (setq plantuml-jar-path plantuml-path)
  (setq plantuml-default-exec-mode 'jar))


(if (> emacs-major-version 27)
  (use-package markdown-mode
    :commands (markdown-mode gfm-mode)
    :mode (("README\\.md\\'" . gfm-mode)
           ("\\.md\\'" . markdown-mode)
           ("\\.markdown\\'" . markdown-mode))
    :init (setq markdown-command "pandoc"))
  (use-package markdown-preview-mode
    :defer t))


;; Provides workspaces with file browsing (tree file viewer)
;; and project management when coupled with `projectile`.
(use-package treemacs
  :config
  (setq treemacs-width 36
	treemacs-python-executable python-path)
  :bind ("C-c t" . treemacs))


(use-package diminish)

(use-package projectile
  ;; :diminish projectile-mode
  :hook
  (after-init . projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :custom
  (projectile-completion-system 'ivy)
  (projectile-dynamic-mode-line nil)
  (projectile-enable-caching t)
  (projectile-indexing-method 'hybrid)
  (projectile-track-known-projects-automatically nil))


(use-package counsel-projectile
  :defer t
  :config (counsel-projectile-mode))


(require 'eldoc)

(use-package yasnippet
  :config
  (yas-global-mode 1)
  (yas-reload-all)
  (add-hook 'minibuffer-inactive-mode-hook #'yas-minor-mode)
  (add-hook 'prog-mode-hook #'yas-minor-mode))


;; optional if you want which-key integration
(use-package which-key
  :config
  (which-key-mode))


;;Company mode is a standard completion package that works well with lsp-mode.
;;company-lsp integrates company mode completion with lsp-mode.
;;completion-at-point also works out of the box but doesn't support snippets.
;; Provides completion, with the proper backend
;; it will provide Python completion.
(use-package company
  :defer t
  :diminish company-mode
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
(global-font-lock-mode 1)

(use-package all-the-icons
  :defer t
  :if (display-graphic-p))


(provide 'sh-mise)
