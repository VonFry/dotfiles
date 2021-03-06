;;; core/core-keybinding.el -*- lexical-binding: t -*-
;;
;; This file doesn't set a lot of keybindinds, because the plugins are setting in modules and they cannot be set here.
;; If using hooks, I think it isn't beautiful enough. So the file only defines some keys which are bounded to use.
;;
;; The name with evil means that the keybind use with <leader> in evil-normal. I don't use `general-default-prefix` to
;; set leader because there are some normal bind without leader.
;;
;; All local map set for major or minor mode map by default. Only if the minor mode hasn't a map, such as robe, using
;; evil minor mode map instead which use a hook to add into local map.
;; All keybind use general.el to manage.
;;
;; All keys combine with leader when setting, this can have a more structed definitation.

(use-package general
  :custom
  (general-default-prefix nil)
  (general-default-global-prefix nil)
  :config
  (general-evil-setup t t)
  (general-define-key "C-h B" 'general-describe-keybindings)

  ;; Here defines some generic prefix keybinds, and the others are set in each
  ;; modules
  ;; I don't use `:keymaps 'override' because general.el uses
  ;; `evil-make-intercept-map' which cannot work with other keymaps. I want to
  ;; bind some keys only in special modes maps. We also cannot use
  ;; `define-minor-mode' to do this based on same reason. The better soluation
  ;; is using `evil-make-overriding-map' which has higher precedence than global
  ;; one but lower than other maps. and the overriding map is used by
  ;; `evil-collection'.
  (defmacro vonfry--keybind-definer(map)
    (let* ((map-str (symbol-name map))
           (map-leader (intern (concat map-str "-leader")))
           (map-mode   (intern (concat map-str "-mode")))
           (map-at     (intern (concat map-str "-at"))))
      `(progn
         (general-create-definer ,map-leader :wrapping ,map        :prefix "SPC")
         (general-create-definer ,map-mode   :wrapping ,map-leader :infix  "SPC")
         (general-create-definer ,map-at     :wrapping ,map-leader :infix  "@"))))
  (vonfry--keybind-definer nmap)
  (vonfry--keybind-definer vmap)
  (vonfry--keybind-definer nvmap)

  (nmap-leader "" '(:ignore t :which-key "leader"))
  (nmap-mode   "" '(:ignore t :which-key "mode special"))
  (nmap-at     "" '(:ignore t :which-key "web/mail/contacts/.."))

  (nmap-leader "Z" 'vonfry/next-theme)
  (nmap-leader "' d" 'vonfry/insert-current-date))

(provide 'vonfry-keybinding)
