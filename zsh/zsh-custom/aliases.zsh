# function aliases
# eval `gdircolors ~/.dir_colors-solarized`
alias ls='gls --color=auto -F'
alias ll='ls --color=auto -ltrahF' # list all, reverse time sorted, human readable
alias py='python3'
alias jlab='jupyter lab'
alias ec="emacsclient -n -q"
alias ecf="emacsclient -n -q \$(find . '/' | fzf)"
alias sd="cd ~ && cd \$(find * -type d | fzf)"

export AWS_PROFILE="klar_swe_data"
export AWS_SM_INSTANCE_NAME="stijn-debackere"

# https://stackoverflow.com/a/77909650
aws_sso_login_if_invalid() {
    if aws --profile $AWS_PROFILE sts get-caller-identity >/dev/null 2>&1; then
    else
        echo "Invalid session: hence logging using SSO"
        aws sso login --profile $AWS_PROFILE
    fi
}

sm_start() {
    aws_sso_login_if_invalid
    aws sagemaker start-notebook-instance --notebook-instance-name $AWS_SM_INSTANCE_NAME --profile $AWS_PROFILE
    echo "Started SageMaker notebook instance $AWS_SM_INSTANCE_NAME"
    sm_status
}

sm_status() {
    aws_sso_login_if_invalid
    aws sagemaker list-notebook-instances | jq -r '.NotebookInstances[] | select(.NotebookInstanceName==$ENV.AWS_SM_INSTANCE_NAME)'
}

sm_stop() {
    aws_sso_login_if_invalid
    aws sagemaker stop-notebook-instance --notebook-instance-name $AWS_SM_INSTANCE_NAME --profile $AWS_PROFILE
    echo "Stopped SageMaker notebook instance $AWS_SM_INSTANCE_NAME"
    sm_status
}

sm() {
    aws_sso_login_if_invalid
    AWS_SM_JLAB_URL=$(aws sagemaker create-presigned-notebook-instance-url --notebook-instance-name $AWS_SM_INSTANCE_NAME | \
                          jq -r '.AuthorizedUrl | split("?authToken") | join("/lab?authToken")')
    open -a Firefox $AWS_SM_JLAB_URL
}

_choose_gh_user() {
    # set the prompt used by select, replacing "#?"
    PS3="Use number to select a user or 'stop' to cancel: "

    # allow the user to choose a file
    select usr in $(ls ~/.logins/gh-*.txt)
    do
        # leave the loop if the user says 'stop'
        if [[ "$REPLY" == stop ]]; then break; fi

        # complain if no file was selected, and loop to ask again
        if [[ "$usr" == "" ]]
        then
            echo "'$REPLY' is not a valid number"
            continue
        fi

        # now we can use the selected file
        echo "$usr"

        # it'll ask for another unless we leave the loop
        break
    done
}
gh_login() {
    usr=$(_choose_gh_user);
    gh auth login --with-token < $usr
}

# ipython aliases
# In iPython 5 you need %matplotlib magic for mpl to work correctly
# this can be called as ipython --matplotlib
# Rewrite as a function so we can provide arguments when calling scripts
# Also use profile stijn, which autoloads numpy and pyplot
ipy() {
    ipython3 $@ --matplotlib --profile=stijn3;
}
pyenv() {
    if [ ! -d "$PWD/.venv" ]
    then
        echo "Creating venv .venv"
        py -m venv .venv
        directory=${PWD##*/}             # to assign to a variable
        directory=${directory:-/}        # to correct for the case where PWD=/
        echo "Linking .venv to ${WORKON_HOME}/${directory}"
        ln -s ${PWD}/.venv ${WORKON_HOME}/${directory}
    fi
    source .venv/bin/activate;
}

# ssh aliases -> start up bash on server
ss() {
    ssh -t $1 'exec bash'
}
ssx() {
    ssh -tX $1 'exec bash'
}
_choose_tmux() {
    # set the prompt used by select, replacing "#?"
    PS3="Use number to select a tmux session or 'stop' to cancel: "

    # allow the user to choose a file
    select scr in $(tmux ls | grep -v attached | cut -f1 -d:)
    do
        # leave the loop if the user says 'stop'
        if [[ "$REPLY" == stop ]]; then break; fi

        # complain if no file was selected, and loop to ask again
        if [[ "$scr" == "" ]]
        then
            echo "'$REPLY' is not a valid number"
            continue
        fi

        # now we can use the selected file
        echo "$scr"

        # it'll ask for another unless we leave the loop
        break
    done
}
connect_tmux() {
    if [ -z "${TMUX}" ]; then
       scr=$(_choose_tmux)
       tmux new -As $scr
    fi
}
# find all forwarded ports and kill them
show_port_forwards () {
    # get pid and args for all ssh processes, match -L flag
    ps -axo pid,args | ag 'ssh -(\w*)(?(1)L)'
}
kill_port_forwards () {
    # get pid and args for all ssh processes, match -L flag
    # if main process is ssh, kill
    ps -axo pid,args | ag 'ssh -(\w*)(?(1)L)' | awk '{if($2 == "ssh") system("kill "$1)}'
}
