(defun set-font ()
  ;; Setting default font
  (set-face-attribute 'default nil :font "SauceCodePro Nerd Font-12")
  ;; Setting Chinese Font
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
		      charset
		      (font-spec :family "宋体" :size 20)
		      ;;(font-spec :family "宋体")
		      )))
(add-to-list 'after-make-frame-functions
	     (lambda (new-frame)
	       (select-frame new-frame)
	       (if window-system
		   (set-font))))
(if window-system
    (set-font))

(provide 'about-font)