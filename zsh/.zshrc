if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config ~/dotfiles/zsh/zen.toml)"
fi

ZSH_CUSTOM=$HOME/dotfiles/zsh/zsh-custom
# Load all of your custom configurations from custom/
for config_file ("$ZSH_CUSTOM"/*.zsh(N)); do
  source "$config_file"
done
unset config_file


# User configuration
# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8



# https://stackoverflow.com/q/57660263/76304995#76304995
function conda_deactivate_all() {
    while [ -n "$CONDA_PREFIX" ]; do
        conda deactivate;
    done
}
[[ -z $TMUX ]] || conda_deactivate_all; conda activate base

# ------------------------------------------------------------------------------
# use fuzzy finder for history search
# TODO: move CTRL-T cmd to other shortcut, want to keep CTRL-T for swapping chars
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ------------------------------------------------------------------------------
# use virtualenvwrapper
# need conda to be activated before we are able to use it to find executable.
if [[ -n "$CONDA_PREFIX" ]]; then
    if [[ ! -f "$CONDA_PREFIX/bin/virtualenvwrapper.sh" ]]; then
        echo "Installing virtualenvwrapper"
        pip install virtualenvwrapper==6.0.0.0a1
    fi
    export WORKON_HOME="~/.envs"
    mkdir -p ~/.envs
    source "$CONDA_PREFIX/bin/virtualenvwrapper.sh"
fi
