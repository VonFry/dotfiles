;;; treemacs packages -*- lexical-binding: t -*-

(package! treemacs
  :custom
  (treemacs-follow-after-init          nil)
  (treemacs-width                      35)
  (treemacs-indentation                4)
  (treemacs-collapse-dirs              3)
  (treemacs-silent-refresh             nil)
  (treemacs-change-root-without-asking nil)
  (treemacs-sorting                    'alphabetic-desc)
  (treemacs-show-hidden-files          t)
  (treemacs-never-persist              nil)
  (treemacs-is-never-other-window      nil)
  (treemacs-goto-tag-strategy          'refetch-index)
  :config
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (pcase (cons (not (null (executable-find "git")))
               (not (null (executable-find "python"))))
  (`(t . t)
   (treemacs-git-mode 'extended))
  (`(t . _)
   (treemacs-git-mode 'simple))))

(package! treemacs-evil
  :after treemacs evil
  :demand t)

(package! treemacs-projectile
  :after projectile treemacs
  :config
  (setq treemacs-header-function #'treemacs-projectile-create-header)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
    vonfry-keybind-evil-treenode 'treemacs-projectile-toggle))
