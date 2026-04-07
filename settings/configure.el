;;;;;;;;;;;;;;;;
;; configure
;;;;;;;;;;;;;;;;

(require 'seq)

(defun sh-first-existing-path (&rest candidates)
  "Return the first existing file or executable from CANDIDATES."
  (seq-find (lambda (candidate)
      (and candidate
       (or (file-exists-p candidate)
           (executable-find candidate))))
    candidates))

(defun sh-executable-or-default (default &rest commands)
  "Return the first available executable from COMMANDS, otherwise DEFAULT."
  (or (seq-find #'executable-find commands)
  default))

(defun in-windows ()
  (setq TeX-tree-roots "/mingw64/bin/")
  (setq scheme-path
    (or (sh-first-existing-path
     "C:\\Program Files\\Chez Scheme 9.6.4\\bin\\scheme.exe"
     "C:\\Program Files\\Chez Scheme 10.0.0\\bin\\scheme.exe")
    (sh-executable-or-default "scheme" "scheme" "chez")))
  (setq clangd-path
    (sh-executable-or-default "clangd" "clangd.exe" "clangd"))
  (setq sbcl-path
    (or (sh-first-existing-path "C:\\bin\\sbcl\\sbcl.exe")
    (sh-executable-or-default "sbcl" "sbcl.exe" "sbcl")))
  (setq python-path
    (sh-executable-or-default "python" "python3.exe" "python.exe" "python3" "python"))
  (setq pandoc-path
    (sh-executable-or-default "pandoc" "pandoc.exe" "pandoc"))
  (setq plantuml-path
    (or (sh-first-existing-path
     "C:\\bin\\plantuml\\plantuml.jar"
     "C:\\ProgramData\\chocolatey\\lib\\plantuml\\tools\\plantuml.jar")
    "plantuml.jar")))

(defun in-cygwin ()
  (setq scheme-path (sh-executable-or-default "/usr/bin/scheme" "scheme"))
  (setq clangd-path (sh-executable-or-default "/mingw64/bin/clangd.exe" "clangd.exe" "clangd"))
  (setq sbcl-path (sh-executable-or-default "sbcl" "sbcl.exe" "sbcl"))
  (setq python-path (sh-executable-or-default "/mingw64/bin/python.exe" "python3" "python"))
  (setq pandoc-path (sh-executable-or-default "pandoc" "pandoc.exe" "pandoc"))
  (setq plantuml-path
    (or (sh-first-existing-path "C:\\bin\\plantuml\\plantuml.jar")
    "plantuml.jar")))


(defun in-linux ()
  (setq scheme-path (sh-executable-or-default "/usr/bin/scheme" "scheme"))
  (setq clangd-path (sh-executable-or-default "/usr/bin/clangd" "clangd"))
  (setq sbcl-path (sh-executable-or-default "/usr/bin/sbcl" "sbcl"))
  (setq python-path (sh-executable-or-default "/usr/bin/python3" "python3" "python"))
  (setq pandoc-path (sh-executable-or-default "/usr/bin/pandoc" "pandoc"))
  (setq plantuml-path
    (or (sh-first-existing-path
     "/usr/share/plantuml/plantuml.jar"
     "/usr/share/java/plantuml.jar")
    "plantuml.jar")))



(cond ((eq system-type 'windows-nt) (in-windows))
      ((eq system-type 'gnu/linux)  (in-linux))
      ((eq system-type 'cygwin)     (in-cygwin)))

(provide 'configure)
