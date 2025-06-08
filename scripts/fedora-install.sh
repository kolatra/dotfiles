#!/bin/bash

# TODO: add a NixOS specific install sequence to install from the
# headless ISO

source /etc/os-release
DISTRO=$ID

if [[ $DISTRO == "fedora" ]]; then
	ln -s "$(pwd)/../zsh/.zshrc" ~/.zshrc
	ln -s "$(pwd)/../nvim" ~/.config/nvim
	ln -s "$(pwd)/../git/.gitconfig" ~/.gitconfig

	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

	# install needed stuff from dnf
	# oh god why didn't I write down what I installed
	
	sudo dnf install just make git zsh

elif [[ $DISTRO == "nixos" ]]; then
	echo "NixOS found"
fi

