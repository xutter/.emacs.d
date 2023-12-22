;;Set your lisp system and optionally, some contribs
(setq inferior-lisp-program sbcl-path)
(setq slime-contribs '(slime-fancy))
(put 'upcase-region 'disabled nil)

(provide 'sh-lisp)