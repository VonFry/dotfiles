{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.vonfry.development;
  cfgEnable = config.vonfry.enable;
in {
  options.vonfry.development = {
    emacs = {
      preCustom = mkOption {
        default = "";
        type = types.lines;
      };
    };

    git = {
      signKey = {
        default = null;
        type = with types; nullOr str;
      };

    };

    texlive = {
      withDoc = mkEnableOption "texlive packages with doc.";
    };
  };

  config = mkIf cfgEnable {
    vonfry.development = {
      texlive.withDoc = mkDefault true;
    };

    xdg.configFile = {
      "emacs.d" = {
        source = ./files/emacs.d;
        recursive = true;
      };
      "nvim" = {
        source = ./files/nvim;
        recursive = true;
      };

      "emacs.d/local/pre-custom.el" = optionalString (isNull cfg.net.email) ''
        (custom-set-variables '(vonfry-exclude-modules '("misc/mail")))
      '' ++ cfg.emacs.preCustom;
    };

    services = {
      lorri.enable = true;
    };

    programs = {
      vim = {
        enable = true;
        settings = {
          background = "dark";
          backupdir = [ "~/.cache/vim/backup/" ];
          expandtab = true;
          mousemodel = "popup";
          number = true;
          relativenumber = true;
          shiftwidth = 4;
          ignorecase = true;
          smartcase = true;
          tabstop = 4;
          undofile = true;
          undodir = [ "~/.cache/vim/undo" ];
          history = 1024;
        };
        extraConfig = builtins.readFile ./files/vimrc;
      };
      neovim = {
        enable = true;
        plugins = with pkgs.vimPlugins; [
          vim-test
          # SQHell-vim
          vim-logreview
          vim-surround
          auto-pairs
          direnv-vim
          nerdtree
          nerdtree-git-plugin
          vim-rooter
          vim-projectionist
          vim-polyglot
          vim-ragtag
          # MatchTagAlways
          DoxygenToolkit-vim
          nerdcommenter
          vim-orgmode
          vim-easymotion
          tagbar
          fzf-vim
          editorconfig-vim
          vim-better-whitespace
          vim-signature
          incsearch-vim
          vim-over
          vimproc-vim
          tabular
          vim-which-key
          deoplete-nvim
          ultisnips
          vim-snippets
          # nvim-lspconfig # neovim > 0.5
          vim-fugitive
          vim-signify
          NeoSolarized
          dracula-vim
          vim-airline
          # vim-airline-clock
          indentLine
          vim-mundo
        ];
        extraConfig = ''
        call vonfry#init()
      '';
      };
      emacs =  {
        enable = true;
        extraPackages = epkgs: with epkgs; [
          pkgs.python3 pkgs.sqlite pkgs.perl pkgs.rubyPackages.jekyll

          all-the-icons
          solarized-theme
          dracula-theme
          general
          whitespace-cleanup-mode
          use-package
          diminish
          dash
          s
          auto-compile
          evil
          evil-numbers
          evil-surround
          evil-matchit
          amx
          flx
          ivy
          counsel
          ivy-avy
          swiper
          ivy-rich
          counsel-tramp
          flycheck
          auctex
          auctex-latexmk
          company-math
          company-auctex
          dashboard
          proof-general
          company-coq
          python-mode
          pydoc
          nix-mode
          gnuplot
          org
          org-bullets
          evil-org
          org-web-tools
          org-journal
          org-ql
          org-roam
          org-roam-server
          rust-mode
          cargo
          company-shell
          markdown-mode
          epkgs."markdown-mode+"
          haskell-mode
          lsp-haskell
          hasky-extensions
          haskell-snippets
          easy-jekyll
          json-mode
          yaml-mode
          magit
          git-commit
          transient
          with-editor
          gitconfig-mode
          gitignore-mode
          gitattributes-mode
          magit-gitflow
          evil-magit
          gitlab-ci-mode
          forge
          inf-ruby
          diff-hl
          disaster
          function-args
          cmake-mode
          cmake-font-lock
          realgud-lldb
          mu4e-alert
          mu4e-maildirs-extension
          elfeed
          emacsql
          sql-indent
          ebib
          company
          company-quickhelp
          company-prescient
          w3m
          yasnippet
          yasnippet-snippets
          info-colors
          dumb-jump
          ranger
          avy
          ace-window
          google-translate
          treemacs
          treemacs-evil
          treemacs-projectile
          treemacs-magit
          treemacs-icons-dired
          ebdb
          which-key
          docker
          logview
          pdf-tools
          projectile
          counsel-projectile
          org-projectile
          ibuffer-vc
          ibuffer-projectile
          lsp-mode
          company-lsp
          lsp-treemacs
          lsp-ivy
          editorconfig
          realgud
          engine-mode
          evil-nerd-commenter
          rainbow-delimiters
          highlight-indent-guides
          origami
          doom-modeline
          hl-todo
          hlinum
          rainbow-mode
          undo-tree
          hledger-mode
          ess
          direnv
        ];
      };
      git = {
        userName = "Vonfry";
        userEmail = "mail@vonfry.name";
        signing = mkIf (cfg.git.signKey != null) {
          signByDefault = true;
          key = cfg.git.signKey;
        };
        enable = true;
        extraConfig = {
          pull.rebase = false;
        };
        lfs.enable = true;
        ignores = [ (builtins.readFile ./files/gitignore) ];
      };

      direnv = {
        enable = true;
        enableZshIntegration = true;
      };

      texlive = {
        enable = true;
        extraPackages = tpkgs: {
          inherit (tpkgs) scheme-medium collection-latexextra
            collection-bibtexextra collection-publishers collection-langchinese;
          pkgFilter = (pkg: with lib; with pkg;
            elem tlType ([ "run" "bin" ] ++
                         optional cfg.texlive.withDoc ["doc" ]) ||
            elem pname  [ "core" ]);
        };
      };
    };

    home = {
      sessionVariables = {
        EDITOR = "nvim";
      };

      packages = with pkgs; [
        # neovim vim emacs

        # git git-lfs
        gitAndTools.gitflow tig gitAndTools.git-extras

        nixfmt nix-doc
        niv

        cloc

        pandoc
        zeal

        # texlive.combined.scheme-full
      ];

      # Use home.file instead of programs.<editor> due to I want to have a structure
      # config file for them.
      file = {
        ".tigrc".text = ''
        set log-options = --show-signature
        set diff-options = --show-signature
      '';
        ".vimrc".source = ./files/vimrc;
        ".ghc/ghci.conf".text = ''
        :set +m

        -- see more about extension: https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/glasgow_exts.html
        :set -XLambdaCase
        :set -XMultiWayIf
        :set -XBinaryLiterals
        :set -XBangPatterns

        :set -XTemplateHaskell
        :set -XNamedFieldPuns
        :set -XFlexibleContexts
        :set -XFlexibleInstances
        :set -XMultiParamTypeClasses

        :set -XUnicodeSyntax

        :set -XDeriveGeneric
        :set -XDeriveFunctor
        :set -XDeriveFoldable

        :set -XImplicitParams

        -- preference
        :set prompt "λ "
        :set prompt-cont "> "

        -- allow C-c
        :set -fomit-yields
      '';
        ".latexmkrc".text = ''
        $out_dir = "latex.out";
        $pdf_mode = 5;
        $dvi_previewer = 'xdvi -watchfile 1.5';
        $ps_previewer  = 'feh';
        $pdf_previewer = 'zathura';
      '';
      };
    };
  };
}
