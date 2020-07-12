{ lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {
  gtk = {
    enable = isLinux;
    font = {
      name = "Source Han Sans CN";
      package = pkgs.source-han-sans-simplified-chinese;
    };
    theme = {
      name = "Ant-Dracula";
      package = pkgs.ant-dracula-theme;
    };
    iconTheme = {
      name = "breeze-dark";
      package = pkgs.breeze-icons;
    };
  };

  qt = {
    enable = isLinux;
    platformTheme = "gtk";
  };

  programs = {
    feh.enable = isLinux;
    zathura.enable = isLinux;
    alacritty = {
      settings = import ./files/alacritty.nix;
      enable = isLinux;
    };
  };

  xsession = {
    enable = isLinux;
    initExtra = ''
      source ~/.zprofile
      feh --bg-center ~/.config/bg.png
    '';
    windowManager.xmonad = {
      enable = isLinux;
      enableContribAndExtras = true;
      config = ./files/xmonad.hs;
    };
  };

  services.dunst = {
    enable = isLinux;
    iconTheme = {
      name = "breeze-dark";
      package = pkgs.breeze-icons;
    };
    settings = {
      global = {
        font = "Source Han Sans CN";
      };
    };
  };

  home.packages = with pkgs; [
    gnuplot
  ] ++ lib.optionals stdenv.isLinux [
    nomachine-client
    feh
    cmus
    mpv
    inkscape
    gimp
    unstable.tor-browser-bundle-bin
    zerotierone
    handbrake # numactl works on linux # wait for pr https://github.com/NixOS/nixpkgs/pull/89674
    zathura
  ];
}