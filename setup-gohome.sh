#!/bin/bash

# configure GOPATH
echo 'export GOPATH=$HOME/.golang' >> $HOME/.bashrc
echo 'export PATH=$GOPATH/bin:$PATH' >> $HOME/.bashrc

source $HOME/.bashrc

export GOPATH=$HOME/.golang
export PATH=$GOPATH/bin:$PATH
