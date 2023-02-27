;; (unless (package-installed-p 'evil)
;;   (package-install 'evil))
;;
;; (require 'evil)
;; (evil-mode 1)


;; setting for git
(use-package magit
  :ensure t)

;; setting for tree-sitter
(use-package tree-sitter
  :ensure
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :ensure)


;; setting for plantuml
(use-package plantuml-mode
  :ensure t
  :mode
  ("\\.puml\\'" . plantuml-mode)
  :init
  (setq plantuml-jar-path plantuml-path)
  (setq plantuml-default-exec-mode 'jar))


(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc"))


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


(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  (yas-reload-all)
  (add-hook 'minibuffer-inactive-mode-hook #'yas-minor-mode)
  (add-hook 'prog-mode-hook #'yas-minor-mode))


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
(global-font-lock-mode 1)

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))


(provide 'about-mise)
