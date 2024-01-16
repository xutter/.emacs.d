;;;;;;;;;;;;;;;;
;; configure
;;;;;;;;;;;;;;;;

(defun in-windows ()
  (setq scheme-path "C:\\Program Files\\Chez Scheme 9.6.4\\bin\\ta6nt")
  (setq clangd-path "C:\\bin\\LLVM\\bin\\clangd.exe")
  (setq sbcl-path "C:\\bin\\sbcl\\sbcl.exe")
  (setq python-path "C:\\bin\\Python\\python39\\python.exe")
  (setq pandoc-path "C:\\bin\\Pandoc\\pandoc.exe")
  (setq plantuml-path "C:\\bin\\plantuml\\plantuml.jar"))

(defun in-cygwin ()
  (setq scheme-path "/usr/bin")
  (setq clangd-path "/mingw64/bin/clangd.exe")
  (setq sbcl-path "C:\\bin\\sbcl\\sbcl.exe")
  (setq python-path "/mingw64/bin/python.exe")
  (setq pandoc-path "C:\\bin\\Pandoc\\pandoc.exe")
  (setq plantuml-path "C:\\bin\\plantuml\\plantuml.jar"))


(defun in-linux ()
  (setq scheme-path "/usr/bin/scheme")
  (setq clangd-path "/usr/bin/clangd")
  (setq sbcl-path "/usr/bin/sbcl")
  (setq python-path "/usr/bin/python3")
  (setq pandoc-path "/usr/bin/pandoc")
  (setq plantuml-path "/usr/share/plantuml/plantuml.jar"))



(cond ((eq system-type 'windows-nt) (in-windows))
      ((eq system-type 'gnu/linux)  (in-linux))
      ((eq system-type 'cygwin)     (in-cygwin)))

(provide 'configure)
