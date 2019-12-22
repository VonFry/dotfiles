{ pkgs, ... }:

with pkgs; [
  gitAndTools.gitflow tig gitAndTools.git-extras
  zsh fzf
  direnv
  thefuck
  ranger
  parallel
  mu fetchmail
  vdirsyncerStable khard khal
  googler
  lolcat
  fortune cmatrix figlet
  asciinema
  flameshot
  neofetch
]
