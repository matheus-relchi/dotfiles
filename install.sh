#!/bin/sh

if [ "$UID" -eq 0 ]; then
    echo 'This script should not be run as root' >&2
    exit 1
fi

echo "Getting sudo ready"
sudo -v

echo "Installing packages"
sudo pacman -Sy
sudo pacman -S --needed --noconfirm $(cat install_list)
echo "Packages installed"

echo "Installing yay Aur Helper"
rm -rf yay > /dev/null
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
rm -rf yay > /dev/null
cd ~
echo "Yay installed"

echo "Installing zsh plugins"
mkdir -p ~/.zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions/
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh/plugins/fast-syntax-highlighting/
echo "zsh plugins installed"

echo "Changing zsh to default shell"
chsh -s /usr/bin/zsh
echo "ZSH is the default shell now"

echo "Setup complete"
