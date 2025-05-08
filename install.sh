#!/bin/zsh
softwareupdate --install-rosetta --agree-to-license
# curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
git clone https://github.com/mirkonz/nix.git nix
cd nix
nix run nix-darwin -- switch --flake .#mirko