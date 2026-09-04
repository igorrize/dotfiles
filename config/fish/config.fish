if status is-interactive
    # Enable vi mode for Fish shell
    set -g fish_key_bindings fish_vi_key_bindings
end

# Envkey completions removed (bash syntax incompatible with Fish)
# Use Fish completion system instead

set -gx ENV DEVELOPMENT
set -gx GOROOT $HOME/sdk/go1.26.0
fish_add_path --prepend $HOME/sdk/go1.26.0/bin
fish_add_path $HOME/.local/bin  # zj-radar CLI (and other user-local binaries)
