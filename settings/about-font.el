;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 字体设置
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar zh-font "WenQuanYi Zen Hei Mono"
  "指定的中文字体")

(defvar en-font "Inconsolata Nerd Font"
  "指定的英文字体")

(defvar emoji-font "Segoe UI Emoji"
  "指定的表情字体")

(defvar symbol-font "Segoe UI Symbol"
  "指定的符号字体")

(if (display-graphic-p)
    (cond ((eq system-type 'windows-nt)
            (setq zh-font "Sarasa Gothic CL"))
           ((eq system-type 'gnu/linux)
           (setq zh-font "WenQuanYi Zen Hei Mono")))
    (cond ((eq system-type 'windows-nt)
            (setq zh-font "Sarasa Gothic CL")) ;; default FangSong
           ((eq system-type 'gnu/linux)
           (setq zh-font "WenQuanYi Zen Hei Mono"))))

;; 设置默认字体
(set-face-attribute 'default nil
		    :family en-font
		    :height 120
		    :weight 'normal
		    :width 'normal)

;; 设置中文字体
(dolist (charset '(kana han cjk-misc bopomofo))
  (set-fontset-font t
                    charset
                    (font-spec :family zh-font)))
;; 设置英文字体
(set-fontset-font t 'latin (font-spec :family en-font))
;; 设置符号字体
(set-fontset-font t 'symbol (font-spec :family symbol-font))
(when (> emacs-major-version 27)
  ;; 设置emoji字体
  (set-fontset-font t 'emoji (font-spec :family emoji-font)))

;; rsetq face-font-rescale-alist 
;;       `((,zh-font . 1.2)
;;         (,en-font . 1.0)))
;; 
(provide 'about-font)
