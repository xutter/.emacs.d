;;;;;;;;;;;;;
;; package
;;;;;;;;;;;;;

(require 'package)

(setq package-archives '(("gnu"          . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa"        . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("stable-melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/stable-melpa/")))

(when (< emacs-major-version 27)
    (package-initialize))
;; (package-refresh-contents)


;;;;;;;;;;;;;;;;;
;; use-package
;;;;;;;;;;;;;;;;;

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; Start as a server when first start
;; (server-start)

(add-to-list 'load-path (expand-file-name "settings" user-emacs-directory))

(require 'about-base)

(require 'about-theme)

(require 'about-org)

(require 'about-font)

(require 'about-input)

(require 'about-mise)

(require 'about-lsp-mode)

(require 'about-scheme)

(require 'about-lisp)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d97a01782bb52080db89146b528036515b42513539659a00fbed472703e64330" "b494aae329f000b68aa16737ca1de482e239d44da9486e8d45800fd6fd636780" "be2e93e3bf85f91d3fc120cc6627360c8f4eae1829f8ce00e53d8d6eac29fee3" "0ab2aa38f12640ecde12e01c4221d24f034807929c1f859cbca444f7b0a98b3a" "776c1ab52648f98893a2aa35af2afc43b8c11dd3194a052e0b2502acca02bfce" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "d6692db3e3ba6dbfd61473ad89794abe234fa2eceed977dcff279fda96316e2e" default))
 '(package-selected-packages
   '(plantuml-mode poly-markdown dap-mode bui magit diminish compat gnu-elpa-keyring-update evil org-bullets avk-emacs-themes org rainbow-delimiters paredit molokai-theme anaconda-mode with-venv counsel-projectile dracula-theme ubuntu-theme cedit inkpot-theme counsel-gtags all-the-icons-dired all-the-icons-ibuffer spaceline-all-the-icons treemacs treemacs-icons-dired pcre2el 0blayout treemacs-all-the-icons counsel-etags ipython-shell-send grip-mode reveal-in-osx-finder org-re-reveal-ref solarized-theme swiper ruby-tools web-mode which-key ## js3-mode imenus ox-reveal helm-flycheck rjsx-mode js2-mode tide avy-flycheck helm ccls ivy-avy flycheck slime python-mode lorem-ipsum hydra helm-xref))
 '(safe-local-variable-values '((encoding . utf-8))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



(put 'scroll-left 'disabled nil)
