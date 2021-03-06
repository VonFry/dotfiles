;;; lisp packages -*- lexical-binding: t -*-
;;

(use-package eldoc
  :ensure nil
  :hook
  ((emacs-lisp-mode lisp-interaction-mode ielm-mode) . turn-on-eldoc-mode))

(use-package ielm :ensure nil
  :general
  (nmap-leader :keymaps '(emacs-lisp-mode-map lisp-interaction-mode-map)
    "\""    'ielm
    "RET"   'eval-last-sexp
    "' b"   'eval-buffer
    "' f"   'eval-defun)
  (nmap-leader :infix "e"
    "a"   'eval-expression)
  (vmap-leader :keymaps 'emacs-lisp-mode-map
    "' r" 'eval-region))

(add-hook 'elisp-mode-hook
          (lambda ()
            (vonfry/local-indent 2)
            (+company-set-backends-grouped 'company-elisp)))
