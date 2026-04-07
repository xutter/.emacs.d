;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 字体设置
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun sh-first-available-font (&rest families)
  "Return the first installed font family from FAMILIES."
  (catch 'font
    (dolist (family families)
      (when (find-font (font-spec :family family))
        (throw 'font family)))))

(use-package unicode-fonts
  :if (display-graphic-p))

(defvar zh-font
  (or (sh-first-available-font "Sarasa Mono SC" "Microsoft YaHei UI" "Microsoft YaHei" "WenQuanYi Micro Hei")
      "Sans Serif")
  "指定的中文字体")

(defvar en-font
  (or (sh-first-available-font "Inconsolata" "Consolas" "DejaVu Sans Mono" "Monospace")
      "Monospace")
  "指定的英文字体")

(defvar emoji-font
  (or (sh-first-available-font "Noto Color Emoji" "Noto Emoji" "Segoe UI Emoji")
      nil)
  "指定的表情字体")

(defvar symbol-font
  (or (sh-first-available-font "Noto Sans Symbols 2" "Segoe UI Symbol")
      nil)
  "指定的符号字体")

(defconst sh-base-font-size 14
  "Default font size at 100% display scaling.")

(defun sh-clamp-scale (scale)
  "Clamp SCALE to a sensible UI range."
  (max 1.0 (min 3.0 scale)))

(defun sh-parse-scale-value (value)
  "Parse VALUE as a positive floating-point scale factor."
  (when (and (stringp value) (not (string= value "")))
    (let ((scale (string-to-number value)))
      (when (> scale 0)
        scale))))

(defun sh-monitor-dpi-scale (&optional frame)
  "Estimate display scale from monitor DPI for FRAME."
  (let* ((attrs (frame-monitor-attributes (or frame (selected-frame))))
         (geometry (cdr (assq 'geometry attrs)))
         (mm-size (cdr (assq 'mm-size attrs)))
         (pixel-width (and (listp geometry) (nth 2 geometry)))
         (mm-width (cond
                    ((consp mm-size) (car mm-size))
                    ((listp mm-size) (car mm-size)))))
    (when (and pixel-width mm-width (> pixel-width 0) (> mm-width 0))
      (sh-clamp-scale (/ (/ pixel-width (/ mm-width 25.4)) 96.0)))))

(defun sh-nearest-scale-step (scale steps)
  "Return the closest value to SCALE from STEPS."
  (car (sort (copy-sequence steps)
             (lambda (left right)
               (< (abs (- scale left))
                  (abs (- scale right)))))))

(defun sh-windows-display-scale (&optional frame)
  "Return a Windows-oriented scale factor for FRAME."
  (let ((native-scale (and (fboundp 'frame-scale-factor)
                           (display-graphic-p (or frame (selected-frame)))
                           (float (frame-scale-factor (or frame (selected-frame))))))
        (dpi-scale (sh-monitor-dpi-scale frame)))
    (cond
     ((and native-scale (> native-scale 1.0))
      (sh-clamp-scale native-scale))
     (dpi-scale
      (sh-nearest-scale-step dpi-scale '(1.0 1.25 1.5 1.75 2.0 2.25 2.5 3.0)))
     (t 1.0))))

(defun sh-linux-display-scale (&optional frame)
  "Return a Linux-oriented scale factor for FRAME."
  (let ((native-scale (and (fboundp 'frame-scale-factor)
                           (display-graphic-p (or frame (selected-frame)))
                           (float (frame-scale-factor (or frame (selected-frame))))))
        (env-scale (or (sh-parse-scale-value (getenv "GDK_SCALE"))
                       (sh-parse-scale-value (getenv "QT_SCALE_FACTOR"))
                       (sh-parse-scale-value (getenv "ELM_SCALE"))))
        (dpi-scale (sh-monitor-dpi-scale frame)))
    (cond
     ((and native-scale (> native-scale 1.0))
      (sh-clamp-scale native-scale))
     (env-scale
      (sh-clamp-scale env-scale))
     (dpi-scale
      (/ (round (* dpi-scale 4.0)) 4.0))
     (t 1.0))))

(defun sh-display-scale-factor (&optional frame)
  "Return a best-effort display scale factor for FRAME."
  (let ((frame (or frame (selected-frame))))
    (cond
     ((not (display-graphic-p frame))
      1.0)
     ((eq system-type 'windows-nt)
      (sh-windows-display-scale frame))
     ((eq system-type 'gnu/linux)
      (sh-linux-display-scale frame))
     (t 1.0))))

(defun sh-apply-font-settings (&optional frame)
  "Apply font settings for FRAME using display scaling."
  (let ((frame (or frame (selected-frame))))
    (when (display-graphic-p frame)
      (with-selected-frame frame
        (set-face-attribute 'default frame
			    :font (font-spec
				   :family en-font
				   :size (round (* sh-base-font-size
						    (sh-display-scale-factor frame)))))

        ;; 设置中文字体
        (dolist (charset '(kana han cjk-misc bopomofo))
          (set-fontset-font t
                            charset
                            (font-spec :family zh-font)))

        ;; 设置表情字体
        (when emoji-font
          (set-fontset-font t 'symbol (font-spec :family emoji-font) nil 'append))
        ;; 设置符号字体
        (when symbol-font
          (set-fontset-font t 'symbol (font-spec :family symbol-font) nil 'append))))))

;; 启动时和新建图形 frame 时按显示缩放应用字体
(add-hook 'emacs-startup-hook #'sh-apply-font-settings)
(add-hook 'after-make-frame-functions #'sh-apply-font-settings)
(provide 'sh-font)
