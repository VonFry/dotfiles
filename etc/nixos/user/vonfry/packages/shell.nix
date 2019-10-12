{ pkgs, ... }:

with pkgs; [
  gitAndTools.gitflow tig gitAndTools.git-extras
  zsh fzf
  direnv
  thefuck
  ranger
  parallel
  weechat
  mutt msmtp offlineimap
  googler
  lolcat
  fortune cmatrix figlet
  unstable.dropbox-cli
  asciinema
  flameshot
  neofetch
]
