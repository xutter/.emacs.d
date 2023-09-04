;; (use-package dracula-theme
;;   :ensure t
;;   :init
;;   (load-theme 'dracula t))


;; (use-package inkpot-theme
;;   :ensure t
;;   :init
;;   (load-theme 'molokai t))


;; (use-package avk-emacs-themes
;;   :ensure t
;;   :init
;;   (load-theme 'avk-daylight t))


;; (use-package solarized-theme
;;   :disabled
;;   :init
;;   (load-theme 'solarized-light t))


(if (> emacs-major-version 27)
  (use-package ef-themes
    :config
    (load-theme 'ef-spring t))
  (use-package solarized-theme
    :config
    (load-theme 'solarized-light t)))


(provide 'about-theme)
