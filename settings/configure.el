;;;;;;;;;;;;;;;;
;; configure
;;;;;;;;;;;;;;;;

(defun in-windows ()
  (setq scheme-path "C:\\Program Files\\Chez Scheme 9.5.8\\bin\\ta6nt")
  (setq clangd-path "C:\\LLVM\\bin\\clangd.exe")
  (setq sbcl-path "C:\\opt\\sbcl\\sbcl.exe")
  (setq python-path "C:\\Python\\python39\\python.exe")
  (setq pandoc-path "C:\\Pandoc\\pandoc.exe")
  (setq plantuml-path "C:\\opt\\plantuml\\plantuml-1.2022.13.jar"))


(defun in-linux ()
  (setq scheme-path "/usr/bin/scheme")
  (setq clangd-path "/usr/bin/clangd")
  (setq sbcl-path "/usr/bin/sbcl")
  (setq python-path "/usr/bin/python3")
  (setq pandoc-path "/usr/bin/pandoc")
  (setq plantuml-path "/usr/share/plantuml/plantuml.jar"))

(if (string-match "Linux" (car (split-string (shell-command-to-string "uname -a")))) (in-linux)
  (in-windows))

(provide 'configure)
