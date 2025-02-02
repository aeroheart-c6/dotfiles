#!/usr/bin/env zsh


source "./util-logging.zsh"
source "./install-hyprpanel.zsh"


function install-essentials() {
    packages=(
        bluez
        bluez-utils
        git
        gnupg
        networkmanager
        openssh
        pipewire
        pipewire-alsa
        pipewire-audio
        pipewire-pulse

        sddm
        hyprland
        hyprlock
        hypridle
        hyprpaper
        hyprpolkitagent
        rofi-wayland
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
        xdg-user-dirs

        firefox
        kitty
        nautilus
        sushi
        gnome-font-viewer
        vim
        gvfs
        zsh
        starship

        otf-monaspace
        otf-monaspace-nerd
        ttf-jetbrains-mono
        ttf-jetbrains-mono-nerd
    )

    echo pacman -S ${packages}
}

function main() {
    loginfo "Installing essential packages"
    install-essentials

    echo "=============================="

    loginfo "Installing hyprpanel"
    install-hyprpanel

    echo "=============================="

    loginfo "Adjusting dconf settings"
    echo dconf write\
        "/org/gnome/desktop/interface/gtk-theme"\
        "'Adwaita'"

    echo dconf write\
        "/org/gnome/desktop/interface/color-scheme"\
        "'prefer-dark'"
}

main ${@}
