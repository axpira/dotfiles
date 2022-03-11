#!/bin/bash
set -e
DOTFZF=$HOME/.fzf
GITCLONE="git clone --depth=1"
NVIM_PLUGIN_DIR="$HOME/.local/share/nvim/site/pack/mini/start"

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
	#procs
	hyperfine
	alacritty
	#xplr
	#gping
	#neovide
	#startship
	shellharden
	taplo-cli
	watchexec-cli
)

PY3=(
	autopep8
	podman-compose
	black
	flake8
	pynvim
	python-language-server
	vim-vint
	pyright
	httpie
	pipenv-shebang
	pipenv
	ps_mem
	speedtest-cli
	scanapi
	mkdocs
	mkdocs-build-plantuml-plugin
	gcloud
	tstock
	mypy
	jsonlint
	proselint
	pydocstyle
	pylint
	vulture
	yamllint
	codespell
  debugpy
)

NODE_PACKAGES=(
	neovim
	npm
	vscode-html-languageserver-bin
	vscode-css-languageserver-bin
	diagnostic-languageserver
	dockerfile-language-server-nodejs
	vscode-json-languageserver
	vscode-langservers-extracted
	typescript-language-server
	vim-language-server
	yaml-language-server
	heroku
	prettier
	conventional-changelog-cli
	@mermaid-js/mermaid-cli
	eslint_d
	fixjson
	cspell
	markdownlint-cli
	standard
	write-good
	xo
)

GO_REPOS=(
	# github.com/fullstorydev/grpcurl/cmd/grpccurl
	# github.com/charmbracelet/glow
	# github.com/goreleaser/goreleaser
	github.com/go-delve/delve/cmd/dlv
	golang.org/x/tools/gopls
	golang.org/x/tools/cmd/goimports
	github.com/divan/expvarmon
	github.com/divan/expvarmon
	github.com/nojima/httpie-go/cmd/ht
	github.com/caarlos0/svu
	github.com/ahmetb/kubectx/cmd/kubectx
	github.com/ahmetb/kubectx/cmd/kubens
	github.com/goreleaser/chglog/cmd/chglog
	github.com/akavel/up
	github.com/peco/peco/cmd/peco
	honnef.co/go/tools/cmd/staticcheck
	# github.com/wercker/stern
	github.com/cucumber/godog/cmd/godog
	github.com/segmentio/topicctl/cmd/topicctl
	mvdan.cc/gofumpt
	github.com/yoheimuta/protolint/cmd/protolint
	mvdan.cc/sh/v3/cmd/shfmt
	github.com/rhysd/actionlint/cmd/actionlint
	github.com/mrtazz/checkmake/cmd/checkmake
	github.com/client9/misspell/cmd/misspell
	github.com/golangci/golangci-lint/cmd/golangci-lint
)

ZSHPLUGS=(
	"zsh-completions"
	"zsh-autosuggestions"
	"zsh-syntax-highlighting"
)
# "zsh-history-substring-search"
# "git@github.com:lewis6991/gitsigns.nvim.git"
# "git@github.com:echasnovski/mini.nvim.git"
# "git@github.com:norcalli/nvim-colorizer.lua.git"
# "git@github.com:neovim/nvim-lspconfig.git"
# "git@github.com:nvim-lua/plenary.nvim.git"
# "git@github.com:stefanvanburen/rams.vim.git"
# "git@github.com:nvim-telescope/telescope.nvim.git"
# "git@github.com:nvim-treesitter/nvim-treesitter.git"
# "git@github.com:leoluz/nvim-dap-go.git"
# "git@github.com:mfussenegger/nvim-dap.git"
# "git@github.com:rcarriga/nvim-dap-ui.git"
# "git@github.com:nvim-telescope/telescope-dap.nvim.git"
# "git@github.com:theHamsta/nvim-dap-virtual-text.git"
NVIM_PLUGINS=(
	"git@github.com:kyazdani42/nvim-web-devicons.git"
	"git@github.com:folke/trouble.nvim.git"
	"git@github.com:ellisonleao/gruvbox.nvim.git"
	"git@github.com:neovim/nvim-lspconfig.git"
	"git@github.com:stefanvanburen/rams.vim.git"
	"git@github.com:lewis6991/gitsigns.nvim.git"
	"git@github.com:nvim-lua/plenary.nvim.git"
	"git@github.com:norcalli/nvim-colorizer.lua.git"
	"git@github.com:nvim-telescope/telescope.nvim.git"
	"git@github.com:nvim-treesitter/nvim-treesitter.git"
	"git@github.com:jose-elias-alvarez/null-ls.nvim.git"
	"git@github.com:leoluz/nvim-dap-go.git"
	"git@github.com:mfussenegger/nvim-dap.git"
	"git@github.com:rcarriga/nvim-dap-ui.git"
	"git@github.com:nvim-telescope/telescope-dap.nvim.git"
	"git@github.com:theHamsta/nvim-dap-virtual-text.git"
  "git@github.com:mfussenegger/nvim-dap-python.git"
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
	mkdir -p "$DOTFZF"
	mkdir -p "$ZPLUGINSDIR"
	mkdir -p "$NVIM_PLUGIN_DIR"
	# mkdir -p ~/.local/share/applications
}

configure_go() {
	print_info "Configuring golang environment.."

	for repo in "${GO_REPOS[@]}"; do
		go install "$repo@latest"
	done
}

configure_python() {
	print_info "Configuring python environment.."
	if ! grep -q debian /etc/os-release; then
		python -m ensurepip --upgrade || true
		python -m pip install --upgrade pip
	fi
	print_info "Installing python 3 packages"
	for pkg in "${PY3[@]}"; do
		echo Installing "$pkg"
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
		if [ ! -d "$ZPLUGINSDIR/$zshplug" ]; then
			"$GITCLONE" "https://github.com/zsh-users/$zshplug.git" "$ZPLUGINSDIR/$zshplug"
		fi
		git -C "$ZPLUGINSDIR/$zshplug" pull
	done

	if [ ! -d "$HOME/.powerlevel10k/" ]; then
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
	fi
	git -C ~/.powerlevel10k pull
}

configure_nvim() {
	cd "$NVIM_PLUGIN_DIR"
	for plug in "${NVIM_PLUGINS[@]}"; do
		local name="${plug/*\//}"
		name="${name%.*}"
		echo "$name"
		if [ ! -d "$name" ]; then
			git clone "$plug"
		else
			git -C "$name" pull
		fi
	done
	cd -
	nvim --headless +TSUpdate +q
}

install_neovim() {
	print_info "Neovim"
	NPATH="$HOME/.local"
	FILENAME="nvim-linux64.tar.gz"
	#VERSION="nightly"
	VERSION="latest"
	# download latest nightly
	curl -fLo "$NPATH/$FILENAME" --create-dirs \
		"https://github.com/neovim/neovim/releases/$VERSION/download/$FILENAME"

	# "https://github.com/neovim/neovim/releases/latest"
	# "https://github.com/neovim/neovim/releases/latest/download/earthly-linux-amd64"
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

install_earthly() {
	# tmp=$(mktemp -d)
	curl -fLo "$HOME/.local/bin/earthly" --create-dirs \
		"https://github.com/earthly/earthly/releases/latest/download/earthly-linux-amd64"
	chmod +x "$HOME"/.local/bin/earthly
	earthly bootstrap --with-autocomplete
}

install_go() {
	print_info "Golang"
	NPATH="$HOME/.local/go"
	VERSION="1.17"
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
	VERSION="3.1.8"
	FILENAME="tsetup-$VERSION.tar.xz"
	if [ -d "$NPATH/$VERSION" ]; then
		print_info "Telegram $VERSION already exists in $NPATH/$VERSION"
		return
	fi

	print_info "Getting telegram $VERSION in $NPATH"

	# download latest nightly
	if [ ! -f "$NPATH/$FILENAME" ]; then
		curl -fLo "$NPATH/$FILENAME" --create-dirs \
			https://github.com/telegramdesktop/tdesktop/releases/download/v"$VERSION/tsetup.$VERSION".tar.xz
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
	# if [ ! -f "$fonts_path/Fira Code Retina Nerd Font Complete.otf" ]; then
	#     local tmp="$(mktemp -d)"
	#     print_info $tmp
	#     mkdir -p $fonts_path

	#     curl -fLo "$tmp/firecode.zip" \
	#         https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip

	#     unzip $tmp/firecode.zip -d "$tmp"
	#     cp "$tmp/Fira Code Retina Nerd Font Complete.otf" $fonts_path
	#     cp "$tmp/Fira Code Retina Nerd Font Complete Mono.otf" $fonts_path
	#     cp "$tmp/Fira Code Regular Nerd Font Complete Mono.otf" $fonts_path
	#     rm -rf $tmp
	# fi
	local tmp="$(mktemp -d)"
	print_info "$tmp"
	mkdir -p "$fonts_path"

	# curl -fLo "$tmp/SourceCodePro.zip" \
	#     https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip
	#     #https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Inconsolata.zip
	#     # https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip

	# unzip $tmp/SourceCodePro.zip -d "$tmp"
	# cp "$tmp/Sauce Code Pro Light Nerd Font Complete Mono.ttf" $fonts_path
	# cp "$tmp/Sauce Code Pro Light Nerd Font Complete.ttf" $fonts_path
	# cp "$tmp/Sauce Code Pro ExtraLight Nerd Font Complete Mono.ttf" $fonts_path
	# cp "$tmp/Sauce Code Pro ExtraLight Nerd Font Complete.ttf" $fonts_path
	# cp "$tmp/Sauce Code Pro Nerd Font Complete.ttf" $fonts_path
	# cp "$tmp/Sauce Code Pro Nerd Font Complete Mono.ttf" $fonts_path
	# cp "$tmp/Sauce Code Pro Medium Nerd Font Complete Mono.ttf" $fonts_path
	# cp "$tmp/Sauce Code Pro Medium Nerd Font Complete.ttf" $fonts_path

	curl -fLo "$fonts_path/MesloLGS NF Regular.ttf" \
		"https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
	# curl -fLo "<FONT NAME> Nerd Font Complete.otf" \
	#     https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/<FONT_PATH>/complete/<FONT_NAME>%20Nerd%20Font%20Complete.otf
	curl -fLo "$fonts_path/JetBrains Mono ExtraLight Nerd Font Complete.ttf" \
		https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Ligatures/ExtraLight/complete/JetBrains%20Mono%20ExtraLight%20Nerd%20Font%20Complete.ttf?raw=true
	curl -fLo "$fonts_path/JetBrains Mono Light Nerd Font Complete.ttf" \
		https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Ligatures/Light/complete/JetBrains%20Mono%20Light%20Nerd%20Font%20Complete.ttf?raw=true

	rm -rf "$tmp"
	fc-cache
}

install_cheat() {
	local PATH_DIR="$HOME/.local/bin" # or another directory on your $PATH
	mkdir -p "$PATH_DIR"
	curl https://cht.sh/:cht.sh >"$PATH_DIR/cht"
	chmod +x "$PATH_DIR/cht"
}

main() {
	create_folders
	if "$GITCLONE" https://github.com/junegunn/fzf.git "$DOTFZF" 2>&-; then
		"$DOTFZF/install" --key-bindings --completion --no-update-rc
	else
		git -C "$DOTFZF" pull
	fi
	install_cheat
	install_go
	install_neovim
	install_jq
	configure_nvim
	configure_node
	configure_go
	configure_python
	configure_rust
	configure_fonts
	# configure_zsh
	curl -fsSL https://github.com/Bhupesh-V/ugit/releases/latest/download/ugit -o "$HOME"/.local/bin/ugit && chmod +x "$HOME"/.local/bin/ugit
	echo "Success! Please restart the terminal to see the changes!"
}

main
