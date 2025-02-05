#!/usr/bin/env zsh


source "./util-logging.zsh"


AUR_REPO_URL="https://aur.archlinux.org"
AUR_PATH_DIR="${HOME}/opt/aur"


function install-hyprpanel() {
    mkdir -p "${AUR_PATH_DIR}"

    # These are dependency packages to be installed from `pacman -S`
    packages=(
        json-glib
        pam
        swww
        sdl2-compat
        vala
        pipewire-jack
        libnm
    )

    echo "pacman -S --asdeps ${packages}"

    # These are AUR packages we will manually build
    packages=(
        "f__appmenu-glib-translator"
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
        "t__aylurs-gtk-shell-git"
        "t__ags-hyprpanel-git"
    )

    for package in ${packages[@]}; do
        parts=( ${(@s:__:)package} )
        main=${parts[1]}
        name=${parts[2]}

        echo "[$(date -u --iso-8601=seconds)] Installing ${name}"

        install-aur ${name} ${main}
        # display-pkg ${name}
    done
}

function install-aur() {
    name=$1
    main=$2

    echo git clone "${AUR_REPO_URL}/${name}.git" "${AUR_PATH_DIR}/${name}"

    echo makepkg\
        -D "${AUR_PATH_DIR}/${name}"\
        -s

    archive=$(ls -1 ${name}/*.tar.zst | grep -v debug)

    if [ ${main} = "t" ]; then
        echo pacman -U ${archive}
    else
        echo pacman -U --asdeps ${archive}
    fi
}

function display-pkg() {
    name=$1

    echo pacman -Q -i "${name}"
}


