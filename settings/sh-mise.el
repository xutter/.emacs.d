;; setting for git
;;(use-package magit
;;  :defer t)


;; setting for mind-map based on graphviz
(use-package graphviz-dot-mode
  :defer t)

(defvar sh-pdf-tools-enabled nil)
(defvar sh-pdf-tools-init-failed nil)

(defun sh-ensure-pdf-tools ()
  (or sh-pdf-tools-enabled
      (unless sh-pdf-tools-init-failed
        (setq sh-pdf-tools-enabled
              (and (display-graphic-p)
                   (not (eq system-type 'cygwin))
                   (require 'pdf-tools nil t)
                   (ignore-errors
                     (pdf-tools-install)
                     t)))
        (unless sh-pdf-tools-enabled
          (setq sh-pdf-tools-init-failed t)))))

(defun sh-open-pdf-file ()
  (if (sh-ensure-pdf-tools)
      (pdf-view-mode)
    (doc-view-mode)))

(add-to-list 'auto-mode-alist '("\\.pdf\\'" . sh-open-pdf-file))

(use-package pdf-tools
  :if (and (display-graphic-p)
           (not (eq system-type 'cygwin)))
  :commands (pdf-view-mode pdf-tools-install)
  :hook (pdf-view-mode . (lambda () (display-line-numbers-mode 0))))

(use-package cdlatex
  :defer t
  :hook (LaTeX-mode . turn-on-cdlatex))

;; setting for latex
(use-package auctex
  :defer t
  :config
  (setq TeX-command-extra-options "-shell-escape --synctex=1")
  (setq TeX-master nil)
  (setq TeX-auto-save t)
  (setq-default TeX-engine 'xetex)
  (setq TeX-PDF-mode t)
  (setq TeX-source-correlate-mode t)
  (setq TeX-source-correlate-method 'synctex)
  (setq TeX-view-program-selection
        '(((output-dvi has-no-display-manager)
           "dvi2tty")
          ((output-dvi style-pstricks)
           "dvips and gv")
          (output-dvi "xdvi")
          (output-pdf "PDF Tools")
          (output-html "xdg-open"))))

;; Update PDF buffers after successful LaTeX runs
(add-hook 'TeX-after-compilation-finished-functions
          #'TeX-revert-document-buffer)

;; setting for plantuml
(use-package plantuml-mode
  :mode
  ("\\.puml\\'" . plantuml-mode)
  :init
  (if (and plantuml-path
           (file-exists-p plantuml-path))
      (progn
        (setq plantuml-jar-path plantuml-path)
        (setq plantuml-default-exec-mode 'jar))
    (setq plantuml-default-exec-mode 'executable)
    (setq plantuml-executable-path
          (or (executable-find "plantuml") "plantuml"))))


(use-package markdown-mode
  :if (> emacs-major-version 27)
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  (let ((pandoc-command
         (cond
          ((and pandoc-path (file-exists-p pandoc-path)) pandoc-path)
          ((and pandoc-path (executable-find pandoc-path)) pandoc-path)
          ((executable-find "pandoc") "pandoc"))))
    (when pandoc-command
      (setq markdown-command pandoc-command))))
(use-package markdown-preview-mode
  :if (< emacs-major-version 27)
  :defer t)


;; Provides workspaces with file browsing (tree file viewer)
;; and project management when coupled with `projectile`.
(use-package treemacs
  :defer t
  :bind ("C-c t" . treemacs)
  :config
  (setq treemacs-width 36
	treemacs-python-executable python-path))


(use-package diminish)

(use-package projectile
  ;; :diminish projectile-mode
  :init
  (setq projectile-completion-system (if sh-use-ivy-stack 'ivy 'default))
  :hook
  (after-init . projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :custom
  (projectile-dynamic-mode-line nil)
  (projectile-enable-caching t)
  (projectile-indexing-method 'hybrid)
  (projectile-track-known-projects-automatically nil))


(use-package counsel-projectile
  :if sh-use-ivy-stack
  :after (counsel projectile)
  :config (counsel-projectile-mode))

(use-package yasnippet
  :defer t
  :hook ((prog-mode . yas-minor-mode)
         (text-mode . yas-minor-mode))
  :config
  (yas-reload-all))


;; optional if you want which-key integration
(use-package which-key
  :defer 1
  :config
  (which-key-mode))


;;Company mode is a standard completion package that works well with lsp-mode.
;;company-lsp integrates company mode completion with lsp-mode.
;;completion-at-point also works out of the box but doesn't support snippets.
;; Provides completion, with the proper backend
;; it will provide Python completion.
(use-package company
  :diminish company-mode
  :hook (prog-mode . company-mode)
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1
	company-dabbrev-other-buffers t
        company-dabbrev-code-other-buffers t
	lsp-completion-provider :capf
	company-tooltip-align-annotations t
	company-show-numbers t
	company-selection-wrap-around t
	company-transformers '(company-sort-by-occurrence)))

(use-package company-box
  :ensure t
  :if (display-graphic-p)
  :hook
  (company-mode . company-box-mode))

(defconst sh-company-tabnine-available
  (or (executable-find "TabNine")
      (executable-find "TabNine.exe"))
  "Enable TabNine backend when its executable is available.")

(defun sh-enable-company-tabnine-backend ()
  (setq-local company-backends
              (cons 'company-tabnine
                    (remove 'company-tabnine company-backends))))

(use-package company-tabnine
  :if sh-company-tabnine-available
  :ensure t
  :after company
  :hook (company-mode . sh-enable-company-tabnine-backend))

(defconst sh-enable-all-the-icons
  (and (display-graphic-p)
       (find-font (font-spec :family "all-the-icons")))
  "Enable all-the-icons only when icon fonts are installed.")

(use-package all-the-icons
  :defer t
  :if sh-enable-all-the-icons)


(provide 'sh-mise)
