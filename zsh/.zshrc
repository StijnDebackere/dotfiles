# Start up oh-my-posh
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config ~/dotfiles/zsh/zen.toml)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME=$HOME/dotfiles/zsh/zinit

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light conda-incubator/conda-zsh-completion

# Add in snippets for oh-my-zsh plugins
zinit snippet OMZP::git
zinit snippet OMZP::aws
zinit snippet OMZP::command-not-found
# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Load custom configurations
ZSH_CUSTOM=$HOME/dotfiles/zsh/zsh-custom
# Load all of your custom configurations from custom/
for config_file ("$ZSH_CUSTOM"/*.zsh(N)); do
  source "$config_file"
done
unset config_file

# Set up conda environment
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/stijn/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/stijn/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/stijn/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/stijn/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
# --------------------------------------------------------------------------------
# TMUX has issues with getting the right conda env,
# automatically deactive all envs and active base when in TMUX
# ~> https://stackoverflow.com/q/57660263/76304995#76304995
function conda_deactivate_all() {
    while [ -n "$CONDA_PREFIX" ]; do
        conda deactivate;
    done
}
[[ -z $TMUX ]] || conda_deactivate_all; conda activate base

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
