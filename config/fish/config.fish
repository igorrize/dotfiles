if status is-interactive
    # Enable vi mode for Fish shell
    set -g fish_key_bindings fish_vi_key_bindings
end

# Envkey completions removed (bash syntax incompatible with Fish)
# Use Fish completion system instead

set -gx ENV DEVELOPMENT
# Local Go SDK (macOS/dev machine); skip in containers where go lives elsewhere (e.g. /usr/local/go)
if test -d $HOME/sdk/go1.26.0
    set -gx GOROOT $HOME/sdk/go1.26.0
    fish_add_path --prepend $HOME/sdk/go1.26.0/bin
end
fish_add_path $HOME/.local/bin  # zj-radar CLI (and other user-local binaries)
