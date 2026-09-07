# Keep a forwarded SSH agent usable across reconnects inside a persistent
# multiplexer (zellij/tmux). The forwarded $SSH_AUTH_SOCK path changes on every
# ssh reconnect, but long-lived panes keep the old (dead) value. We pin a stable
# symlink (~/.ssh/agent.sock); real ssh login shells repoint it to the current
# socket, and every shell uses the stable path — so panes keep working after
# `devpod ssh` reconnects.
if set -q SSH_AUTH_SOCK
    and test "$SSH_AUTH_SOCK" != "$HOME/.ssh/agent.sock"
    and test -S "$SSH_AUTH_SOCK"
    ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/agent.sock"
end
if test -S "$HOME/.ssh/agent.sock"
    set -gx SSH_AUTH_SOCK "$HOME/.ssh/agent.sock"
end
