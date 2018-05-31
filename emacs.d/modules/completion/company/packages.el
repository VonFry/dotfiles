;;; company packages -*- lexical-binding: t -*-
;;

(package! company
  :custom
  (company-idle-delay 0.2)
  (company-tooltip-limit 16)
  (company-tooltip-flip-when-above t)
  :hook (text-mode . company-mode))

(package! company-quickhelp
  :after company
  :hook (company-mode . company-quickhelp-mode))
