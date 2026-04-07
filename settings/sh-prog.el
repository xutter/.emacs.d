;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Common Programming
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package haskell-mode
  :defer t)

(use-package eglot
  :defer t
  :config
  (add-to-list 'eglot-server-programs '(python-mode "pyright-langserver" "--stdio"))
  (add-to-list 'eglot-server-programs `((c++-mode c-mode) ,clangd-path)))

(if (< emacs-major-version 29)
    (progn
      (use-package tree-sitter
        :defer t
        :hook ((c-mode . tree-sitter-mode)
               (c++-mode . tree-sitter-mode)
               (python-mode . tree-sitter-mode)
               (haskell-mode . tree-sitter-mode)))
      (use-package tree-sitter-langs
        :after tree-sitter
        :defer t))
  (use-package treesit-auto
    :if (fboundp 'treesit-available-p)
    :config
    (global-treesit-auto-mode)))

(use-package pyvenv
  :config
  (pyvenv-mode)
  :defer t)

(provide 'sh-prog)
