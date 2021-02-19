uninstall:
    rm $(HOME)/.vimrc
    rm $(HOME)/.vim
    rm $(HOME)/.bash_profile
    rm $(HOME)/.zshrc
    rm $(HOME)/.zprofile
    rm $(HOME)/.tmux.conf
    rm $(HOME)/.tmux

install:
    ln -s $(CURDIR)/.vimrc $(HOME)/.vimrc
    ln -s $(CURDIR)/.vim $(HOME)/.vim
    ln -s $(CURDIR)/.bash_profile $(HOME)/.bash_profile
    ln -s $(CURDIR)/.zshrc $(HOME)/.zshrc
    ln -s $(CURDIR)/.zprofile $(HOME)/.zprofile
    ln -s $(CURDIR)/.tmux.conf $(HOME)/.tmux.conf
    ln -s $(CURDIR)/.tmux $(HOME)/.tmux
    ln -s $(CURDIR)/vim-ripgrep.vim $(pwd)/.vim/plugged/vim-ripgrep/vim-ripgrep.vim

