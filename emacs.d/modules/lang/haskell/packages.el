;;; haskell config -*- lexical-binding: t -*-

(package! haskell
  :ensure haskell-mode
  :custom
  (haskell-indentation-layout-offset 4)
  (imenu-add-menubar-index t)
  (haskell-decl-scan-mode t)
  :hook
  ((haskell-mode . haskell-auto-insert-module-template)
  (haskell-mode .
    (lambda ()
      (custom-set-variables '(compile-command "stack build"))
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "qh" 'hoogle
            "ql" 'haskell-hoogle-lookup-from-local
            "qe" 'engine/search-hoogle
            "qs" 'haskell-hoogle-start-server
            "qk" 'haskell-hoogle-start-server
            "c"  'haskell-cabal-visit-file)
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-jump-module 'haskell-navigate-imports
            vonfry-keybind-evil-run         'haskell-compile)
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "y" 'hasky-extensions)))))

(package! lsp-haskell
  :after haskell lsp-mode
  :hook (haskell-mode . lsp-haskell-enable))
