#!/usr/bin/env bash

sudo nixos-generate-config --show-hardware-config > "$HOME/.dotfiles/nix/hosts/$HOSTNAME/hardware-configuration.nix"
sudo nixos-rebuild switch --flake "$HOME/.dotfiles/nix#$HOSTNAME"
