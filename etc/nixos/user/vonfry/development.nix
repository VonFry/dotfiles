{ pkgs, ... }:

{
  xdg.configFile = {
    "emacs.d" = {
      source = ./files/emacs.d;
      recursive = true;
    };
    "nvim" = {
      source = ./files/nvim;
      recursive = true;
    };
  };
  # Use home.file instead of programs.<editor> due to I want to have a structure
  # config file for them.
  home.file = {
    ".tigrc".text = ''
      set log-options = --show-signature
      set diff-options = --show-signature
    '';
    ".gnupg/gpg.conf".text = ''
      keyserver hkps://keys.openpgp.org
    '';
    ".vimrc".source = ./files/vimrc;
    ".ghc/ghci.conf".text = ''
      :set -fbreak-on-exception
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

  services = {
    lorri.enable = true;
  };

  programs = {
    git = {
      userName = "Vonfry";
      userEmail = "mail@vonfry.name";
      signing.signByDefault = true;
      enable = true;
      lfs.enable = true;
      ignores = [ (builtins.readFile ./files/gitignore) ];
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    texlive = {
      enable = true;
      extraPackages = tpkgs: { inherit (tpkgs) scheme-small; };
    };
  };

  home.packages = with pkgs; let
    hie = vonfryPackages.hie;
    perl = vonfryPackages.perl;
    ghc = vonfryPackages.ghc;
    python = vonfryPackages.python;
  in [
    neovim
    vim
    emacs
    editorconfig-core-c

    cloc
    patchelf
    binutils-unwrapped
    # llvmPackages.clang llvm lldb
    cmake gnumake
    doxygen

    bear clang-tools

    ghc
    cabal-install
    haskellPackages.dhall
    haskellPackages.hoogle
    haskellPackages.stylish-haskell
    cabal2nix
    hie

    rustup carnix

    perl
    python

    coq

    poppler
    pandoc

    ctags

    sqlite
    mysql
    postgresql
    redis

    httpstat

    # texlive.combined.scheme-full
    zeal
    glibcInfo
  ];
}
