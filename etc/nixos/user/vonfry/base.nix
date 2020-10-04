{ config, lib, pkgs, ... }:

{
  imports = [ ];

  nixpkgs = {
    config = import ./files/nixpkgs.nix;
    overlays = import ./overlay/overlays.nix;
  };

  xdg.configFile = {
    "nix/nix.conf".text = ''
        auto-optimise-store = true
        keep-outputs = true
        sandbox = false
        max-jobs = auto
        cores = 0
      '';
    "nixpkgs/config.nix".source = ./files/nixpkgs.nix;
  };

  home = {
    username = "vonfry";
    homeDirectory = "/home/vonfry";
    stateVersion = "20.09";

    activation.nixpkgsActivation = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${toString ./overlay/overlays.nix} ${toString config.xdg.configHome}/nixpkgs/overlays.nix
    '';

    packages = with pkgs; [
      atop # htop
      sshfs exfat
      lnav lm_sensors lsof

      patch parallel file

      zip unzip convmv unrar
      colordiff
      ripgrep fd # lsd bat
    ];
  };

  programs = {
    man.enable = true;
    bat.enable = true;
    ssh = {
      enable = true;
      compression = true;
      forwardAgent = true;
      serverAliveInterval = 60;
    };
    lsd = {
      enable = true;
      enableAliases = true;
    };
    htop = {
      enable = true;
      treeView = true;
      meters = {
        left = [
           { kind = "AllCPUs"; mode = 2; }
           { kind = "Memory" ; mode = 2; }
           { kind = "Swap"   ; mode = 2; }
        ];
        right = [
          { kind = "Clock"   ; mode = 2; }
          { kind = "Battery" ; mode = 2; }
          "Blank"
          { kind = "Tasks"   ; mode = 2; }
          { kind = "Uptime"  ; mode = 2; }
          "LoadAverage"
        ];
      };
    };
  };
}
