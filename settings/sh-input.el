(defconst sh-rime-share-data-dir
  (catch 'dir
    (dolist (dir (delq nil
                       (list
                        (expand-file-name "rime-data" user-emacs-directory)
                        (expand-file-name "rime" user-emacs-directory)
                        (and (getenv "APPDATA")
                             (expand-file-name "Rime" (getenv "APPDATA")))
                        (expand-file-name ".local/share/fcitx5/rime" "~")
                        "/usr/share/rime-data")))
      (when (file-directory-p dir)
        (throw 'dir dir))))
  "Detected Rime shared data directory.")

(defconst sh-enable-rime
  (and sh-rime-share-data-dir
       (not (eq system-type 'cygwin)))
  "Enable Rime only when required data files are available.")

(use-package rime
  :if sh-enable-rime
  :custom
  (default-input-method "rime")
  :init
  (setq rime-share-data-dir sh-rime-share-data-dir)
  :config
  (defun sh-configure-rime-ui (&optional frame)
    "Configure Rime candidate UI for the selected FRAME type."
    (if (and (display-graphic-p frame)
             (require 'posframe nil t))
        (progn
          (setq rime-show-candidate 'posframe)
          (set-face-attribute 'rime-default-face nil
                              :background "yellow"
                              :foreground "black"
                              :family "Microsoft YaHei"
                              :height 160))
      (setq rime-show-candidate 'minibuffer)
      (set-face-attribute 'rime-preedit-face nil
                          :background "yellow"
                          :foreground "black"
                          :family "SimHei"
                          :height 160)))
  (add-hook 'emacs-startup-hook #'sh-configure-rime-ui)
  (add-hook 'after-make-frame-functions #'sh-configure-rime-ui))

(defconst sh-use-ivy-stack
  (or (< emacs-major-version 28)
      (not (fboundp 'fido-vertical-mode)))
  "Use Ivy/Counsel/Swiper on Emacs versions without a built-in vertical UI.")

(use-package savehist
  :init
  (savehist-mode 1))

(setq enable-recursive-minibuffers t)
(setq completion-ignore-case t
      read-buffer-completion-ignore-case t
      read-file-name-completion-ignore-case t)

(defun sh-search-project-or-dir ()
  "Search in the current project when available, otherwise fall back to grep." 
  (interactive)
  (call-interactively
   (cond
    ((fboundp 'project-find-regexp) #'project-find-regexp)
    ((fboundp 'rgrep) #'rgrep)
    (t #'grep))))

(if sh-use-ivy-stack
    (progn
      (use-package ivy
        :demand t
        :diminish
        :config
        (setq ivy-use-virtual-buffers t
              ivy-count-format "(%d/%d) ")
        (ivy-mode 1))

      (use-package counsel
        :after ivy
        :bind
        (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-c s" . counsel-etags-grep)
         ("C-c C-r" . ivy-resume))
        :config
        (define-key minibuffer-local-map (kbd "C-r") #'counsel-minibuffer-history))

      (use-package swiper
        :after ivy
        :bind (("C-s" . swiper))))
  (progn
    (if (fboundp 'fido-vertical-mode)
        (fido-vertical-mode 1)
      (fido-mode 1))
    (setq completion-styles '(basic partial-completion flex)
          completions-format 'one-column
          icomplete-show-matches-on-no-input t
          icomplete-separator " | ")
    (global-set-key (kbd "C-s") #'isearch-forward)
    (global-set-key (kbd "C-c s") #'sh-search-project-or-dir)
    (global-set-key (kbd "C-c C-r") #'repeat-complex-command)
    (define-key minibuffer-local-map (kbd "C-r") #'previous-history-element)))

(global-set-key (kbd "C-;")   'comment-line)


(provide 'sh-input)
