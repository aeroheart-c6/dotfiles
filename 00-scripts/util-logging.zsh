#!/usr/bin/env zsh


function loginfo() {
    msg=$1

    echo "[$(date -u -Iseconds)] ${1}"
}
