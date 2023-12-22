(add-hook 'org-mode-hook #'outline-minor-mode)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(use-package org-bullets
  :defer t
  :init
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (add-hook 'org-mode-hook 'org-language-load))

(defun org-language-load ()
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (scheme . t)
     (python . t))))

(setq browse-url-browser-function 'browse-url-chromium)
;; 
;; (global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-ca" 'org-agenda)
;; (global-set-key "\C-cc" 'org-capture)
;; (global-set-key "\C-cb" 'org-iswitchb)
;; 
;; (setq org-default-notes-file "~/org/tasks.org")
;; (setq org-capture-templates
;;       '(
;;         ("t" "Todo" entry (file+headline "inbox.org" "Tasks")
;;          "* TODO %?\n  %i\n  %u\n  %a")
;;         ("n" "Note/Data" entry (file+headline "inbox.org" "Notes/Data")
;;          "* %?   \n  %i\n  %u\n  %a")
;;         ("j" "Journal" entry (file+datetree "~/org/journal.org")
;;          "* %?\nEntered on %U\n %i\n %a")
;;         ("J" "Work-Journal" entry (file+datetree "~/org/wjournal.org")
;;          "* %?\nEntered on %U\n %i\n %a")
;;         ))
;; (setq org-irc-link-to-logs t)
;; 
;; (require 'org-id)
;; (setq org-id-link-to-org-use-id 'create-if-interactive)
;; 
;; 
;; (setq org-log-done 'time)
;; (setq org-agenda-start-on-weekday 0)
;; 
;; (setq org-agenda-files (list "~/org/inbox.org"
;;                                "~/org/email.org"
;;                                "~/org/tasks.org"
;;                                "~/org/wtasks.org"
;;                                "~/org/journal.org"
;;                                "~/org/wjournal.org"
;;                                "~/org/kb.org"
;;                                "~/org/wkb.org"))
;; (setq org-agenda-text-search-extra-files
;;       (list "~/org/someday.org"
;;             "~/org/config.org"))
;; (setq org-refile-targets '((nil :maxlevel . 2)
;;                            (org-agenda-files :maxlevel . 2)
;;                            ("~/org/someday.org" :maxlevel . 2)
;;                            ("~/org/templates.org" :maxlevel . 2)
;;                            ))
;; (setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
;; (setq org-refile-use-outline-path 'file)
(provide 'sh-org)
