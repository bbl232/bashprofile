default: all

all: install

install: .bashrc .bash_profile .inputrc
	cp .bashrc ~/.bashrc
	cp .bash_profile ~/.bash_profile
	cp .inputrc ~/.inputrc
	cp .ssh ~/.ssh
