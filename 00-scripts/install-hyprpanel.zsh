#!/usr/bin/env zsh


source "./util-logging.zsh"


AUR_REPO_URL="https://aur.archlinux.org"
AUR_PATH_DIR="${HOME}/opt/aur"


function install-hyprpanel() {
    mkdir -p "${AUR_PATH_DIR}"

    # These are dependency packages to be installed from `pacman -S`
    packages=(
        autoconf-archive
        blueprint-compiler
        cmake
        dart-sass
        fftw
        iniparser
        glib2
        glib2-devel
        gobject-introspection
        gtk-layer-shell
        gtk4
        gtk4-layer-shell
        json-glib
        libglvnd
        libnm
        libpipewire
        libpulse
        meson
        ncurses
        npm
        pam
        pipewire-jack
        sdl2-compat
        sndio
        swww
        vala
    )

    sudo pacman -S\
        --asdeps\
        --needed\
        ${packages}

    # These are AUR packages we will manually build
    packages=(
        "f__appmenu-glib-translator-git"
        "f__libcava"
        "f__libastal-apps-git"
        "f__libastal-auth-git"
        "f__libastal-battery-git"
        "f__libastal-bluetooth-git"
        "f__libastal-cava-git"
        "f__libastal-greetd-git"
        "f__libastal-hyprland-git"
        "f__libastal-io-git"
        "f__libastal-mpris-git"
        "f__libastal-network-git"
        "f__libastal-notifd-git"
        "f__libastal-powerprofiles-git"
        "f__libastal-river-git"
        "f__libastal-tray-git"
        "f__libastal-wireplumber-git"
        "t__libastal-4-git"
        "t__libastal-git"
        "t__libastal-gjs-git"
        "f__libastal-meta"
        "t__aylurs-gtk-shell-git"
        "t__ags-hyprpanel-git"
    )

    for package in ${packages[@]}; do
        parts=( ${(@s:__:)package} )
        main=${parts[1]}
        name=${parts[2]}

        echo "[$(date -u --iso-8601=seconds)] Installing ${name}"

        install-aur ${name} ${main}
        display-pkg ${name}
    done
}

function install-aur() {
    name=$1
    main=$2

    git clone "${AUR_REPO_URL}/${name}.git" "${AUR_PATH_DIR}/${name}"

    makepkg\
        -D "${AUR_PATH_DIR}/${name}"\
        -s

    archive=$(ls -1 "${AUR_PATH_DIR}/${name}"/*.tar.zst | grep -v debug)

    if [ ${main} = "t" ]; then
        sudo pacman -U\
            --needed\
            --noconfirm\
            ${archive}
    else
        sudo pacman -U\
            --needed\
            --noconfirm\
            --asdeps\
            ${archive}
    fi
}

function display-pkg() {
    name=$1

    sudo pacman -Q -i "${name}"
}

