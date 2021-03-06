;;; evil packages -*- lexical-binding: t -*-
;;

(use-package evil
  :config
  (evil-mode 1)
  (fset 'evil-visual-update-x-selection 'ignore)
  (advice-add 'vonfry/local-indent
              :after (lambda (int) (setq-local evil-shift-width int)))
  :custom
  (evil-want-keybinding nil)
  (evil-want-integration t)
  (evil-shift-width 4)
  (evil-search-module 'isearch)
  :general
  (nmap :prefix "g"
        "B" 'previous-buffer
        "b" 'next-buffer)
  (nmap-leader
    "M"   '(:ignore t :which-key "bookmarks")
    "M a" 'bookmark-set
    "M A" 'bookmark-set-no-overwrite
    "M l" 'bookmark-bmenu-list
    "M s" 'bookmark-save
    "M d" 'bookmark-delete
    "M r" 'bookmark-rename
    "M w" 'bookmark-write
    "F B" 'hexl-find-file
    "F b" 'hexl-mode
    "!"   'calc
    "\""  'comint-run
    "l"   'list-processes
    "L"   'proced
    "O"   'calendar
    "_"   '+evil/switch-scratch
    "e"   '(:ignore t :which-key "emacs")
    "e s" 'server-start
    "e c" 'clean-buffer-list
    "e #" 'server-edit
    "e D" 'diff)
  (vmap-leader
    "="   'align-regexp))

(use-package evil-numbers
  :after evil
  :general
  ("C-c +" 'evil-numbers/inc-at-pt)
  ("C-c -" 'evil-numbers/dec-at-pt))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode 1))

(use-package evil-collection
  :after evil
  :custom
  (evil-collection-key-blacklist '("SPC" "S-SPC"))
  :config
  (evil-collection-init))
