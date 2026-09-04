#!/bin/bash

# Development status script for Zellij
# Shows git branch, node/go/ruby versions if available

get_git_info() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        branch=$(git branch --show-current 2>/dev/null || echo "unknown")
        if [ -z "$(git status --porcelain 2>/dev/null)" ]; then
            echo "🌿 $branch ✓"
        else
            echo "🌿 $branch ✗"
        fi
    fi
}

get_node_version() {
    if command -v node >/dev/null 2>&1; then
        echo "🟢 $(node --version)"
    fi
}

get_go_version() {
    if command -v go >/dev/null 2>&1; then
        echo "🔵 $(go version | awk '{print $3}')"
    fi
}

get_ruby_version() {
    if command -v ruby >/dev/null 2>&1; then
        echo "🔴 $(ruby --version | awk '{print $2}')"
    fi
}

get_current_dir() {
    echo "📁 $(basename "$PWD")"
}

# Build status line
status_parts=()
status_parts+=("$(get_current_dir)")

git_info=$(get_git_info)
if [ -n "$git_info" ]; then
    status_parts+=("$git_info")
fi

node_ver=$(get_node_version)
if [ -n "$node_ver" ]; then
    status_parts+=("$node_ver")
fi

go_ver=$(get_go_version)
if [ -n "$go_ver" ]; then
    status_parts+=("$go_ver")
fi

ruby_ver=$(get_ruby_version)
if [ -n "$ruby_ver" ]; then
    status_parts+=("$ruby_ver")
fi

echo "$(IFS=" | "; echo "${status_parts[*]}")"