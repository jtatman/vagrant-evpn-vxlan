#!/bin/bash

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# configure GOPATH
echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
echo 'export PATH=$GOPATH/bin:$PATH' >> $HOME/.bashrc

source $HOME/.bashrc


# install goplane, gobgp, gobgpd and its dependencies
go get github.com/spf13/cobra
go get github.com/kr/pretty
go get github.com/osrg/goplane

# setup goplane
cd $GOPATH/src/github.com/osrg/goplane; glide install

# install goplane
cd $GOPATH/src/github.com/osrg/goplane
go install github.com/osrg/goplane

exit
