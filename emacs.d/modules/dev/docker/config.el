;;; docker config -*- lexical-binding: t -*-

(use-package! docker
  :init
  (defcustom +docker-nmap-prefix
    (concat vonfry-keybind-evil-leader vonfry-keybind-evil-virtual)
    "docker nmap prefix"
    :type 'string
    :group 'vonfry-modules)
  (docker-global-mode t)
  :general
  (nmap :prefix +docker-nmap-prefix
      "c" 'docker-containers
      "d" 'docker-rmi
      "e" 'docker-unpause
      "F" 'docker-pull
      "k" 'docker-rm
      "i" 'docker-images
      "o" 'docker-stop
      "P" 'docker-push
      "p" 'docker-pause
      "r" 'docker-restart
      "s" 'docker-start))
