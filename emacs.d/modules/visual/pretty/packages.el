;;; pretty modules -*- lexical-binding: t; -*-
;;

(add-hook 'after-change-major-mode-hook #'+pretty-code-init-pretty-symbols-h)

(add-hook 'doom-init-ui-hook #'+pretty-code-setup-fira-ligatures-h)

(custom-set-variables
  '(prettify-symbols-unprettify-at-point 'right-edge))