#             _
#     _______| |__  _ __ ___
#    |_  / __| '_ \| '__/ __|
#   _ / /\__ \ | | | | | (__
#  (_)___|___/_| |_|_|  \___|
#

# -----------------------------------------------------------------------------
# Enviroment
# -----------------------------------------------------------------------------
export LANG=en_US.UTF-8
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# XDG Base Directories
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# Java Directories
# export JAVA_HOME=`echo $(dirname $(readlink $(readlink $(which java)))) | sed -e 's/\/bin$//g' | sed -e 's/\/jre$//g'`
# export JDK_HOME=`echo $(dirname $(readlink $(readlink $(which java)))) | sed -e 's/\/bin$//g' | sed -e 's/\/jre$//g'`

# 補完候補にls --colorsと同じ色をつける
export DIRCOLORTHEME='dircolors.ansi-light'
# Ctrl + s を無効化
stty stop undef

export EDITOR=nvim

# -----------------------------------------------------------------------------
# Source Prezto.
# -----------------------------------------------------------------------------
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# -----------------------------------------------------------------------------
# Plugin Import
# -----------------------------------------------------------------------------
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "b4b4r07/zsh-vimode-visual", defer:3
zplug "b4b4r07/enhancd", use:init.sh
zplug "liangguohuan/zsh-dircolors-solarized"

# Install plugins if there are plugins that have not been installe
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# Then, source plugins and add commands to $PATH
zplug load

setopt nonomatch

# zsh-users/zsh-autosuggestions の文字色
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=248'

# -----------------------------------------------------------------------------
# Color
# -----------------------------------------------------------------------------
# 色を使用出来るようにする
autoload -Uz colors
colors

# -----------------------------------------------------------------------------
# Key bind
# -----------------------------------------------------------------------------
# vi 風キーバインドにする
bindkey -v
# jjでノーマルモード
bindkey -M viins 'jj' vi-cmd-mode

# -----------------------------------------------------------------------------
# Theme and Prompt
# -----------------------------------------------------------------------------
VIM_MODE=$VIM_NORMAL

case ${OSTYPE} in
    darwin*)
        # for Mac
        #ZSH_THEME="powerlevel9k/powerlevel9k"
        #POWERLEVEL9K_MODE='nerdfont-complete'
        #POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir)
        #POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode time)

        VIM_NORMAL="%K{173}%F{238}⮀%f%k%K{173}%F{238} % NORMAL %f%k%K{238}%F{173}⮀%f%k"
        VIM_INSERT="%K{117}%F{238}⮀%f%k%K{117}%F{238} % INSERT %f%k%K{238}%F{117}⮀%f%k"

        # プロンプトに現在のモードを表示
        function zle-line-init zle-keymap-select {
            VIM_MODE="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
            PROMPT="
%K{245}%F{235} %n@%m %f%k%F{245}⮀%f%K{173}%F{238}⮀%f%k%K{173} %F{235}%T %k%F{173}⮀%f${VIM_MODE} %~
%# "
            zle reset-prompt
        }
        ;;

    linux*)
        # for WSL
        VIM_NORMAL="%K{173}%F{238}%f%k%K{173}%F{238} % NORMAL %f%k%K{238}%F{173}%f%k"
        VIM_INSERT="%K{117}%F{238}%f%k%K{117}%F{238} % INSERT %f%k%K{238}%F{117}%f%k"
        # プロンプトに現在のモードを表示
        function zle-line-init zle-keymap-select {
            VIM_MODE="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
            PROMPT="
%K{245}%F{235} %n@%m %f%k%F{245}%f%K{173}%F{238}%f%k%K{173} %F{235}%T %k%F{173}%f${VIM_MODE} %~
%# "
            zle reset-prompt
        }
        ;;
esac

zle -N zle-line-init
zle -N zle-keymap-select

# -----------------------------------------------------------------------------
# Git
# -----------------------------------------------------------------------------
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

# -----------------------------------------------------------------------------
# History
# -----------------------------------------------------------------------------
# 履歴ファイルの保存先
HISTFILE=~/.zsh_history
# メモリに保存される履歴の件数
HISTSIZE=1000000
# 履歴ファイルに保存される履歴の件数
SAVEHIST=1000000

# share .zshhistory
setopt inc_append_history
setopt share_history

# -----------------------------------------------------------------------------
# enhancd
# -----------------------------------------------------------------------------
export ENHANCD_FILTER=peco
export ENHANCD_DISABLE_DOT=1
export ENHANCD_DISABLE_HOME=1

# -----------------------------------------------------------------------------
# cdr
# -----------------------------------------------------------------------------
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

# cdrコマンドで履歴にないディレクトリにも移動可能に
zstyle ":chpwd:*" recent-dirs-max 500
zstyle ":chpwd:*" recent-dirs-default true
zstyle ":completion:*" recent-dirs-insert always

# -----------------------------------------------------------------------------
# Word separator
# -----------------------------------------------------------------------------
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# -----------------------------------------------------------------------------
# completion
# -----------------------------------------------------------------------------
autoload -U compinit
compinit
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# -----------------------------------------------------------------------------
# Options
# -----------------------------------------------------------------------------
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
# beep を無効にする
setopt no_beep
# フローコントロールを無効にする
setopt no_flow_control
# Ctrl+Dでzshを終了しない
setopt ignore_eof
# '#' 以降をコメントとして扱う
setopt interactive_comments
# ディレクトリ名だけでcdする
setopt auto_cd
# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
# 同時に起動したzshの間でヒストリを共有する
setopt share_history
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# 高機能なワイルドカード展開を使用する
setopt extended_glob

# -----------------------------------------------------------------------------
# Alias
# -----------------------------------------------------------------------------
alias la='ls -la'
alias lt='ls -ltr'
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias subl='subl -n'

# cd
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'

# config
alias dot='cd ~/dotfiles'
alias gconf='vim ~/.gitconfig'
alias vconf='vim ~/dotfiles/.vimrc'
alias zconf='vim ~/dotfiles/.zshrc'
alias tconf='vim ~/dotfiles/.tmux.conf'
alias tgconf='vim ~/dotfiles/.tigrc'
alias dconf='vim ~/.docker/config.json'

# git
alias g='git'
alias ga='git add'
alias gd='git diff'
alias gs='git status'
alias gc='git commit -m'
alias gpl='git pull'
alias gps='git push'

# ripgrep
alias rgg='rg -g'

# docker
alias dc='docker container'
alias di='docker image'

case ${OSTYPE} in
    linux*)
        #Linux用の設定
        alias c='cd /mnt/c'
        ;;
esac

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '
# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# -----------------------------------------------------------------------------
# Clip board
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
# -----------------------------------------------------------------------------
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

# -----------------------------------------------------------------------------
# neovim/ctags
# -----------------------------------------------------------------------------
if type "nvim" > /dev/null 2>&1; then
    alias vim=nvim
else
    alias vim=vim
fi

case ${OSTYPE} in
    darwin*)
        alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
        ;;
    linux*)
        #Linux用の設定
        alias ctags='/usr/bin/ctags'
        ;;
esac

# -----------------------------------------------------------------------------
# nvm/yarn
# -----------------------------------------------------------------------------
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

if type "yarn" > /dev/null 2>&1; then
    export PATH="$PATH:`yarn global bin`"
fi

# -----------------------------------------------------------------------------
# peco
# -----------------------------------------------------------------------------
#function peco-cdr() {
#    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
#    if [ -n "$selected_dir" ]; then
#        BUFFER="cd ${selected_dir}"
#        zle accept-line
#    fi
#    zle clear-screen
#}
#zle -N peco-cdr
#bindkey '^E' peco-cdr
#
#function peco-select-history() {
#     local tac
#     if which tac > /dev/null; then
#         tac="tac"
#     else
#         tac="tail -r"
#     fi
#     BUFFER=$(\history -n 1 | eval $tac | peco --query "$LBUFFER")
#     CURSOR=$#BUFFER
#     zle clear-screen
#}
#zle -N peco-select-history
#bindkey '^R' peco-select-history
#
#function peco-pkill() {
#    for pid in `ps aux | peco | awk '{ print $2 }'`
#    do
#        kill $pid
#        echo "Killed ${pid}"
#    done
#}
#alias pk="peco-pkill"

# -----------------------------------------------------------------------------
# fzf
# -----------------------------------------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="$PATH:$HOME/.fzf/bin"
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 50% --reverse '
export FZF_TMUX=1
export FZF_TMUX_OPTS="-p 80%"

alias ff="fzf"

# カレントディレクトリ以下のファイルをインクリメンタルサーチしてvimで開く
function fzf-fileOpen() {
selected_file=`fzf --query='' --multi --select-1 --exit-0 --preview 'bat --color=always {}' --preview-window=right,+3 --prompt='open file (Multiple selections in TAB key) > '` 
    [ -n "$selected_file" ] && vim `echo "${selected_file}" | tr '\n' ' '`
}
alias ffo="fzf-fileOpen"

# カレントディレクトリ以下のファイルをGrepしてvimで開く
function fzf-rg() {
    grep_cmd="rg --hidden --no-ignore --line-number --no-heading --invert-match '^\s*$' 2> /dev/null"
    read -r file line <<<"$(eval $grep_cmd | fzf --no-multi --select-1 --exit-0 --delimiter : --preview 'bat --color=always {1}' --preview-window=right,+{2}+3  --prompt='Grep to open file > ' | awk -F: '{print $1, $2}')"
    [ -n "$file" ] && vim `echo "$file" +"$line" | tr '\n' ' '`
}
alias ffg="fzf-rg"

# カレントディレクトリ以下のディレクトリをインクリメンタルサーチしてcdする
function fzf-cd() {
selected_dir=`find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf --no-multi --no-preview --prompt='cd (under the current directory) > '`
    [ -n "$selected_dir" ] && cd `echo "${selected_dir}" | tr '\n' ' '`
}
alias ffd="fzf-cd"

# cdrをインクリメンタルサーチしてcdする
function fzf-cdr() {
selected_dir=`cdr -l | awk '{ print $2 }' | fzf --no-multi --no-preview --prompt='cd (cdr) > '`
    [ -n "$selected_dir" ] && BUFFER="cd ${selected_dir}"; zle accept-line
#    zle clear-screen
}
zle -N fzf-cdr
bindkey '^E' fzf-cdr

# historyをインクリメンタルサーチして表示する
function fzf-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=`history -n 1 | eval $tac | fzf --no-multi --no-preview --prompt='history > '`
    CURSOR=$#BUFFER
#    zle clear-screen
}
zle -N fzf-select-history
bindkey '^R' fzf-select-history

# gitのbranchをインクリメンタルサーチして表示する
function fzf-git-switch() {
    selected_branch=$(
        git branch -a |
        fzf --exit-0 --info=hidden --no-multi --preview="echo {} | tr -d ' *' | xargs git log --color=always" --preview-window=right --prompt='git switch > '  |
        head -n 1 |
        perl -pe "s/\s//g; s/\*//g; s/remotes\/origin\///g"
    )
    [ -n "$selected_branch" ] && BUFFER="git switch $selected_branch";
#    zle clear-screen
}
zle -N fzf-git-switch
bindkey "^g" fzf-git-switch

# プロセスをインクリメンタルサーチしてkillする
function fzf-pkill() {
    for pid in `ps aux | fzf --no-multi --no-preview --prompt='Kill process > ' | awk '{ print $2 }'`
    do
        kill $pid
        echo "Killed ${pid}"
    done
}
alias ffk="fzf-pkill"

# -----------------------------------------------------------------------------
# OS 別の設定
# -----------------------------------------------------------------------------
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -la -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -la -F --color=auto'
        ;;
esac

# -----------------------------------------------------------------------------
# tmuxでssh接続時のタイトルリネーム
# -----------------------------------------------------------------------------
#function ssh() {
#    if [[ -n $(printenv TMUX) ]] ; then
#
#        # 現在のペインIDの退避と背景色の書き換え
#        local pane_id=$(echo `tmux display -p` | awk '{print $5}')
#        #tmux select-pane -P 'fg=colour5,bg=colour233'
#        tmux select-pane -T "$0 $*"
#
#        # 通常通りコマンド続行
#        command ssh $@
#        # デフォルトの色設定に戻す
#        tmux select-pane -t $pane_id -P 'default'
#
#    else
#        command ssh "$@"
#    fi
#}

function preexec_function() {
    if [[ -n $(printenv TMUX) ]] ; then
        mycmd=(${(s: :)${1}})
        tmux select-pane -T "$mycmd"
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec preexec_function

# -----------------------------------------------------------------------------
# VcXsrv
# -----------------------------------------------------------------------------
if [ -e /mnt/c/WINDOWS/System32/wsl.exe ]; then
#     export DISPLAY=`hostname`:0.0
     export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2}'):0.0
#     export DISPLAY=$(ipconfig.exe | awk 'BEGIN { RS="\r\n" } /^[A-Z]/ { isWslSection=/WSL/; }; { if (isWslSection && /IPv4/) { printf $NF; exit; }}'):0
fi

# -----------------------------------------------------------------------------
# alias
# -----------------------------------------------------------------------------
alias home='cd ~'

# ~/.zsh.d 配下の.zshファイルを読み込む
if [ -e /mnt/c/WINDOWS/System32/wsl.exe ]; then
    ZSHHOME="${HOME}/.zsh.d"
    if [ -d $ZSHHOME -a -r $ZSHHOME -a \
         -x $ZSHHOME ]; then
        for i in $ZSHHOME/*; do
            [[ ${i##*/} = *.zsh ]] &&
                [ \( -f $i -o -h $i \) -a -r $i ] && . $i
        done
    fi
fi

