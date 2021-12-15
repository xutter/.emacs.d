;;; all-the-icons-completion-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "all-the-icons-completion" "all-the-icons-completion.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from all-the-icons-completion.el

(autoload 'all-the-icons-completion-marginalia-setup "all-the-icons-completion" "\
Hook to `marginalia-mode-hook' to bind `all-the-icons-completion-mode' to it." nil nil)

(defvar all-the-icons-completion-mode nil "\
Non-nil if All-The-Icons-Completion mode is enabled.
See the `all-the-icons-completion-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `all-the-icons-completion-mode'.")

(custom-autoload 'all-the-icons-completion-mode "all-the-icons-completion" nil)

(autoload 'all-the-icons-completion-mode "all-the-icons-completion" "\
Add icons to completion candidates.

If called interactively, enable All-The-Icons-Completion mode if
ARG is positive, and disable it if ARG is zero or negative.  If
called from Lisp, also enable the mode if ARG is omitted or nil,
and toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "all-the-icons-completion" '("all-the-icons-completion-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; all-the-icons-completion-autoloads.el ends here
