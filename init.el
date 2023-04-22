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

(setq debug-on-error 't)


;; 设置编码为 UTF-8
;; (prefer-coding-system 'utf-8)
;; (set-default-coding-systems 'utf-8)
;; (set-language-environment "UTF-8")
;; (setq locale-coding-system 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)

;;;;;;;;;;;;;;;;;
;; use-package
;;;;;;;;;;;;;;;;;

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; benchmark-init
(use-package benchmark-init
  :config
  (add-hook 'before-init-hook 'benchmark-init/activate)
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

;; Start as a server when first start
;; (server-start)
(add-to-list 'load-path (expand-file-name "emacswiki.org" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "settings" user-emacs-directory))


(require 'about-base)

(require 'about-theme)

(require 'about-org)

(require 'about-font)

(require 'about-input)

(require 'about-mise)

(require 'about-prog)

(require 'about-scheme)

(require 'about-lisp)

(put 'scroll-left 'disabled nil)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file 'noerror))

(provide 'init)
