#!/bin/bash
set -e
DOTFZF=$HOME/.fzf
GITCLONE="git clone --depth=1"

RUST_CRATES=(
    bat
    bb
    bottom
    exa
    ripgrep
    fd-find
    hx
    du-dust
    cargo-play
    cargo-watch
    skim
    tokei
    watchexec
    procs
    hyperfine
    alacritty
    xplr
    gping
    neovide
)

PY3=(
    black
    flake8
    pynvim
    python-language-server
    vim-vint
    pyls-black
    httpie
    pipenv-shebang
    pipenv
    ps_mem
    speedtest-cli
    scanapi
)

NODE_PACKAGES=(
    neovim
    npm
    vscode-html-languageserver-bin
    vscode-css-languageserver-bin
    diagnostic-languageserver
    dockerfile-language-server-nodejs
    vscode-json-languageserver
    typescript-language-server
    vim-language-server
    yaml-language-server
    heroku
    prettier
    conventional-changelog-cli
)

GO_REPOS=(
    github.com/fullstorydev/grpcurl
    # github.com/charmbracelet/glow
    github.com/goreleaser/goreleaser
    github.com/go-delve/delve/cmd/dlv
    golang.org/x/tools/gopls@latest
    golang.org/x/tools/...
    github.com/divan/expvarmon
    github.com/cweill/gotests/...
    github.com/divan/expvarmon
    github.com/nojima/httpie-go
    github.com/caarlos0/svu
    github.com/ahmetb/kubectx
    github.com/goreleaser/chglog/cmd/chglog
    github.com/wercker/stern
)

ZSHPLUGS=(
  "zsh-completions"
  "zsh-history-substring-search"
  "zsh-syntax-highlighting"
  "zsh-autosuggestions"
)

print_error() {
    printf "\\e[0;31m%s\\e[0m\\n" " [ ✖ ] $1 $2"
}

print_info() {
    printf "\\e[0;35m%s\\e[0m\\n" "$1"
}

print_result() {
    if [ "$1" -eq 0 ]; then
        printf "\\e[0;32m%s\\e[0m\\n" " [ ✔ ] $2"
    else
        print_error "$2"
    fi

    return "$1"
}

set_trap() {
    trap -p "$1" | grep "$2" &>/dev/null || trap '$2' "$1"
}

create_folders() {
    mkdir -p ~/.local/bin
    mkdir -p $ZPLUGINSDIR
    # mkdir -p ~/.local/share/applications
}

configure_go() {
    print_info "Configuring golang environment.."

    for repo in "${GO_REPOS[@]}"; do
        go get -u $repo
    done
}

configure_python() {
    print_info "Configuring python environment.."
    curl -o ~/.local/bin/podman-compose https://raw.githubusercontent.com/containers/podman-compose/devel/podman_compose.py
    chmod +x ~/.local/bin/podman-compose
    if ! command -v pip3 >/dev/null; then
        local tmp_file="$(mktemp)"
        curl https://bootstrap.pypa.io/get-pip.py -o "$tmp_file"
        python3 "$tmp_file" --user
    fi
    pip3 install -U pip

    print_info "Installing python 3 packages"
    for pkg in "${PY3[@]}"; do
        pip3 install --user --upgrade "$pkg" --timeout=2
    done
}

configure_rust() {
    print_info "Installing rust"

    CARGO=$(which cargo)
    print_info "Installing rust crates"

    "$CARGO" install "${RUST_CRATES[@]}"
}


configure_node() {
    NPM=$(which npm)

    print_info "Installing node packages"
    for pkg in "${NODE_PACKAGES[@]}"; do
        "$NPM" install -i --global --update "$pkg"
    done

}

configure_zsh() {
    for zshplug in "${ZSHPLUGS[@]}"; do
        $GITCLONE "https://github.com/zsh-users/$zshplug.git" "$ZPLUGINSDIR/$zshplug" || \
            git -C "$ZPLUGINSDIR/$zshplug" pull
    done
}

install_neovim() {
    print_info "Neovim"
    NPATH="$HOME/.local"
    FILENAME="nvim-linux64.tar.gz"
    VERSION="nightly"
    # download latest nightly
    curl -fLo "$NPATH/$FILENAME" --create-dirs \
        "https://github.com/neovim/neovim/releases/download/$VERSION/$FILENAME"


    rm -rf "$NPATH/nvim/$VERSION"
    mkdir -p "$NPATH/nvim/$VERSION"

    # extract and remove tar
    tar xvf "$NPATH/$FILENAME" -C "$NPATH/nvim/$VERSION"
    rm "$NPATH/$FILENAME"

    # create symlinks for bin and desktop icon
    ln -fs "$NPATH/nvim/$VERSION/nvim-linux64/bin/nvim" "$NPATH/bin/nvim"
    #ln -fs "$NPATH/nvim-linux64/share/applications/nvim.desktop" "$NPATH/share/applications"

    # change desktop icon image path and update gnome applications db
    #sed -i "s/Icon\=nvim/Icon\=\/home\/$USER\/.local\/nvim-linux64\/share\/pixmaps\/nvim.png/g" "$NPATH/share/applications/nvim.desktop"
    #update-desktop-database "$NPATH/share/applications"
}

install_go() {
    print_info "Golang"
    NPATH="$HOME/.local/go"
    VERSION="1.16.3"
    FILENAME="go$VERSION.linux-amd64.tar.gz"
    if [ -d "$NPATH/$VERSION" ]; then
        print_info "Go $VERSION already exists in $NPATH/$VERSION"
        return
    fi

    print_info "Getting go $VERSION in $NPATH/$FILENAME"

    # download latest nightly
    if [ ! -f "$NPATH/$FILENAME" ]; then
        curl -fLo "$NPATH/$FILENAME" --create-dirs "https://golang.org/dl/$FILENAME"
    fi


    rm -rf "$NPATH/$VERSION"
    mkdir -p "$NPATH/$VERSION"

    ## extract and remove tar
    tar xvf "$NPATH/$FILENAME" -C "$NPATH/$VERSION"
    rm "$NPATH/$FILENAME"

    ln -fs "$NPATH/$VERSION/go" "$NPATH/go"
}

install_jq() {
    print_info "Jq"
    NPATH="$HOME/.local/jq"
    VERSION="1.6"
    FILENAME="jq-$VERSION-linux64"
    if [ -d "$NPATH/$FILENAME" ]; then
        print_info "Jq $VERSION already exists in $NPATH/$FILENAME"
        return
    fi

    print_info "Getting jq $VERSION in $NPATH/$FILENAME"

    # download latest nightly
    if [ ! -f "$NPATH/$FILENAME" ]; then
        curl -fLo "$NPATH/$FILENAME" --create-dirs \
            "https://github.com/stedolan/jq/releases/download/jq-$VERSION/jq-linux64"
    fi
    chmod +x "$NPATH/$FILENAME"

    ## create symlinks for bin and desktop icon
    ln -fs "$NPATH/$FILENAME" "$HOME/.local/bin/jq"
}

install_telegram() {
    print_info "Telegram"
    NPATH="$HOME/.local/telegram"
    VERSION="2.7.1"
    FILENAME="tsetup-$VERSION.tar.xz"
    if [ -d "$NPATH/$VERSION" ]; then
        print_info "Telegram $VERSION already exists in $NPATH/$VERSION"
        return
    fi

    print_info "Getting telegram $VERSION in $NPATH"

    # download latest nightly
    if [ ! -f "$NPATH/$FILENAME" ]; then curl -fLo "$NPATH/$FILENAME" --create-dirs \
        https://github.com/telegramdesktop/tdesktop/releases/download/v$VERSION/tsetup.$VERSION.tar.xz
    fi

    ## create symlinks for bin and desktop icon
    #ln -fs "$NPATH/$FILENAME" "$HOME/.local/bin/jq"
    rm -rf "$NPATH/$VERSION"
    mkdir -p "$NPATH/$VERSION"

    ## extract and remove tar
    tar xvf "$NPATH/$FILENAME" -C "$NPATH/$VERSION"
    rm "$NPATH/$FILENAME"

    ## create symlinks for bin and desktop icon
    ln -fs "$NPATH/$VERSION/Telegram/Telegram" "$HOME/.local/bin/telegram"
}


configure_fonts() {
  local fonts_path="$HOME/.local/share/fonts"
  if [ ! -f "$fonts_path/Fira Code Retina Nerd Font Complete.otf" ]; then
      local tmp="$(mktemp -d)"
      print_info $tmp
      mkdir -p $fonts_path

      curl -fLo "$tmp/firecode.zip" \
          https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip

      unzip $tmp/firecode.zip -d "$tmp"
      cp "$tmp/Fira Code Retina Nerd Font Complete.otf" $fonts_path
      cp "$tmp/Fira Code Retina Nerd Font Complete Mono.otf" $fonts_path
      cp "$tmp/Fira Code Regular Nerd Font Complete Mono.otf" $fonts_path
  fi
  fc-cache
}


main() {
    create_folders
    if $GITCLONE https://github.com/junegunn/fzf.git "$DOTFZF"; then
        "$DOTFZF/install" --key-bindings --completion --no-update-rc
    else
       git -C $DOTFZF pull
    fi
    install_telegram
    install_go
    install_jq
    install_neovim
    configure_go
    configure_python
    configure_rust
    configure_node
    configure_fonts
    configure_zsh
    echo "Success! Please restart the terminal to see the changes!"
}

main

