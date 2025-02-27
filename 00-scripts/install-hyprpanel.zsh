#!/usr/bin/env zsh


source "./util-logging.zsh"


function install-hyprpanel-deps() {
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
        grim
        gtk-layer-shell
        gtk4
        gtk4-layer-shell
        jq
        json-glib
        libglvnd
        libnm
        libpipewire
        libpulse
        meson
        ncurses
        npm
        oniguruma
        pam
        pipewire-jack
        scdoc
        sdl2-compat
        slurp
        sndio
        swww
        vala
    )

    sudo pacman -S\
        --asdeps\
        --needed\
        ${packages}

}

function install-hyprpanel() {
    prefix=${1}

    if [[ -z ${prefix} ]]; then
        prefix="${AUR_PATH_DIR}"
    fi

    mkdir -p "${prefix}"

    # These are AUR packages we will manually build
    packages=(
        "f__grimblast-git"
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

        loginfo "Installing ${name}"

        install-aur ${name} ${main} ${prefix}
        display-pkg ${name}
    done
}

function install-aur() {
    name=$1
    main=$2
    prefix=$3

    pkgdir="${prefix}/${name}"

    if [[ -d "${pkgdir}" ]]; then
        loginfo "Package already installed. Skipping..."
        return 1
    fi

    git clone "${AUR_REPO_URL}/${name}.git" "${pkgdir}"

    makepkg\
        -D "${pkgdir}"\
        -s

    archive=$(ls -1 "${pkgdir}"/*.tar.zst | grep -v debug)

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

    pacman -Q -i "${name}"
}

