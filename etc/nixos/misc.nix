{ config, pkgs, ...}:

let
    fira-code-symbols = pkgs.vonfryPackages.fira-code-symbols;
in {
  fonts = {
    fonts = [
      pkgs.hack-font
      pkgs.source-han-sans-simplified-chinese
      fira-code-symbols
      pkgs.source-han-serif-simplified-chinese
      pkgs.symbola
      pkgs.liberation_ttf
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Hack" "Fira Code" "Source Han Sans CN" ];
        sansSerif = [ "Source Han Sans CN" ];
        serif = [ "Liberation Serif" "Source Han Serif CN" "Symbola" ];
      };
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
}