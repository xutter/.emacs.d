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


(use-package ef-themes
  :if (>= emacs-major-version 27)
  :config
  (load-theme 'ef-spring t))
(use-package solarized-theme
  :if (< emacs-major-version 27)
  :config
  (load-theme 'solarized-light t))

(use-package powerline-evil
  :ensure t
  :init
  (powerline-evil-center-color-theme))

(provide 'sh-theme)
