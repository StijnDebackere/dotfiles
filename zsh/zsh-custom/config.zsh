export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="/usr/local/bin/:/usr/local/go/bin/:$HOME/go/bin/:$PATH"

# Mac finder apps set path
launchctl setenv PATH $PATH

# turn off Homebrew analytics
export HOMEBREW_NO_ANALYTICS=1

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
FZF_CTRL_T_COMMAND= source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"

# use cdr, see https://jlk.fjfi.cvut.cz/arch/manpages/man/zshcontrib.1#REMEMBERING_RECENT_DIRECTORIES
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# ------------------------------------------------------------------------------
# GPG settings
# start gpg-agent if no socket present yet, otherwise get gpg-agent already running
if [[ ! -a ~/.gnupg/S.gpg-agent ]]; then
    eval $(gpg-agent --daemon --quiet)
fi

# Set GPG tty
export GPG_TTY=$(tty)

# ------------------------------------------------------------------------------
# Ruby settings
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"

# link ruby to homebrew openSSL version
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# ruby set-up following https://jekyllrb.com/docs/installation/macos/
# https://stackoverflow.com/a/77241882
source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
source $(brew --prefix)/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3 # run 'chruby' to see actual version
