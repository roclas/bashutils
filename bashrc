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

export EDITOR="vim"
export VISUAL="vim"

PYTHONPATH="${PYTHONPATH}:$HOME/proyectos/github/utils27.py"

export PS1='\[\033[01;36m\]\u\[\033[01;37m\]@\h\[\033[01;35m\]\w\n\[\033[01;37m\]\$\[\033[01;00m\]'

set -o vi
