(when (require-package 'diff-hl)
  (add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
  (add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode))

(require-package 'browse-at-remote)

(provide 'init-vc)

