;;; nerd-commenter config -*- lexical-binding: t -*-

(use-package! evil-nerd-commenter
  :init
  (defcustom +nc-nmap-prefix
    (concat vonfry-keybind-evil-leader vonfry-keybind-evil-nerdcommenter)
    "nerd-commenter prefix key"
    :type 'string
    :group 'vonfry-modules)
  :config
  (evilnc-default-hotkeys t)
  :general
  (nmap :prefix +nc-nmap-prefix
    "i" 'evilnc-comment-or-uncomment-lines
    "l" 'evilnc-quick-comment-or-uncomment-to-the-line
    "c" 'evilnc-copy-and-comment-lines
    "p" 'evilnc-comment-or-uncomment-paragraphs
    "r" 'comment-or-uncomment-region
    "v" 'evilnc-toggle-invert-comment-line-by-line
    "." 'evilnc-copy-and-comment-operator
    "/" 'evilnc-comment-operator))
