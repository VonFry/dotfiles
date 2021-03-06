{ config, lib, pkgs, ... }:


with lib;
let
  cfg = config.vonfry.x;

  screenlocker = pkgs.writeScriptBin "screenlocker" ''
    #!${pkgs.bash}/bin/bash -e
    exec ${pkgs.i3lock-color}/bin/i3lock-color -c 282a36 --indicator -k -B 1 --insidecolor=282a36 --insidewrongcolor=282a36 --insidevercolor=282a36 --ringvercolor=bd93f9 --ringwrongcolor=ff79c6 --ringcolor=44475a --linecolor=6272a4 --keyhlcolor=f1fa8c --bshlcolor=ff5555 --verifcolor=bd93f9 --wrongcolor=ff79c6 --timecolor=f8f8f2 --datecolor=6272a4 "$@"
  '';

  lockCommand = "${screenlocker}/bin/screenlocker";
in {
  options.vonfry.x = {
    durationLock = mkOption {
      default = 600;
      type = types.int;
      description = "The no activation duration before system lock. unit: second.";
    };

    durationSuspend = mkOption {
      default = 1800;
      type = types.int;
      description = "The no activation duration before system suspending. unit: second.";
    };
  };

  config = mkIf config.vonfry.enable {
    environment.systemPackages = with pkgs; [
      xclip
      alacritty
      dunst libnotify
      vonfryPackages.sddm-slice-theme
      breeze-icons breeze-gtk breeze-qt5
      screenlocker

      # need by sddm theme in path
      libsForQt5.qtgraphicaleffects
    ];

    services.xbanish.enable = true;

    services.dbus.packages = with pkgs; [ dconf ];

    services.xserver = {
      enable = true;
      layout = "us";
      xkbVariant = mkDefault "dvp";
      autorun = mkDefault true;

      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
      };

      displayManager= {
        sddm = {
          enable = true;
          theme = "slice";
        };
      };
      windowManager = {
        xmonad = {
          enable = mkDefault true;
          enableContribAndExtras = true;
        };
      };
    };

    programs = {
      xss-lock = {
        enable = true;
        lockerCommand = "${lockCommand} -n";
      };
      qt5ct.enable = true;
    };

    systemd = {
      # Make screen locker in system due to security consider.
      user.services = {
        xidlehook = {
          enable = mkDefault true;
          description = "auto lock screen.";
          partOf = [ "graphical-session.target" ];
          script = ''
          ${pkgs.xidlehook}/bin/xidlehook \
            --timer ${toString cfg.durationLock}  "${lockCommand} || true" "" \
            --timer ${toString cfg.durationSuspend} "systemctl suspend" ""
        '';
          wantedBy = [ "graphical-session.target" ];
        };

        fcitx5-daemon = { # TODO remove after pr#127367 is merged
          enable = true;
          script = "${config.i18n.inputMethod.package}/bin/fcitx5";
          wantedBy = [ "graphical-session.target" ];
        };
      };
    };

    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-rime fcitx5-mozc fcitx5-chinese-addons
                                 ];
    };

    fonts = {
      fonts = with pkgs; [
        hack-font
        sarasa-gothic
        symbola
        liberation_ttf
        source-han-sans-simplified-chinese
        source-han-serif-simplified-chinese

        font-awesome
        # need for sddm
        roboto
      ];
      fontconfig = {
        enable = true;
        # config this by your self, it is depended on which screen you
        # are using. It is suggested as a multiple of 6 or 12.
        # dpi = 96;
        defaultFonts = {
          monospace = [ "Hack" "Sarasa Mono SC" "Font Awesome 5 Free" ];
          sansSerif = [ "Liberation Sans" "Soruce Han Sans SC" "Font Awesome 5 Free" ];
          serif = [ "Liberation Serif" "Source Han Serif SC" "Symbola" "Font Awesome 5 Free" ];
        };
      };
    };

  };
}
