#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

parse_conda_env() {
    if [ ! -z "$CONDA_DEFAULT_ENV" ]
    then
        echo "<$(basename "$CONDA_DEFAULT_ENV")> "
    fi
}

YELLOW="\[\033[0;33m\]"
WHITE="\[\e[00m\]"

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}
export OLD_PS1="\u@\h \[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "
export PS1="\[\e[32m\]\W \[\e[91m\]\$(parse_git_branch)$YELLOW>$WHITE "

setup_python() {
    source "${HOME}/.conda/etc/profile.d/conda.sh"
    conda activate
}

setup_rust() {
    . "$HOME/.cargo/env"
}

setup_go() {
    export GOPATH=/usr/local/go
    export PATH=$PATH:$GOPATH/bin
}

setup_python
setup_rust
setup_go
