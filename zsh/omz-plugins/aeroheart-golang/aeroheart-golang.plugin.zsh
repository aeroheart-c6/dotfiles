#============================================================
# Environment
#
# Best set in `~/.zprofile` so other tools can pick this up
#============================================================
if [[ ! -n $GOPATH ]]; then
    export GOPATH="$HOME/dev/lib/go"
fi