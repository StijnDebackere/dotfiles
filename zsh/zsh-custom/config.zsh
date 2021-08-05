# If you come from bash you might have to change your $PATH.
export PATH="/usr/local/bin:/Applications/TOPCAT.app/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/Users/stijn/.oh-my-zsh"

# Mac finder apps set path
launchctl setenv PATH $PATH

# turn off Homebrew analytics
export HOMEBREW_NO_ANALYTICS=1

# link ruby to homebrew openSSL version
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# use cdr, see https://jlk.fjfi.cvut.cz/arch/manpages/man/zshcontrib.1#REMEMBERING_RECENT_DIRECTORIES
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# set up gpg-agent, no need to check if instance is already running
eval $(gpg-agent --daemon --quiet)

# Set GPG tty
export GPG_TTY=$(tty)
