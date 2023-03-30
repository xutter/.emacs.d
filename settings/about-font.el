;; (defun set-font ()
;;   ;; Setting default font
;;   (set-face-attribute 'default nil :font (font-spec :family "SauceCodePro Nerd Font" :size 14))
;;   ;; Setting Chinese Font
;;   ;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;   ;;   (set-fontset-font (frame-parameter nil 'font)
;;   ;;             charset
;;   ;;             (font-spec :family "WenQuanYi Zen Hei Mono")));; :size 20)))) 文泉驿字体
;;   (set-fontset-font t 'unicode (font-spec :family "Noto Color Emoji"))
;;   (set-fontset-font t 'han (font-spec :family "Wenquanyi Zen Hei" :size 17))
;;   (setq face-font-rescale-alist '(("WenQuanYi Zen Hei" . 3.0)))
;;   )
;; (add-to-list 'after-make-frame-functions
;; 	     (lambda (new-frame)
;; 	       (select-frame new-frame)
;; 	       (if window-system
;; 		   (set-font))))
;; (if window-system
;;     (set-font))

;;  ;;;;;;;;|
;;  中文字体|

;; 设置默认字体
(set-face-attribute 'default nil
		    :family "Source Code Pro"
		    :height 120
		    :weight 'normal
		    :width 'normal
		    )
;; 设置中文字体为文泉驿
(set-fontset-font t 'han "WenQuanYi Zen Hei Mono:16")

(setq face-font-rescale-alist '(("WenQuanYi Zen Hei Mono" . 2.0)
				("Source Code Pro" . 1.0)))

(provide 'about-font)
