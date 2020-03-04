clear_all(){
    [ -d ~/.vim/ ] && mv ~/.vim ~/.vim_backup
    [ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.backup
    [ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.backup
    [ -f ~/.zshrc  ] && mv ~/.zshrc ~/.zshrc.backup
}

apt_run(){
    apt update  # update
    apt install htop  # install htop
    apt install vim  # install vim
    apt install autojump  # install autojump
    apt install zsh  # install zsh
}

check_git(){
    # gen key
    ssh-keygen -t rsa -C "im@kbyran.com"
    # set global config for git
    git config --global user.name "kbyran"
    git config --global user.email "im@kbyran.com"
}

check_vim(){
    [ -d ~/.vim/bundle/ ] || mkdir -p ~/.vim/bundle/
    [ -d ~/.vim/bundle/Vundle.vim/ ] || git clone https://github.com/VundleVim/Vundle.vim.git \
        ~/.vim/bundle/Vundle.vim
    [ -d ~/.vim/bundle/YouCompleteMe/ ] || \
        (git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe \
        --recursive && cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer && cd -)
    [ -d ~/.vim/colors ] || mkdir -p ~/.vim/colors/
    [ -f ~/.vim/colors/molokai.vim ] || cp molokai.vim ~/.vim/colors/molokai.vim
    [ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.backup
    cp vimrc ~/.vimrc
    vim +PluginInstall +qall
}

check_tmux(){
    [ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.backup
    cp tmux.conf ~/.tmux.conf
}

check_oh_my_zsh(){
    [ -d ~/.oh-my-zsh ] || \
        sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ] || \
        git clone https://github.com/zsh-users/zsh-autosuggestions \
        ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ] || \
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    [ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
    cp mytheme.zsh-theme ~/.oh-my-zsh/themes/mytheme.zsh-theme
    cp zshrc ~/.zshrc
    source ~/.zshrc
    # echo $SHELL  # bash as default
    # cat /etc/shells  # # shells avaliable
    # chsh -s /bin/zsh  # set zsh as default

}

install(){
    check_vim
    check_tmux
    check_oh_my_zsh
}

install
