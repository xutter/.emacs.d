;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Common Programming
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package haskell-mode
  :defer t)

(use-package eglot
  :defer t
  :config
  (add-to-list 'eglot-server-programs '(python-mode "pyright-langserver" "--stdio"))
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd")))

(if (> 29 emacs-major-version)
;;; if: emacs version early than 29, use tree-sitter.
  (progn
    (use-package tree-sitter
      :defer t)
    (use-package tree-sitter-langs
      :after tree-sitter
      :defer t))
;;; else: emacs version more than 29, use built-in package treesit
;;; Configure tree-sitter language parser library
  (use-package treesit-auto))

(global-treesit-auto-mode)

(use-package pyvenv
  :config
  (pyvenv-mode)
  :defer t)

(provide 'sh-prog)
