;;; latex config -*- lexical-binding: t -*-
;;

;; +mmap-mode-tex-def
(vonfry-def-mmap-mode-prefix tex nil
  :keymaps '(LaTeX-mode-map TeX-mode-map))

;; +mmap-tex-def
(vonfry-def-mmap-leader-prefix tex nil
  :keymaps '(LaTeX-mode-map TeX-mode-map))
