;;; ivy packages -*- lexical-binding: t -*-
;;

(package! ivy
  :config
  (ivy-mode 1)
  :custom
  (ivy-use-virtual-buffers t)
  :general
  (+nmap-leader-def
    "b" 'ivy-switch-buffer))

(package! swiper
  :custom
  (swiper-action-recenter t)
  :general
  (+nmap-leader-def
    "/" 'swiper))

(package! counsel
  :custom
  (counsel-find-file-at-point t)
  :config
  (counsel-mode t)
  :general
  ("M-x" 'counsel-M-x)
  ("C-x r b" 'counsel-bookmark)
  ("C-x C-f" 'counsel-find-file)
  (:keymaps 'prog-mode-map
    "C-&" 'counsel-company)
  (+nmap-leader-def
    "x" 'counsel-M-x
    "f" 'counsel-find-file
    "F" 'counsel-fzf
    "m" 'counsel-mark-ring))

(package! ivy-rich
  :after ivy
  :config
  (ivy-rich-mode t))

(package! counsel-tramp
  :after counsel)

(package! ivy-prescient
  :after ivy prescient
  :custom
  (prescient-save-file (expand-file-name "prescient" vonfry-cache-dir))
  (ivy-prescient-retain-classic-highlighting t)
  :config
  (ivy-prescient-mode t))
