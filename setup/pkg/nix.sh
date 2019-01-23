echo_info "** setup nix"

if [[ ! (-f /etc/os-release && $(cat /etc/os-release) =~ "nixos") ]]; then
    if command -v nix-env >/dev/null 2>&1; then
        echo_info "*** setup nix"
        cat $script_dir/config/pkgs/nix.sh | xargs -I "{}" -n1 nix-env -iA "nixpkgs.{}"
    else
        echo_warn "!!! ERROR: NO nix"
        exit 1
    fi
else
    echo_info "*** You are on NixOS. Skip this process."
fi