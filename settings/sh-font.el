;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 字体设置
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package unicode-fonts)

(defvar zh-font "Sarasa Mono SC"
  "指定的中文字体")

(defvar en-font "Inconsolata"
  "指定的英文字体")

(defvar emoji-font "Noto Emoji"
  "指定的表情字体")

(defvar symbol-font "Noto Sans Symbols 2"
  "指定的符号字体")

;; 设置默认字体
(set-face-attribute 'default nil
		    :font (font-spec
			   :family en-font
			   :size 14))

;; 设置中文字体
(dolist (charset '(kana han cjk-misc bopomofo))
  (set-fontset-font t
                    charset
                    (font-spec :family zh-font)))

;; 设置表情字体
(set-fontset-font t 'symbol (font-spec :family emoji-font) nil 'append)
;; 设置符号字体
(set-fontset-font t 'symbol (font-spec :family symbol-font) nil 'append)

(provide 'sh-font)
