(require-package 'solarized-theme)
(load-theme 'solarized-dark t)

;; Changing font sizes
(require-package 'default-text-scale)
(global-set-key (kbd "C-M-=") 'default-text-scale-increase)
(global-set-key (kbd "C-M--") 'default-text-scale-decrease)

;; Setting English Font
(set-face-attribute
 'default nil :font "Hack 11")
;; Chinese Font 配制中文字体
(defmacro chinese-font (font-name)
  `(dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family ,font-name :size 14))))
(if *is-a-mac*
  (chinese-font "Hei")
  f)

(setq display-time-format "%T")
(display-time-mode 1)

(provide 'init-theme)
