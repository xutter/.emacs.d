(require 'calendar)
(require 'holidays)
(require 'diary-lib)
(require 'appt)
(require 'cal-china)
(require 'solar)

(defvar sh-china-public-holidays
  '((holiday-fixed 1 1 "元旦")
    (holiday-fixed 5 1 "劳动节")
    (holiday-fixed 10 1 "国庆节"))
  "Additional public holidays to show in Calendar.")

(defconst sh-china-solar-terms
  '["小寒" "大寒" "立春" "雨水" "惊蛰" "春分"
    "清明" "谷雨" "立夏" "小满" "芒种" "夏至"
    "小暑" "大暑" "立秋" "处暑" "白露" "秋分"
    "寒露" "霜降" "立冬" "小雪" "大雪" "冬至"]
  "The 24 solar terms in chronological order within a Gregorian year.")

(defconst sh-calendar-diary-directory
  (expand-file-name "diary/" user-emacs-directory)
  "Directory containing user-managed diary files.")

(defconst sh-calendar-generated-diary-file
  (expand-file-name ".diary-include" sh-calendar-diary-directory)
  "Generated diary file that aggregates all managed diary files.")

(setq diary-file sh-calendar-generated-diary-file)

(add-to-list
 'auto-mode-alist
 `(,(concat "\\`"
            (regexp-quote (file-name-as-directory sh-calendar-diary-directory))
            ".*\\'")
   . diary-mode))

(setq calendar-chinese-all-holidays-flag t
      calendar-mark-holidays-flag t
  calendar-mark-diary-entries-flag t
  calendar-view-diary-initially-flag nil
      number-of-diary-entries 7
      appt-display-mode-line t
      appt-audible nil
      appt-display-interval 10
      appt-message-warning-time 30)

(defun sh-calendar-julian-to-gregorian (julian-day)
  "Convert JULIAN-DAY to a Gregorian date."
  (calendar-gregorian-from-absolute
   (floor (- julian-day 1721424.5))))

(defun sh-calendar-solar-term-date (year index)
  "Return Gregorian date of solar term INDEX in YEAR."
  (let ((astro-day (calendar-astro-from-absolute
                    (calendar-absolute-from-gregorian (list 1 1 year))))
        julian-day)
    (dotimes (_ (1+ index))
      (setq julian-day (solar-date-next-longitude astro-day 15))
      (setq astro-day (+ julian-day 0.1)))
    (sh-calendar-julian-to-gregorian julian-day)))

(defun sh-calendar-hanshi-date (year)
  "Return Gregorian date of Hanshi Festival in YEAR."
  (calendar-gregorian-from-absolute
   (1- (calendar-absolute-from-gregorian
  (sh-calendar-solar-term-date year 6)))))

(defun sh-calendar-chuxi-date (year)
  "Return Gregorian date of Chinese New Year's Eve in YEAR."
  (pcase-let* ((`(,cycle ,chinese-year _month _day)
                (calendar-chinese-from-absolute
                 (calendar-absolute-from-gregorian (list 7 1 year))))
               (new-year-abs
                (calendar-chinese-to-absolute (list cycle chinese-year 1 1))))
    (calendar-gregorian-from-absolute (1- new-year-abs))))

(defconst sh-china-solar-term-holidays
  (let (holidays)
    (dotimes (index (length sh-china-solar-terms) (nreverse holidays))
      (push `(holiday-sexp
              '(sh-calendar-solar-term-date year ,index)
              ,(aref sh-china-solar-terms index))
            holidays)))
  "Holiday forms for the 24 solar terms.")

(defconst sh-china-traditional-holidays
  (append
   '((holiday-chinese 1 1 "春节")
     (holiday-chinese 1 15 "元宵节")
     (holiday-chinese 2 2 "龙抬头")
     (holiday-chinese 3 3 "上巳节")
     (holiday-chinese 5 5 "端午节")
     (holiday-chinese 7 7 "七夕节")
     (holiday-chinese 7 15 "中元节")
     (holiday-chinese 8 15 "中秋节")
     (holiday-chinese 9 9 "重阳节")
     (holiday-chinese 10 1 "寒衣节")
     (holiday-chinese 10 15 "下元节")
     (holiday-chinese 12 8 "腊八节")
     (holiday-chinese 12 23 "北方小年")
     (holiday-chinese 12 24 "南方小年"))
   '((holiday-sexp '(sh-calendar-hanshi-date year) "寒食节")
     (holiday-sexp '(sh-calendar-chuxi-date year) "除夕")))
  "Holiday forms for common Han traditional festivals.")

(setq calendar-holidays
      (append holiday-general-holidays
              sh-china-public-holidays
              sh-china-traditional-holidays
              sh-china-solar-term-holidays))

(defun sh-calendar-format-date (date)
  "Format DATE in ISO style."
  (format "%04d-%02d-%02d"
          (calendar-extract-year date)
          (calendar-extract-month date)
          (calendar-extract-day date)))

(defun sh-calendar-diary-texts (date)
  "Return diary entry texts for DATE."
  (mapcar #'cadr (diary-list-entries date 1 t)))

(defun sh-calendar-update-header ()
  "Show Gregorian date, lunar date, holidays, and diary in Calendar header line."
  (when (derived-mode-p 'calendar-mode)
    (let* ((date (calendar-cursor-to-date t))
           (lunar (calendar-chinese-date-string date))
           (holidays (calendar-check-holidays date))
           (diary-texts (sh-calendar-diary-texts date))
           (holiday-text (when holidays
                           (concat "  节日: " (mapconcat #'identity holidays "、"))))
           (diary-text (when diary-texts
                         (concat "  日程: " (mapconcat #'identity diary-texts "、")))))
      (setq-local header-line-format
                  (concat " 公历: " (sh-calendar-format-date date)
                          "  农历: " lunar
                          (or holiday-text "")
                          (or diary-text ""))))))

(defun sh-calendar-holiday-message (label date)
  "Return a holiday reminder string for LABEL and DATE."
  (let ((holidays (calendar-check-holidays date)))
    (when holidays
      (format "%s节假日: %s" label (mapconcat #'identity holidays "、")))))

(defun sh-calendar-notify-holidays ()
  "Notify holidays for today and tomorrow."
  (interactive)
  (let* ((today (calendar-current-date))
         (tomorrow (calendar-gregorian-from-absolute
                    (1+ (calendar-absolute-from-gregorian today))))
         (messages (delq nil
                         (list (sh-calendar-holiday-message "今天" today)
                               (sh-calendar-holiday-message "明天" tomorrow)))))
    (when messages
      (message "%s" (mapconcat #'identity messages "；")))))

(defun sh-calendar-diary-files ()
  "Return readable diary files managed under `sh-calendar-diary-directory'."
  (let (diary-files)
    (when (file-directory-p sh-calendar-diary-directory)
      (dolist (file (sort (directory-files-recursively
                           sh-calendar-diary-directory ".*" nil t)
                          #'string<))
        (let ((name (file-name-nondirectory file)))
          (when (and (file-regular-p file)
                     (file-readable-p file)
                     (not (equal (expand-file-name file)
                                 sh-calendar-generated-diary-file))
                     (not (string-prefix-p "." name))
                     (not (string-prefix-p ".#" name))
                     (not (string-suffix-p "~" name)))
            (push file diary-files)))))
    (nreverse diary-files)))

(defun sh-calendar-sync-diary-file ()
  "Regenerate `diary-file' from all files in `sh-calendar-diary-directory'."
  (make-directory sh-calendar-diary-directory t)
  (let ((diary-files (sh-calendar-diary-files)))
    (with-temp-file diary-file
      (insert ";; Auto-generated by sh-calendar.el.\n")
      (insert ";; Add your own diary files under: "
              sh-calendar-diary-directory
              "\n")
      (dolist (file diary-files)
        (insert "\n; --- " file " ---\n")
        (let ((content (with-temp-buffer
                         (insert-file-contents file)
                         (buffer-string))))
          (insert content))
        (unless (bolp)
          (insert "\n"))))
    diary-files))

(defun sh-calendar-refresh-appts ()
  "Refresh appointment reminders from all managed diary files."
  (interactive)
  (let ((diary-files (sh-calendar-sync-diary-file)))
    (setq appt-time-msg-list nil)
    (when diary-files
      (let* ((original-date (calendar-current-date))
             (number 1)
             (diary-entries-list (diary-list-entries original-date number t)))
        (appt-make-list)))
    (when (called-interactively-p 'interactive)
      (message "Loaded %d diary file(s) from %s"
               (length diary-files)
               sh-calendar-diary-directory))
    diary-files))

(defun sh-calendar-setup-diary-reminders ()
  "Enable diary and appointment reminders."
  (appt-activate 1)
  (unless (sh-calendar-refresh-appts)
    (message "Appointment reminders enabled (no diary files found in %s)"
             sh-calendar-diary-directory)))

(add-hook 'diary-nongregorian-listing-hook #'diary-chinese-list-entries)
(add-hook 'diary-nongregorian-marking-hook #'diary-chinese-mark-entries)

(add-hook 'calendar-move-hook #'sh-calendar-update-header)
(add-hook 'calendar-initial-window-hook #'sh-calendar-update-header)
(add-hook 'emacs-startup-hook #'sh-calendar-setup-diary-reminders)
(add-hook 'emacs-startup-hook #'sh-calendar-notify-holidays)
(run-at-time "00:05" 86400 #'sh-calendar-notify-holidays)

(add-hook 'diary-mode-hook
          (lambda ()
            (add-hook 'after-save-hook #'sh-calendar-refresh-appts nil t)))

(provide 'sh-calendar)