{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    # QT is set by qt5ct manually and the qt5ct is configured in nixos module.
    gtk = {
      enable = true;
      font = {
        name = "monospace";
      };
      theme = {
        name = "Breeze-Dark";
        package = pkgs.breeze-gtk;
      };
      iconTheme = {
        name = "breeze-dark";
        package = pkgs.breeze-icons;
      };
    };

    programs = {
      alacritty = {
        settings = import ./files/alacritty.nix;
        enable = true;
      };
    };

    xsession = {
      enable = true;
      initExtra = ''
        feh --bg-center ${toString config.xdg.configHome}/bg.png
      '';
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = ./files/xmonad.hs;
      };

      pointerCursor = {
        package = pkgs.capitaine-cursors;
        name = "capitaine-cursors";
        size = mkDefault 16;
      };
    };

    services = {
      dunst = {
        enable = true;
        iconTheme = {
          name = "breeze-dark";
          package = pkgs.breeze-icons;
        };

        settings = {
          global = {
            font = "monospace";
            markup = true;
            plain_text = false;
            format = "<b>%s</b>\\n%b";
            sort = false;
            indicate_hidden = true;
            alignment = "center";
            bounce_freq = 0;
            show_age_threshold = -1;
            word_wrap = true;
            ignore_newline = false;
            stack_duplicates = true;
            hide_duplicates_count = true;
            geometry = "300x50-15+49";
            shrink = false;
            transparency = 5;
            idle_threshold = 0;
            monitor = 0;
            follow = "none";
            sticky_history = true;
            history_length = 15;
            show_indicators = false;
            line_height = 3;
            separator_height = 2;
            padding = 6;
            horizontal_padding = 6;
            separator_color = "frame";
            startup_notification = false;
            browser = "qutebrowser";
            icon_position = "off";
            max_icon_size = 80;
            frame_width = 3;
            frame_color = "#8EC07C";
          };
          urgency_low = {
            frame_color = "#3B7C87";
            foreground = "#3B7C87";
            background = "#191311";
            timeout = 4;
          };
          urgency_normal = {
            frame_color = "#5B8234";
            foreground = "#5B8234";
            background = "#191311";
            timeout = 6;
          };
          urgency_critical = {
            frame_color = "#B7472A";
            foreground = "#B7472A";
            background = "#191311";
            timeout = 8;
          };
        };
      };
    };

    xdg = {
      enable = true;
      userDirs.enable = true;
      mimeApps.enable = true;
      dataFile = {
        "applications/org-protocol.desktop".text = ''
          [Desktop Entry]
          Name=org-protocol
          Exec=emacsclient %u
          Icon=emacs-icon
          Type=Application
          Terminal=false
          MimeType=x-scheme-handler/org-protocol;
        '';
      };
    };
  };
}
