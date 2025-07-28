#============================================================
# Environment
#
# Best set in `~/.zprofile` so other tools can pick this up
#============================================================
if [[ ! -n $SDKMAN_DIR ]]; then
    export SDKMAN_DIR="$HOME/dev/lib/sdkman"
fi

#============================================================
# Initialize
#
# Put at the end
#============================================================
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"