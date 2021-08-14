uninstall-old:
    rm $(HOME)/.vimrc
    rm $(HOME)/.vim
    rm $(HOME)/.bash_profile
    rm $(HOME)/.zshrc
    rm $(HOME)/.zprofile
    rm $(HOME)/.tmux.conf
    rm $(HOME)/.tmux
    rm $(HOME)/.yabairc
    rm $(HOME)/.skhdrc
    rm $(HOME)/.config/alacritty/alacritty.yml

install-old:
    ln -s $(CURDIR)/.vimrc $(HOME)/.vimrc
    ln -s $(CURDIR)/.vim $(HOME)/.vim
    ln -s $(CURDIR)/.bash_profile $(HOME)/.bash_profile
    ln -s $(CURDIR)/.zshrc $(HOME)/.zshrc
    ln -s $(CURDIR)/.zprofile $(HOME)/.zprofile
    ln -s $(CURDIR)/.tmux.conf $(HOME)/.tmux.conf
    ln -s $(CURDIR)/.tmux $(HOME)/.tmux
    ln -s $(CURDIR)/vim-ripgrep.vim $(pwd)/.vim/plugged/vim-ripgrep/vim-ripgrep.vim
	ln -s $(CURDIR)/.yabairc $(HOME)/.yabairc
	ln -s $(CURDIR)/.skhdrc $(HOME)/.skhdrc
	mkdir -p $(HOME)/.config/alacritty
	ln -s $(CURDIR)/alacritty.yml $(HOME)/.config/alacritty/alacritty.yml
	mkdir -p $(HOME)/.config/spacebar
	ln -s $(CURDIR)/spacebarrc $(HOME)/.config/spacebar/spacebarrc


uninstall:
	.bin/uninstall.bs

install:
	.bin/install.bs
