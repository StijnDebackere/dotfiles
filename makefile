BASE=$(PWD)

tmux:
	ln -vsf $(BASE)/tmux/.tmux.conf $(HOME)/.tmux.conf

inputrc:
	ln -vsf $(BASE)/.inputrc $(HOME)/.inputrc
