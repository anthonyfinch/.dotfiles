#!/usr/bin/env bash

sudo apt-get install vim git tmux python-dev python-pip ack-grep rubygems
sudo pip install virtualenv virtualenvwrapper 
sudo gem install tmuxinator

sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

stow bash
stow tmux

if [ ! -d "$WORKON_HOME" ]; then
	mkdir -p "$WORKON_HOME";
fi
