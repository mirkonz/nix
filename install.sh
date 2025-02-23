#!/bin/zsh
softwareupdate --install-rosetta --agree-to-license
# curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
# . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
git clone https://github.com/mirkonz/nix.git nix
cd nix
nix run nix-darwin -- switch --flake .#mirko