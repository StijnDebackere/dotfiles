BASE=$(PWD)

tmux:
	ln -vsf $(BASE)/tmux/.tmux.conf $(HOME)/.tmux.conf

inputrc:
	ln -vsf $(BASE)/.inputrc $(HOME)/.inputrc

ipython:
	mkdir -p $(HOME)/.ipython/profile_default/startup/
	ln -vsf $(BASE)/ipython/profile_stijn3/startup/00-autoload.py $(HOME)/.ipython/profile_default/startup/00-autoload.py
	ln -vsf $(BASE)/ipython/profile_stijn3/startup/01-magics.py $(HOME)/.ipython/profile_default/startup/01-magics.py
	ln -vsf $(BASE)/ipython/profile_stijn3/ipython_config.py $(HOME)/.ipython/profile_default/ipython_config.py
