;;; proof config -*- lexical-binding: t -*-
;;

;; +mmap-lang-proof-def
(vonfry-def-mmap-lang-prefix proof nil
  :keymaps 'coq-mode-map)

;; +mmap-proof-def
(vonfry-def-mmap-leader-prefix proof nil
  :keymaps 'coq-mode-map)

(defface +proof-buffer-local-face
    '((t :family "Symbola" :height 80))
    "proof buffer-local face")
