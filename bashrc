#!/usr/bin/env bash

alias screenshot='import -window root ~/.screenshot.png; gimp ~/.screenshot.png'

if [ -d ~/bin ] ; then
   PATH=~/bin:"${PATH}"
fi
export JAVA_HOME=/opt/java/jdk1.7.0_10/
export MAVEN_HOME=/opt/apache/apache-maven-3.0.4/
export PIG_HOME=/home/carlos/programas/pig
export PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH:$PIG_HOME/bin

alias ec="~/programas/eclipse2/eclipse &"
alias sonar="~/programas/sonarqube-4.0/bin/linux-x86-64/sonar.sh"

export EDITOR="vim"
export VISUAL="vim"

PYTHONPATH="${PYTHONPATH}:$HOME/proyectos/github/utils27.py"

export PS1='\[\033[01;36m\]\u\[\033[01;37m\]@\h\[\033[01;35m\]\w\n\[\033[01;37m\]\$\[\033[01;00m\]'

set -o vi

# ----- Git stuff
function parse_git_branch {
  ref=$(/usr/lib/git-core/git-symbolic-ref HEAD 2> /dev/null) || return
  echo " ("${ref#refs/heads/}")"
}

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

git config --global color.branch auto
git config --global color.diff auto
git config --global color.status auto
git config --global color.ui auto

#PS1="\u@\h:\w\$(parse_git_branch)\$ "


# --- alternative
function git_dirty_state() {
    if [ $(__gitdir) ]; then
        [[ -n "$(git status --porcelain 2> /dev/null)" ]] && echo "✘" || echo "✔"
    fi
}

function parse_git_branch() {
    echo $(__git_ps1 "(%s|$(git_dirty_state) )") 
}

export PS1='\[\033[01;36m\]\u\[\033[01;37m\]@\h\[\033[01;35m\]\w\[\033[01;37m\]$(parse_git_branch)\n\$\[\033[01;00m\]'

