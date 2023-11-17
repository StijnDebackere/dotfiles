export PATH="/usr/local/bin/:/usr/local/go/bin/:$HOME/go/bin/:$PATH"
# If you come from bash you might have to change your $PATH.
# export PATH="/usr/local/sbin:$PATH"
# export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
# export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
# export PATH="/usr/local/opt/openjdk/bin:$PATH"
# export PATH="/usr/local/opt/ed/bin:$PATH"
# export PATH="/usr/local/opt/python@3.10/bin:$PATH"

# Mac finder apps set path
launchctl setenv PATH $PATH

# turn off Homebrew analytics
export HOMEBREW_NO_ANALYTICS=1

# link ruby to homebrew openSSL version
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# use cdr, see https://jlk.fjfi.cvut.cz/arch/manpages/man/zshcontrib.1#REMEMBERING_RECENT_DIRECTORIES
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# start gpg-agent if no socket present yet, otherwise get gpg-agent already running
if [[ ! -a ~/.gnupg/S.gpg-agent ]]; then
    eval $(gpg-agent --daemon --quiet)
fi

# Set GPG tty
export GPG_TTY=$(tty)
