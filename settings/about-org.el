(use-package org
  :hook
  ((org-mode-hook outline-minor-mode))
  :mode (("\\.org\\'" . org-mode)))

(use-package org-bullets
  :defer t
  :init
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((emacs-lisp . t)
;;    (scheme . t)
;;    (python . t)))

(provide 'about-org)