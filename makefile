BASE=$(PWD)

tmux:
	ln -vsf $(BASE)/tmux/.tmux.conf $(HOME)/.tmux.conf

inputrc:
	ln -vsf $(BASE)/.inputrc $(HOME)/.inputrc

ipython:
	mkdir -p $(HOME)/.ipython/profile_stijn3/startup/
	ln -vsf $(BASE)/ipython/profile_stijn3/startup/00-autoload.py $(HOME)/.ipython/profile_stijn3/startup/00-autoload.py
	ln -vsf $(BASE)/ipython/profile_stijn3/startup/01-magics.ipy $(HOME)/.ipython/profile_stijn3/startup/01-magics.ipy
	ln -vsf $(BASE)/ipython/profile_stijn3/ipython_config.py $(HOME)/.ipython/profile_stijn3/ipython_config.py

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

all: tmux inputrc ipython matplotlib zsh
