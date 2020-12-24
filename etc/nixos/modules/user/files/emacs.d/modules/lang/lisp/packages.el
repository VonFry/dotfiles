;;; lisp packages -*- lexical-binding: t -*-
;;

(use-package eldoc
  :ensure nil
  :hook
  ((emacs-lisp-mode lisp-interaction-mode ielm-mode) . turn-on-eldoc-mode))

(use-package ielm :ensure nil
  :general
  (nmap-leader :keymps 'emacs-lisp-map
    "\""  'ielm
    "' b" 'eval-buffer)
  (vmap-leader :keymps 'emacs-lisp-map
    "' r" 'eval-region))

(add-hook 'elisp-mode-hook
          (lambda ()
            (vonfry/local-indent 2)
            (+company-set-backends-grouped 'company-elisp)))
