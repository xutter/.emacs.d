(use-package rime
  :custom
  (default-input-method "rime")
  :config
  (setq rime-share-data-dir "~/.emacs.d/rime-data/"))

(defun set-rime-cursor-style ()
  "Set RIME cursor style for GUI Emacs."
  (setq rime-show-candidate 'posframe)
  (set-face-attribute 'rime-default-face nil
                      :background "yellow"
                      :foreground "black"
                      :family "Microsoft YaHei"
                      :height 160))
(add-hook 'after-init-hook 'set-rime-cursor-style)

(defun set-rime-cursor-style ()
  "Set RIME cursor style for terminal Emacs."
  (setq rime-show-candidate 'minibuffer)
  (set-face-attribute 'rime-preedit-face nil
                      :background "yellow"
                      :foreground "black"
                      :family "SimHei"
                      :height 160))
(add-hook 'after-make-terminal-functions 'set-rime-cursor-style)

(use-package counsel
  :bind
  (("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("C-c s" . counsel-etags-grep)))

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-;")   'comment-line)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)


(provide 'about-input)
