(defun org-language-load ()
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (scheme . t)
     (python . t))))

(use-package org
  :mode ("\\.org\\'" . org-mode)
  :hook (org-mode . outline-minor-mode)
  :config
  (org-language-load))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(setq browse-url-browser-function
      (cond
       ((eq system-type 'windows-nt) #'browse-url-default-windows-browser)
       ((fboundp 'browse-url-xdg-open) #'browse-url-xdg-open)
       (t #'browse-url-default-browser)))
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
