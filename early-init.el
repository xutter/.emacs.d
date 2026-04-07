(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 0.6)

(add-hook 'after-init-hook
					(lambda ()
						(setq gc-cons-threshold (* 64 1024 1024))
						(setq gc-cons-percentage 0.1)))
