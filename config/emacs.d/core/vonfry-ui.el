;;; core/core-ui.el -*- lexical-binding: t; -*-
;;
;; Set emacs ui with the default variables and other theme.
;; The default theme is solarized.

(package! all-the-icons) ;; M-x all-the-icons-install-fonts and the run (fc-cache -f -v) with shell

(package! solarized
  :ensure solarized-theme
  :custom
  (solarized-use-variable-pitch nil)
  (solarized-scale-org-headlines nil)
  (solarized-scale-outline-headlines nil)
  (solarized-height-minus-1 1.0)
  (solarized-height-plus-1 1.0)
  (solarized-height-plus-2 1.0)
  (solarized-height-plus-3 1.0)
  (solarized-height-plus-4 1.0)
  :config
  (load-theme 'solarized-dark t))

;; customize the tabbar and other UI elements for GUI.

;;
;; customize the fonts
;;

(defcustom vonfry-fontsize (vonfry-system-sets (darwin 11)
                                               (gnu/linux 9))
  "vonfry fontsize in window system"
  :type 'integer
  :group 'vonfry-modules)
(progn
  (set-face-attribute 'default nil :family "Hack" :height (* 10 vonfry-fontsize))
  (set-fontset-font nil 'unicode (font-spec :name "Symbola" :height (* 10 vonfry-fontsize)) nil 'append)
  (dolist (charset '(greek symbol))
    (set-fontset-font nil charset (font-spec :name "Symbola" :height (* 10 vonfry-fontsize)) nil 'prepend))
  (dolist (font '("Hei" "Source Han Sans CN"))
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset
                        (font-spec :family font :size (+ 2 vonfry-fontsize))
                        nil 'append))))

(package! info)

(custom-set-variables
  '(tool-bar-mode nil)
  '(menu-bar-mode nil)

  '(use-file-dialog nil)
  '(use-dialog-box nil)
  '(inhibit-startup-screen t)
  '(inhibit-startup-echo-area-message t)

  '(display-time-mode t)
  '(display-time-24hr-format t))

(let ((no-border '(internal-border-width . 0)))
  (add-to-list 'default-frame-alist no-border)
  (add-to-list 'initial-frame-alist no-border))

(add-hook 'term-mode-hook
  (lambda ()
    (setq line-spacing 0)))

(defgroup vonfry-ui nil
  "vonfry's emacs ui custom group")

(provide 'vonfry-ui)