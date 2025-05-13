#!/usr/bin/env zsh


source "./conf.zsh"
source "./util-logging.zsh"
source "./install-hyprpanel.zsh"


function install-essentials() {
    packages=(
        base-devel
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
        hyprpicker
        hyprpolkitagent
        rofi-wayland
        wl-clipboard
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
        xdg-user-dirs

        firefox
        nautilus
        sushi
        gnome-font-viewer
        vim
        gvfs
        zsh
        starship

        go

        otf-monaspace
        ttf-jetbrains-mono
        ttf-jetbrains-mono-nerd
    )

    sudo pacman -S\
        --needed\
        ${packages}
}

function main() {
    loginfo "Installing essential packages"
    install-essentials

    echo "=============================="

    loginfo "Installing hyprpanel"
    install-hyprpanel-deps
    install-hyprpanel "${AUR_PATH_DIR}"

    echo "=============================="

    # loginfo "Adjusting dconf settings"
    # echo dconf write\
    #     "/org/gnome/desktop/interface/gtk-theme"\
    #     "'Adwaita'"

    # dconf write\
    #     "/org/gnome/desktop/interface/color-scheme"\
    #     "'prefer-dark'"
}

main ${@}
