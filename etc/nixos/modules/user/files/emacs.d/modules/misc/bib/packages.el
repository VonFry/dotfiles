;;; bib packages -*- lexical-binding: t -*-
;;

(use-package ebib
  :custom
  (ebib-filters-default-file (expand-file-name "ebib/filters" vonfry-cache-dir))
  (ebib-file-associations '(("pdf" . "zathura")))
  (ebib-bibtex-dialect 'biblatex)
  :config
  (advice-add #'ebib :before #'+bib/switch-dir-current)
  :hook
  ((evil-mode . (lambda ()
    (evil-set-initial-state 'ebib-index-mode  'emacs)
    (evil-set-initial-state 'ebib-entry-mode  'emacs)
    (evil-set-initial-state 'ebib-log-mode    'emacs)
    (evil-set-initial-state 'ebib-string-mode 'emacs)))
   ((bibtex-mode LaTeX-mode) . +bib/switch-dir-current))
  :general
  (:keymaps '(LaTeX-mode-map org-mode-map)
    "C-&" 'ebib-insert-citation)
  (nmap-mode :keymaps 'bibtex-mode-map
    "e" 'ebib
    "d" '+bib/switch-dir-current)
  (nmap-mode :keymaps '(org-mode-map TeX-mode-map)
    "["   '(:ignore t :which-key "bib")
    "[ [" 'ebib
    "[ {" '+bib/switch-dir-current
    "[ }" '+bib/switch-dir
    "[ (" '+bib/switch-dir-from-search-dir
    "[ &" 'ebib-insert-citation
    "[ -" '+bib/switch-insert-single-or-multiple))

(use-package org-ebib :after org)
