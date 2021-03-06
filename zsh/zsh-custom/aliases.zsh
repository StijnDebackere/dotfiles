# ssh aliases -> start up bash on server
ss() {
    ssh -t $1 'exec bash'
}
ssx() {
    ssh -tX $1 'exec bash'
}
choose_screen() {
    # set the prompt used by select, replacing "#?"
    PS3="Use number to select a screen or 'stop' to cancel: "

    # allow the user to choose a file
    select scr in $(ls /var/run/screen/S-debackere)
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
choose_tmux() {
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
connect_screen() {
    if [ "$TERM" = "screen" ]; then
       scr=$(choose_screen)
       screen -dRU $scr
    fi
}
connect_tmux() {
    if [ -z "${TMUX}" ]; then
       scr=$(choose_tmux)
       tmux new -As $scr
    fi
}

# ipython aliases
# In iPython 5 you need %matplotlib magic for mpl to work correctly
# this can be called as ipython --matplotlib
# Rewrite as a function so we can provide arguments when calling scripts
# Also use profile stijn, which autoloads numpy and pyplot
# function ipy2() {
#     ipython2 $@ --matplotlib --profile=stijn2;
# }
ipy() {
    ipython3 $@ --matplotlib --profile=stijn3;
}
jlab(){
    jupyter lab
}

# # set up port forwards
# function enable_port_forwards () {
#     for port in $@
#     do
#         ssh -NfL $port:localhost:$port purmer
#     done
# }

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

# PhD variables
export phd=~/Documents/PhD/
export papers=~/Documents/papers/
export projects=~/Documents/PhD/projects/

# function aliases
eval `gdircolors ~/.dir_colors-solarized`
alias ls='gls --color=auto -F'
alias ll='ls --color=auto -ltrahF' # list all, reverse time sorted, human readable
