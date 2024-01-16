;;;;;;;;;;;;;
;; Lisp & Scheme
;;;;;;;;;;;;


(if (not (version< emacs-version "28.1"))
  (use-package cmuscheme
    :demand t))

(use-package paredit
  :init
  (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
  (add-hook 'clojure-mode-hook #'enable-paredit-mode)
  (add-hook 'cider-repl-mode-hook #'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook #'enable-paredit-mode)
  :config
  (show-paren-mode t)
  :diminish nil
  :defer t)

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

(unless (package-installed-p 'rainbow-delimiters)
  (package-install 'rainbow-delimiters))
(require 'rainbow-delimiters)
(add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

(eldoc-add-command
 'paredit-backward-delete
 'parent-close-round)

;Set your lisp system and optionally, some contribs
(setq inferior-lisp-program sbcl-path)
(setq slime-contribs '(slime-fancy))
(put 'upcase-region 'disabled nil)

(provide 'sh-lisp)
