;;; spaceline packages -*- lexical-binding: t -*-
;;

(use-package doom-modeline
  :hook ((after-init . doom-modeline-mode)
         (doom-modeline-mode . column-number-mode)
         (server-after-make-frame .
           (lambda () (setq doom-modeline-icon (display-graphic-p)))))
  :custom
  (doom-modeline-lsp t)
  (doom-modeline-mu4e t)
  (doom-modeline-buffer-file-name-style 'file-name)
  (doom-modeline-irc t))
