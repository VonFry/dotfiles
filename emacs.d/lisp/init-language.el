(add-to-list 'load-path (expand-file-name "+language" *init-dir*))

;;; IMPORTANT (add-hook '???-mode-hook 'ycmd-mode)
(require 'init-cfamily)
(require 'init-lisp)
(require 'init-elisp)
(require 'init-haskell)
(require 'init-python)
(require 'init-ruby)
(require 'init-go)
(require 'init-web)
(require 'init-javascript)
(require 'init-typescript)
(require 'init-shell)
(require 'init-latex)
(require 'init-sql)
(require 'init-arduino)
(require 'init-yaml)
(require 'init-markdown)
(require 'init-dot)

(provide 'init-language)
