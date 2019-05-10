{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # c family
    gcc gdb llvmPackages.clang llvm lldb
    binutils ninja cmake gnumake

    # haskell
    ghc
    cabal-install

    ruby bundler bundix ## rbenv; not! use nix instead.

    python3Full

    nodejs
  ];
}
