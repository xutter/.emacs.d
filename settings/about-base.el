(setq treemacs-no-load-time-warnings t)

;; load configure file, almost executable's path
(require 'configure)
;; hightlight current line
(global-hl-line-mode 1)
;; disable toolbar
(tool-bar-mode -1)
;; disable menubar
(menu-bar-mode -1)
;; disable scrollbar
(if window-system
    (scroll-bar-mode -1))
;; show parenthesis matching
(show-paren-mode 1)
;; disable alert
(setq visible-bell 0)
;; show line num
(global-linum-mode)
;; show cursor position within line
(column-number-mode 1)
;; make lines wrap at word boundaries
;; (global-visual-line-mode 1)
;; nowrap the line
(toggle-truncate-lines 1)

;; replace yes and no to y and name
(fset 'yes-or-no-p 'y-or-n-p)

(setq default-tab-width 4)
(setq tab-width 4)
(setq c-default-style "Linux")
(setq c-basic-offset 4)
(setq indent-tab-mode nil)
(setq inhibit-splash-screen t)
(setq debug-on-error 1)

(provide 'about-base)
