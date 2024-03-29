BASE=$(PWD)

ifeq (, $(shell which brew))
  echo "No brew in ${PATH}, installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install coreutils
  brew tap d12frosted/emacs-plus
  brew install emacs-plus@30
  brew install gh
endif

tmux:
	ln -vsf $(BASE)/tmux/.tmux.conf $(HOME)/.tmux.conf

inputrc:
	ln -vsf $(BASE)/.inputrc $(HOME)/.inputrc

ipython:
	mkdir -p $(HOME)/.ipython/profile_stijn3/startup/
	ln -vsf $(BASE)/ipython/profile_stijn3/startup/00-autoload.py $(HOME)/.ipython/profile_stijn3/startup/00-autoload.py
	ln -vsf $(BASE)/ipython/profile_stijn3/startup/01-magics.ipy $(HOME)/.ipython/profile_stijn3/startup/01-magics.ipy
	ln -vsf $(BASE)/ipython/profile_stijn3/ipython_config.py $(HOME)/.ipython/profile_stijn3/ipython_config.py

	mkdir -p $(HOME)/.ipython/profile_default/startup/
	ln -vsf $(BASE)/ipython/profile_default/startup/00-autoload.py $(HOME)/.ipython/profile_default/startup/00-autoload.py
	ln -vsf $(BASE)/ipython/profile_default/startup/01-magics.ipy $(HOME)/.ipython/profile_default/startup/01-magics.ipy
	ln -vsf $(BASE)/ipython/profile_default/ipython_config.py $(HOME)/.ipython/profile_default/ipython_config.py

matplotlib:
	mkdir -p $(HOME)/.matplotlib/stylelib/
	mkdir -p $(HOME)/.config/matplotlib/stylelib/
	ln -vsf $(BASE)/matplotlib/stylelib/paper.mplstyle $(HOME)/.matplotlib/stylelib/paper.mplstyle
	ln -vsf $(BASE)/matplotlib/stylelib/paper.mplstyle $(HOME)/.config/matplotlib/stylelib/paper.mplstyle

zsh:
	git submodule init
	git submodule update
	mkdir -p $(HOME)/.oh-my-zsh
	ln -vsf $(BASE)/zsh/.zshrc $(HOME)/.zshrc
	ln -vsf $(BASE)/zsh/ohmyzsh/themes $(HOME)/.oh-my-zsh
	ln -vsf $(BASE)/zsh/ohmyzsh/plugins $(HOME)/.oh-my-zsh

hammerspoon:
	mkdir -p $(HOME)/.hammerspoon
	ln -vsf $(BASE)/hammerspoon/caffeine-off.pdf $(HOME)/.hammerspoon/caffeine-off.pdf
	ln -vsf $(BASE)/hammerspoon/caffeine-on.pdf $(HOME)/.hammerspoon/caffeine-on.pdf
	ln -vsf $(BASE)/hammerspoon/init.lua $(HOME)/.hammerspoon/init.lua

karabiner:
	mkdir -p $(HOME)/.config/karabiner
	ln -vsf $(BASE)/karabiner/karabiner.json $(HOME)/.config/karabiner/karabiner.json

all: tmux inputrc ipython matplotlib zsh hammerspoon karabiner
