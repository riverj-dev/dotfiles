#!/bin/bash

# .vimrc
# nvimが存在する場合はinit.vimとして配置
if type nvim > /dev/null 2>&1; then
    if [ ! -L $XDG_CONFIG_HOME/nvim/init.vim ]; then
        mkdir -p $XDG_CONFIG_HOME/nvim
        ln -s $HOME/dotfiles/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
        ln -s $HOME/dotfiles/dein.toml $XDG_CONFIG_HOME/nvim/dein.toml
    fi
else
    ln -s $HOME/dotfiles/$file $HOME/.vimrc
fi

# other dotfiles
DOT_FILES=(.zshrc .tmux.conf .tigrc .ctags)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

