;;; nix config -*- lexical-binding: t -*-
;;

(package! nix-mode
  :general
  (nmap :keymaps 'nix-mode-map
        :prefix +nmap-lang-prefix
        ""   '(nil :which-key "nix")
        "'"  'nix-repl
        "u"  'nix-unpack
        "c"  'nix-build))