;;; cc config -*- lexical-binding: t -*-

(use-package! cquery
  :after lsp-mode
  :hook ((c-mode c++-mode objc-mode) . lsp-cquery-enable)
  :custom
  (cquery-executable "cquery")
  (cquery-sem-highlight-method 'font-lock))

;; this is used in all program lang
(use-package! semantic
	:custom
  (semantic-default-submodes
    '(global-semantic-highlight-func-mode
      global-semantic-idle-local-symbol-highlight-mode
      global-semantic-stickyfunc-mode
      global-semantic-highlight-edits-mode
      global-semantic-show-parser-state-mode))
  :config
  (semantic-mode t))

(use-package! disaster
  :hook
  ((c-mode c++-mode objc-mode) .
   (lambda ()
      (nmap :keymaps 'local
        :prefix +lang-nmap-prefix
        "d" 'disaster))))

;; this is used in all program lang
(use-package! compile)

(use-package! function-args
  :init
  (custom-set-variables
    '(moo-select-method 'helm))
  :hook
  (((c-mode c++-mode objc-mode) . 'fa-config-default)
  ((c-mode c++-mode objc-mode) .
    (lambda()
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "."     'fa-jump
            "s"     'fa-show
            "v"     'moo-propose-virtual
            "o"     'moo-propose-override
            "j"     'moo-jump-local)))))

(use-package! cmake-mode
  :mode ("\\.cmake\\'" "CMakeLists\\.txt\\'")
  :config
  (autoload 'cmake-mode "~/CMake/Auxiliary/cmake-mode.el" t))

(use-package! cmake-font-lock
  :after cmake-mode
  :hook
  (cmake-mode . cmake-font-lock-activate))
