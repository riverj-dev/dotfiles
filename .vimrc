"         _
"  __   _(_)_ __ ___
"  \ \ / / | '_ ` _ \ 
"   \ V /| | | | | | |
"    \_/ |_|_| |_| |_|
"
" :source ~/.vimrc

" -----------------------------------------------------------------------------
" 基本設定
" -----------------------------------------------------------------------------
" デフォルト文字コードをUTF-8に設定
set enc=utf-8
" ファイルエンコーディングをUTF-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" マウス操作を有効にする
set mouse=a
" クリップボードを有効にする
set clipboard^=unnamedplus
" 256色対応
set t_Co=256
" Remove all vimrc autocommands
augroup vimrc
    autocmd!
augroup END
" インサートモードに入る時に自動でコメントアウトされないようにする
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" leader をスペースに割当て
let mapleader = "\<Space>"

" -----------------------------------------------------------------------------
" 画面表示設定
" -----------------------------------------------------------------------------
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の列を強調表示
set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" 自動的に改行が入るのを無効化
set textwidth=0
" 80文字目にラインを入れる
set colorcolumn=80
" スマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" ダブルバイト文字の崩れ防止
set ambiwidth=double
" スクロール送り開始行数
set scrolloff=10
" 補完メニューの高さを指定
set pumheight=10

" -----------------------------------------------------------------------------
" タブ文c設定
" -----------------------------------------------------------------------------
" タブ文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4
" 不可視文字を可視化(タブが「>-」と表示される)
set list listchars=tab:\>\-

" -----------------------------------------------------------------------------
" 検索設定
" -----------------------------------------------------------------------------
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" vim grepすると自動的にあたらしいウィンドウで検索結果一覧を表示する
autocmd QuickFixCmdPost *grep* cwindow
set modifiable
set write

" -----------------------------------------------------------------------------
" キーバインド（ノーマルモード）
" -----------------------------------------------------------------------------
" 行頭・行末へのカーソル移動
noremap <leader>h 0
noremap <leader>l $
" 検索語が画面の真ん中に来るようにする
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" Yキーでカーソル位置から行末までヤンク
nnoremap Y y$
" ypキーでヤンクレジスタの文字列をペースト
noremap yp "0P
" cpキーで無名レジスタの文字列をペースト
noremap cp ""P
" cオペレータをヤンクしない
nnoremap c "_c
" Ctrl-sでスペースを挿入
noremap <C-s> i<Space><ESC>
" Ctrl-mで直前のヤンクの末尾に移動
nmap <C-m> `]
" leader + r で置換
nnoremap <silent> <leader>r :%s///g<Left><Left><Left>
" カーソル下の単語をハイライトする
nnoremap <silent> <leader><leader> "zyiw:let @/='\<' . @z . '\>'<CR>:set hlsearch<CR>
" カーソル下の単語をハイライトしてから置換する
nmap # <Space><Space> :%s/<C-r>///g<Left><Left>

" -----------------------------------------------------------------------------
" キーバインド（ウィンドウ（ペイン）操作）
" -----------------------------------------------------------------------------
" ウィンドウ間移動
nnoremap <left>   <C-w>h
nnoremap <right>  <C-w>l
nnoremap <up>     <C-w>k
nnoremap <down>   <C-w>j

" 水平分割
nnoremap ss :<C-u>sp<CR>
" 垂直分割
nnoremap sv :<C-u>vs<CR>
" ウィンドウを閉じる
nnoremap sq :<C-u>q<CR>
" バッファを閉じる
nnoremap sQ :<C-u>bd<CR>
" 左に移動
nnoremap sh <C-w>h
" 下に移動
nnoremap sj <C-w>j
" 上に移動
nnoremap sk <C-w>k
" 右に移動
nnoremap sl <C-w>l

"タブ操作
" 新規タブ
nnoremap st :<C-u>tabnew<CR>
" 次のタブに切替
nnoremap sn gt
" 水前のタブに切替平分割
nnoremap sp gT
" タブ移動（前のタブ）
nnoremap gr :tabprevious<CR>

" NERDTreeのキーマップを変更
augroup myvimrc
    autocmd!
augroup END
autocmd myvimrc filetype nerdtree nnoremap sh <C-w>h
autocmd myvimrc filetype nerdtree nnoremap sl <C-w>l

" -----------------------------------------------------------------------------
" キーバインド（インサートモード）
" -----------------------------------------------------------------------------
" jjでエスケープ
inoremap <silent> jj <ESC>
" 日本語入力時のjjでエスケープ
inoremap <silent> ｊｊ <ESC>
inoremap <silent> っｊ <ESC>
" 入力モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
" 括弧補完
inoremap "<Enter> ""<left>
inoremap '<Enter> ''<left>
inoremap (<Enter> ()<Left>
inoremap [<Enter> []<Left>
inoremap {<Enter> {}<Left>

" QuickFixのみの場合自動で閉じる
augroup QfAutoCommands
    autocmd!
    " Auto-close quickfix window
    autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif
augroup END

if ((has('nvim') || has('timers') || v:version >= 800) && has('python3'))
    if !&compatible
        set nocompatible
    endif

    " reset augroup
    augroup MyAutoCmd
        autocmd!
    augroup END

    " dein settings {{{
    " -----------------------------------------------------------------------------
    " プラグイン管理にdein.vimを利用する
    " -----------------------------------------------------------------------------
    " Plugin directory
    let s:dein_dir=expand($XDG_CACHE_HOME . '/dein')
    " dein.vim 本体
    let s:dein_repo_dir=expand(s:dein_dir . '/repos/github.com/Shougo/dein.vim')

    " dein.vim がなければ git clone
    if &runtimepath !~# '/dein.vim'
        if !isdirectory(s:dein_repo_dir)
            execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
        endif
        execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
    endif

    let s:toml_file = expand($XDG_CONFIG_HOME . '/nvim/dein.toml')

    " 設定開始
    if dein#load_state(s:dein_dir)

        call dein#begin(s:dein_dir)

        call dein#add('Shougo/dein.vim')
        call dein#add('Shougo/neomru.vim')
        call dein#add('Shougo/neoyank.vim')

        " denite
        call dein#add('Shougo/denite.nvim')
        " defx
"        call dein#add('Shougo/defx.nvim')

        " deoplete
        if ((has('nvim') || has('timers')) && has('python3')) && system('pip3 show neovim') !=# ''
"            call dein#add('Shougo/deoplete.nvim')
        elseif has('lua')
            call dein#add('Shougo/neocomplete.vim')
        endif

        " neovimではない場合に必要なプラグイン
        if !has('nvim')
            call dein#add('roxma/nvim-yarp')
            call dein#add('roxma/vim-hug-neovim-rpc')
        endif

        call dein#add('Yggdroot/indentLine')
        call dein#add('itchyny/lightline.vim')
        call dein#add('hail2u/vim-css3-syntax')
        call dein#add('bronson/vim-trailing-whitespace')
        call dein#add('tpope/vim-surround')
        call dein#add('kana/vim-operator-user')
        call dein#add('kana/vim-operator-replace')
        call dein#add('machakann/vim-highlightedyank')
        call dein#add('simeji/winresizer')
        call dein#add('vim-scripts/taglist.vim')
        call dein#add('unblevable/quick-scope')
"        call dein#add('rhysd/clever-f.vim')
        call dein#add('easymotion/vim-easymotion')
        call dein#add('ConradIrwin/vim-bracketed-paste')
        call dein#add('elzr/vim-json')
        call dein#add('szw/vim-tags')
        call dein#add('dense-analysis/ale')
        call dein#add('junegunn/fzf', {'build': './install --all'})
        call dein#add('junegunn/fzf.vim')
        call dein#add('jremmen/vim-ripgrep')
        call dein#add('tpope/vim-fugitive')
        call dein#add('voldikss/vim-floaterm')

        call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release' })

"        call dein#add('ctrlpvim/ctrlp.vim')
        call dein#add('preservim/nerdtree')
        call dein#add('jistr/vim-nerdtree-tabs')

        " color scheme
        call dein#load_toml(s:toml_file)

        " 設定終了
        call dein#end()
        call dein#save_state()

    endif

    " 未インストールものがあったらインストール
    if dein#check_install()
        call dein#install()
    endif

    call map(dein#check_clean(), "delete(v:val, 'rf')")
    call dein#recache_runtimepath()

    " }}}

    " -----------------------------------------------------------------------------
    " キーバインド（Plugin周り）
    " -----------------------------------------------------------------------------
    " Space-n defxの表示
"    nnoremap <silent> <leader>n :<C-u>Defx `escape(expand('%:p:h'), ' :')` -search=`expand('%:p')` <CR>

"    call defx#custom#option('_', {
"                \ 'winwidth': 40,
"                \ 'split': 'vertical',
"                \ 'direction': 'topleft',
"                \ 'show_ignored_files': 1,
"                \ 'auto_cd':1,
"                \ 'focus':0,
"                \ 'toggle': 1,
"                \ 'resume': 1,
"                \ })
"
"    autocmd FileType defx call s:defx_my_settings()
"
"    function! s:defx_my_settings() abort
"        nnoremap <silent><buffer><expr> <CR>
"                    \ defx#is_directory() ? 
"                    \ defx#is_opened_tree() ? defx#do_action('close_tree') : defx#do_action('open_tree') :
"                    \ defx#do_action('multi', [['open', 'tab drop'], 'drop'])
"        nnoremap <silent><buffer><expr> o
"                    \ defx#is_directory() ? 
"                    \ defx#is_opened_tree() ? defx#do_action('close_tree') : defx#do_action('open_tree') :
"                    \ defx#do_action('multi', [['open', 'tab drop'], 'drop'])
"        nnoremap <silent><buffer><expr> q
"                    \ defx#do_action('quit')
"        nnoremap <silent><buffer><expr> ..
"                    \ defx#do_action('cd', ['..'])
"        nnoremap <silent><buffer><expr><nowait> t
"                    \ defx#do_action('multi', [['open', 'tab drop'], 'drop'])
"        nnoremap <silent><buffer><expr> c
"                    \ defx#do_action('copy')
"        nnoremap <silent><buffer><expr> p
"                    \ defx#do_action('paste')
"        nnoremap <silent><buffer><expr> d
"                    \ defx#do_action('remove')
"        nnoremap <silent><buffer><expr> r
"                    \ defx#do_action('rename')
"        nnoremap <silent><buffer><expr> m
"                    \ defx#do_action('move')
"        nnoremap <silent><buffer><expr> n
"                    \ defx#do_action('new_file')
"        nnoremap <silent><buffer><expr> N
"                    \ defx#do_action('new_directory')
"        nnoremap <silent><buffer><expr> yy
"                    \ defx#do_action('yank_path')
"    endfunction

    " <leader>-uX Denite用キーバインド
    " カレントディレクトリとバッファを表示
    nnoremap <silent><leader>ud  :<C-u>Denite file buffer <CR>
    " バッファを表示
    nnoremap <silent><leader>ub   :<C-u>Denite buffer <CR>
    " カレントディレクトリ以下を再帰的に表示
    nnoremap <silent><leader>uf  :<C-u>Denite file/rec <CR>
    " カレントディレクトリ以下のファイルから指定した文字列を検索
    nnoremap <silent><leader>ug  :<C-u>Denite grep -buffer-name=search<CR>
    " カレントディレクトリ以下のファイルからカーソル下の文字列を検索
    nnoremap <silent><leader>u,   :<C-u>DeniteCursorWord grep -buffer-name=search line<CR>
    " grepした結果を再表示
    nnoremap <silent><leader>ugs  :<C-u>Denite -resume -buffer-name=search<CR>
    " Neovim内で実行したコマンドを表示
    nnoremap <silent><leader>uc   :<C-u>Denite command_history<CR>
    " 最近開いたファイルを表示
    nnoremap <silent><leader>uh   :<C-u>Denite file_mru buffer<CR>
    " レジストリを表示
    nnoremap <silent><leader>ur   :<C-u>Denite register<CR>
    " マークを表示
    nnoremap <silent><leader>um   :<C-u>Denite mark<CR>

    augroup NormalFloatBG
        autocmd!
        autocmd FileType denite highlight NormalFloat ctermfg=250 ctermbg=24
        "  autocmd FileType denite set winblend=10
        "  autocmd FileType denite highlight CursorLine ctermfg=100 ctermbg=7
    augroup END

    autocmd FileType denite call s:denite_my_settings()
    function! s:denite_my_settings() abort
        nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
        " 【o】 ファイルを開く
        nnoremap <silent><buffer><expr> o denite#do_map('do_action')
        " 【t】 ファイルをタブで開く
        nnoremap <silent><buffer><expr> t denite#do_map('do_action', 'tabopen')
        " 【s】 ウィンドウを水平分割してファイルを開く
        nnoremap <silent><buffer><expr> s denite#do_map('do_action', 'split')
        " 【v】 ウィンドウを垂直分割してファイルを開く
        nnoremap <silent><buffer><expr> v denite#do_map('do_action', 'vsplit')
        " 【d】 ファイルを削除する
        nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
        " 【p】 ファイルをプレビュー画面で開く
        nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
        " 【ESC】 / 【q】 denite.nvimを終了する
        nnoremap <silent><buffer><expr> <Esc> denite#do_map('quit')
        nnoremap <silent><buffer><expr> <C-[> denite#do_map('quit')
        nnoremap <silent><buffer><expr> q     denite#do_map('quit')
        " 【i】 ファイル名で検索する
        nnoremap <silent><buffer><expr> i  denite#do_map('open_filter_buffer')
        " 【SPACE】 ファイルを複数選択する
        nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
    endfunction

    let s:denite_win_width_percent = 0.85
    let s:denite_win_height_percent = 0.4
    let s:denite_default_options = {
                \ 'split': 'horizontal',
                \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
                \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
                \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
                \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
                \ 'highlight-window-background': 'NormalFloat',
                \ 'prompt': '$ ',
                \ 'start_filter': v:false,
                \ }
"    call denite#custom#option('default', s:denite_default_options)

    " deoplete用設定
    let g:deoplete#enable_at_startup=1

else

    " -----------------------------------------------------------------------------
    " プラグイン管理にNeoBundleを利用する
    " -----------------------------------------------------------------------------
    " プラグインが実際にインストールされるディレクトリ
    let s:neobundle_dir=expand('~/.vim/bundle')

    " NeoBundle.vim 本体
    let s:neobundle_repo_dir=s:neobundle_dir . '/neobundle.vim'

    " neobunle.vim がなければ git clone
    if &runtimepath !~# '/neobundle.vim'
        if !isdirectory(s:neobundle_dir)
            execute '!git clone git://github.com/Shougo/neobundle.vim' s:neobundle_repo_dir
        endif
        execute 'set runtimepath^=' . fnamemodify(s:neobundle_repo_dir, ':p')
    endif

    call neobundle#begin(s:neobundle_dir)

    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/neomru.vim'
    NeoBundle 'Shougo/neoyank.vim'
    if has('lua')
        NeoBundle 'Shougo/neocomplete.vim'
    endif
    NeoBundle 'Yggdroot/indentLine'
    NeoBundle 'itchyny/lightline.vim'
    NeoBundle 'hail2u/vim-css3-syntax'
    NeoBundle 'bronson/vim-trailing-whitespace'
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'ujihisa/unite-colorscheme'
    NeoBundle 'scrooloose/nerdtree'
    NeoBundle 'kana/vim-operator-user'
    NeoBundle 'kana/vim-operator-replace'
    NeoBundle 'machakann/vim-highlightedyank'
    NeoBundle 'simeji/winresizer'
    NeoBundle 'vim-scripts/taglist.vim'
    NeoBundle 'easymotion/vim-easymotion'
    NeoBundle 'ConradIrwin/vim-bracketed-paste'
    NeoBundle 'elzr/vim-json'
    NeoBundle 'jistr/vim-nerdtree-tabs'
    NeoBundle 'szw/vim-tags'
    NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    NeoBundle 'junegunn/fzf.vim'

    " color scheme
    NeoBundle 'altercation/vim-colors-solarized'
    NeoBundle 'croaker/mustang-vim'
    NeoBundle 'nanotech/jellybeans.vim'
    NeoBundle 'tomasr/molokai'
    NeoBundle 'raphamorim/lucario'

    " 設定終了
    call neobundle#end()

    " leader-uX Unite用キーバインド
    " カレントディレクトリとバッファを表示
    nnoremap <silent><leader>ufb  :<C-u>Unite file buffer <CR>
    " バッファを表示
    nnoremap <silent><leader>ub   :<C-u>Unite buffer <CR>
    " カレントディレクトリ以下を再帰的に表示
    nnoremap <silent><leader>uf  :<C-u>Unite file_rec <CR>
    " カレントディレクトリ以下のファイルから指定した文字列を検索
    nnoremap <silent><leader>ugr  :<C-u>Unite grep -buffer-name=search<CR>
    " grepした結果を再表示
    nnoremap <silent><leader>ugs  :<C-u>Unite -resume -buffer-name=search<CR>
    " 最近開いたファイルを表示
    nnoremap <silent><leader>um   :<C-u>Unite file_mru buffer<CR>
    " レジストリを表示
    nnoremap <silent><leader>ur   :<C-u>Unite register<CR>

    " Unite用設定
    "let g:unite_enable_start_insert=1
    let g:unite_source_file_mru_limit=200

    " 未インストールものがあったらインストール
    NeoBundleCheck

    " theme
    colorscheme lucario

endif

" leader-t Taglist用キーバインド
nnoremap <silent> <leader>t :TlistOpen<CR>

" leader-j/k/s easy motion用キーバインド
map  <leader>, <Plug>(easymotion-prefix)
map  <leader>j <Plug>(easymotion-j)
map  <leader>k <Plug>(easymotion-k)
nmap <leader>s <Plug>(easymotion-s2)
xmap <leader>s <Plug>(easymotion-s2)

" ヤンクした文字列をハイライトする
if !exists('##TextYankPost')
    map y <Plug>(highlightedyank)
endif

" lightline用設定
" let g:lightline={ 'colorscheme': 'PaperColor_light' }

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'absolutepath', 'modified', 'gitbranch'  ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" indentLine用設定
let g:indentLine_color_gui='#ffffff'

" NERDTree用設定
" 隠しファイルをデフォルトで表示
let NERDTreeShowHidden=1
" 横幅を設定
let NERDTreeWinSize=36
" Space-n NERDTreeの表示
nmap <leader>n <plug>NERDTreeTabsToggle<CR>

" 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-nerdtree-tabs用設定
let g:nerdtree_tabs_open_on_console_startup=1
lef g:nerdtree_tabs_synchronize_view=0
lef g:nerdtree_tabs_synchronize_focus=1
let g:nerdtree_tabs_startup_cd=0
let g:nerdtree_tabs_autofind=1

" vim-highlightedyank用設定
let g:highlightedyank_highlight_duration=250
autocmd ColorScheme * hi HighlightedyankRegion term=bold ctermfg=0 ctermbg=195 guifg=#000000 guibg=#FFCDD2

" vim-operator-replace用設定
nmap R <Plug>(operator-replace)

" simeji/winresizer用設定
let g:winresizer_vert_resize=1
let g:winresizer_horiz_resize=1

" taglist用設定
if has('mac')
    let Tlist_Ctags_Cmd='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
    set tags=tags
elseif has('unix')
    let Tlist_Ctags_Cmd='/usr/bin/ctags'
    set tags=tags
endif

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1

" coc.nvim用設定
" let g:node_client_debug = 1

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" easy motion用設定
let g:EasyMotion_do_mapping=0
let g:EasyMotion_smartcase=1
let g:EasyMotion_startofline=0
let g:EasyMotion_keys='ABCDEGHIJKLMNOPQRSTUVWXYZ,.;1234567890F'
let g:EasyMotion_use_upper=1
let g:EasyMotion_enter_jump_first=1
let g:EasyMotion_space_jump_first=1

" fzf用設定
let g:fzf_command_prefix = 'Fzf'
nnoremap <leader>fb :FzfBuffers<CR>
" nnoremap <leader>fg :FzfRg<Space>
nnoremap <leader>ff :FzfFiles<CR>
nnoremap <leader>fs :FzfHistory/<CR>
nnoremap <leader>fh :FzfHistory<CR>
nnoremap <leader>fc :FzfHistory:<CR>

set runtimepath+=~/.zplug/bin/fzf

function! FZGrep(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call FZGrep(<q-args>, <bang>0)
nnoremap <leader>fg :RG<CR>

let $FZF_DEFAULT_OPTS="--layout=reverse --info=inline"
let g:fzf_layout = {
            \ 'window': {
            \     'width': 0.64,
            \     'height': 0.48,
            \     'highlight': 'Identifier',
            \     'border': 'rounded'
            \ }
            \ }
let g:fzf_layout = { 'down': '30%' }

" CtrlP用設定
"let g:ctrlp_map = '<c-p>'

" JSONでダブルクォーテーションを表示
set conceallevel=0
let g:vim_json_syntax_conceal=0

" ファイルタイプ別のVimプラグイン/インデントを有効にする
filetype plugin indent on

" vim-fugitive用設定
nnoremap <leader>gd :Git diff<CR>
nnoremap <leader>gs :Gdiffsplit<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>ga :Gwrite<CR>

" vim-floaterm用設定
let g:floaterm_wintype = 'split'
let g:floaterm_autoclose = 2
let g:floaterm_height = 0.3
let g:floaterm_width = 0.8

nnoremap <leader>jc :FloatermNew<CR>
tnoremap <leader>jc <C-\><C-n>:FloatermNew<CR>
nnoremap <leader>jj :FloatermToggle<CR>
tnoremap <leader>jj <C-\><C-n>:FloatermToggle<CR>
nnoremap <leader>jp :FloatermPrev<CR>
tnoremap <leader>jp <C-\><C-n>:FloatermPrev<CR>
nnoremap <leader>jn :FloatermNext<CR>
tnoremap <leader>jn <C-\><C-n>:FloatermNext<CR>

" clever-f用設定
"" 行を跨いで検索しない
"let g:clever_f_across_no_line = 1
"" 大文字を入力した時のみ大文字小文字を区別
"let g:clever_f_smart_case = 1
"" ローマ字の入力で日本語を検索
"let g:clever_f_use_migemo = 1

" -----------------------------------------------------------------------------
" WSL用設定
" -----------------------------------------------------------------------------
"if stridx(system('uname -a'), 'Microsoft') > 0
"    augroup Yank
"      autocmd!
"      autocmd TextYankPost * :call system('win32yank.exe -i', @")
"    augroup END
"endif

