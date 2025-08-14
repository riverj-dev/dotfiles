--
--            ________    ___      ___  ___   _____ ______
--           |\   ___  \ |\  \    /  /||\  \ |\   _ \  _   \
--           \ \  \\ \  \\ \  \  /  / /\ \  \\ \  \\\__\ \  \
--            \ \  \\ \  \\ \  \/  / /  \ \  \\ \  \\|__| \  \
--             \ \  \\ \  \\ \    / /    \ \  \\ \  \    \ \  \ 
--              \ \__\\ \__\\ \__/ /      \ \__\\ \__\    \ \__\
--               \|__| \|__| \|__|/        \|__| \|__|     \|__|
--
-- -----------------------------------------------------------------------------
-- 基本設定
-- -----------------------------------------------------------------------------
-- デフォルト文字コードをUTF-8に設定
vim.opt.enc = 'utf-8'
-- ファイルエンコーディングをUTF-8に設定
vim.opt.fenc = 'utf-8'
-- バックアップファイルを作らない
vim.opt.backup = false
-- スワップファイルを作らない
vim.opt.swapfile = false
-- 編集中のファイルが変更されたら自動で読み直す
vim.opt.autoread = true
-- バッファを変更可能とする
vim.opt.modifiable = true
-- ファイルの書き込み可能とする
vim.opt.write = true
-- バッファが編集中でもその他のファイルを開けるように
vim.opt.hidden = true
-- 入力中のコマンドをステータスに表示する
vim.opt.showcmd = true
-- マウス操作を有効にする
vim.opt.mouse = 'a'
-- leader をスペースに割当て
vim.g.mapleader = ' '
-- JSONでダブルクォーテーションを表示
vim.opt.conceallevel = 0
vim.g.vim_json_syntax_conceal = 0
-- ファイルタイプ別のVimプラグイン/インデントを有効にする
vim.opt.filetype = 'plugin', 'indent', 'on'
-- オートコマンド初期化
vim.api.nvim_create_augroup( 'vimrc', {} )
-- インサートモードに入る時に自動でコメントアウトされないようにする
vim.api.nvim_create_autocmd( 'FileType', {
  group = 'vimrc',
  command = 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
})
-- QuickFixのみの場合自動で閉じる
vim.api.nvim_create_autocmd( 'WinEnter', {
  group = 'vimrc',
  command = "if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif"
})
-- クリップボードを有効にする
vim.opt.clipboard:append{'unnamedplus'}
if vim.fn.has('wsl') == 1 then
    vim.g.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = 'xsel -bi',
            ['*'] = 'xsel -bi',
        },
        paste = {
            ['+'] = 'xsel -bo',
            ['*'] = function() return vim.fn.systemlist('xsel -bo | tr -d "\r"') end,
        },
        cache_enabled = 1,
    }
end

-- -----------------------------------------------------------------------------
-- 画面表示設定
-- -----------------------------------------------------------------------------
-- 行番号を表示
vim.wo.number = true
-- 現在の行を強調表示
vim.opt.cursorline = true
-- 現在の列を強調表示
vim.opt.cursorcolumn = true
-- 行末の1文字先までカーソルを移動できるように
vim.opt.virtualedit = 'onemore'
-- 自動的に改行が入るのを無効化
vim.opt.textwidth = 0
-- 80文字目にラインを入れる
vim.opt.colorcolumn = '80'
-- スマートインデント
vim.opt.smartindent = true
-- ビープ音を可視化
vim.opt.visualbell = true
-- 括弧入力時の対応する括弧を表示
vim.opt.showmatch = true
-- ステータスラインを常に表示
vim.opt.laststatus = 2
-- コマンドラインの補完
vim.opt.wildmode = 'list:longest'
--行数表示の横に余白を追加
-- vim.opt.signcolumn = 'yes'
-- ダブルバイト文字の崩れ防止
-- vim.opt.ambiwidth = 'double'
-- スクロール送り開始行数
vim.opt.scrolloff = 10
-- 補完メニューの高さを指定
vim.opt.pumheight = 10
-- 256色対応
vim.opt.winblend = 20
vim.opt.pumblend = 20
vim.opt.termguicolors=true

-- -----------------------------------------------------------------------------
-- タブ文字設定
-- -----------------------------------------------------------------------------
-- タブ文字を半角スペースにする
vim.opt.expandtab = true
-- 行頭以外のTab文字の表示幅
vim.opt.tabstop = 4
-- 行頭でのTab文字の表示幅
vim.opt.shiftwidth = 4
-- 不可視文字を可視化(タブが「>-」と表示される)
vim.opt.listchars = {tab='>-'}

-- -----------------------------------------------------------------------------
-- 検索設定
-- -----------------------------------------------------------------------------
-- 検索文字列が小文字の場合は大文字小文字を区別なく検索する
vim.opt.ignorecase = true
-- 検索文字列に大文字が含まれている場合は区別して検索する
vim.opt.smartcase = true
-- 検索文字列入力時に順次対象文字列にヒットさせる
vim.opt.incsearch = true
-- 検索時に最後まで行ったら最初に戻る
vim.opt.wrapscan = true
-- 検索語をハイライト表示する
vim.opt.hlsearch = true
-- vimgrepすると自動的にあたらしいウィンドウで検索結果一覧を表示する
-- TODO not working
vim.api.nvim_create_autocmd( 'quickfixcmdpost', {
  command = 'cwindow',
  pattern = 'grep'
})
-- vimgrepすると自動的にあたらしいウィンドウで検索結果一覧を表示する
-- autocmd QuickFixCmdPost *grep* cwindow

-- -----------------------------------------------------------------------------
-- キーバインド（ノーマルモード）
-- -----------------------------------------------------------------------------
-- 行頭・行末へのカーソル移動
vim.keymap.set('n', '<leader>h', '0', { desc = '-- 0: 行頭へ移動' })
vim.keymap.set('n', '<leader>l', '$', { desc = '-- $: 行末へ移動' })
-- 検索語が画面の中心に来るようにする
vim.keymap.set('n', 'n', 'nzz', { remap = true})
vim.keymap.set('n', 'N', 'Nzz', { remap = true})
vim.keymap.set('n', '*', '*zz', { remap = true})
vim.keymap.set('n', '#', '#zz', { remap = true})
vim.keymap.set('n', 'g*', 'g*zz', { remap = true})
vim.keymap.set('n', 'g#', 'g#zz', { remap = true})
-- ESC連打でハイライト解除
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>', { remap = true, silent = true} , { desc = '-- ハイライト解除' })
-- 折り返し時に表示行単位での移動できるようにする
-- nnoremap j gj
vim.keymap.set('n', 'j', 'gj')
-- nnoremap k gk
vim.keymap.set('n', 'k', 'gk')
-- Yキーでカーソル位置から行末までヤンク
-- nnoremap Y y$
vim.keymap.set('n', 'Y', 'y$', { desc = '-- y$: カーソル位置から行末までヤンク' })
-- ypキーでヤンクレジスタの文字列をペースト
-- noremap yp "0P
vim.keymap.set('n', 'yp', '"0P', { desc = '-- \"0P: ヤンクレジスタの文字列をペースト' })
-- cpキーで無名レジスタの文字列をペースト
-- noremap cp ""P
vim.keymap.set('n', 'cp', '""P', { desc = '-- \"\"P: 無名レジスタの文字列をペースト' })
-- cオペレータをヤンクしない
-- nnoremap c "_c
vim.keymap.set('n', 'c', '"_c')
-- Ctrl-sでスペースを挿入
-- noremap <C-s> i<Space><ESC>
vim.keymap.set('n', '<C-s>', 'i<Space><Esc>', { desc = '-- i<Space><Esc>: スペース挿入' })
-- Space + Ctrl で改行
-- nnoremap <Space><CR> a<CR><Esc>
vim.keymap.set('n', '<Space><CR>', 'a<CR><Esc>', { desc = 'Space + Ctrl で改行' })
-- Ctrl-mで直前のヤンクの末尾に移動
-- nmap <C-m> `]
vim.keymap.set('n', '<C-m>', '`]', { remap = true}, { desc ='-- `]: 直前のヤンクの末尾に移動' })
-- カーソル下の単語をハイライトしてから置換する
vim.keymap.set('n', '<leader>r', [[':<C-u>%s/\<' . expand('<cword>') . '\>//g']], { noremap = true, silent = false, expr = true }, { desc = '-- カーソル下の単語を置換' })
-- カーソル位置を元に戻す
vim.keymap.set('n', '<leader>o', '<C-o>', { desc = '-- <C-o>: カーソル位置を戻す' })
-- カーソル位置を進む
vim.keymap.set('n', '<leader>i', '<C-i>', { desc = '-- <C-i>: カーソル位置を進める' })

-- -----------------------------------------------------------------------------
-- キーバインド（ウィンドウ（ペイン）操作）
-- -----------------------------------------------------------------------------
-- ウィンドウ操作
-- ウィンドウ間移動
vim.keymap.set('n', '<left>',  '<C-w>h', { desc = '-- <C-w>h: 左のウィンドウへ移動' })
vim.keymap.set('n', '<right>', '<C-w>l', { desc = '-- <C-w>l: 右のウィンドウへ移動' })
vim.keymap.set('n', '<up>',    '<C-w>k', { desc = '-- <C-w>k: 上のウィンドウへ移動' })
vim.keymap.set('n', '<down>',  '<C-w>j', { desc = '-- <C-w>j: 下のウィンドウへ移動' })
-- ウィンドウ水平分割
vim.keymap.set('n', 'ss',      '<C-u>sp<Cr>', { desc = '-- <C-u>sp<Cr>: ウィンドウ水平分割' })
-- ウィンドウ垂直分割
vim.keymap.set('n', 'sv',      '<C-u>vs<Cr>', { desc = '-- <C-u>vs<Cr>: ウィンドウ垂直分割' })
-- ウィンドウを閉じる
vim.keymap.set('n', 'sq',      '<C-u>q<Cr>',  { desc = '-- <C-u>q<Cr>: ウィンドウを閉じる' })

-- バッファを閉じる
vim.keymap.set('n', 'sQ',      '<C-u>bq<Cr>', { desc = '-- <C-u>bq<Cr>: バッファを閉じる' })

-- タブ操作
 -- 新規タブ
vim.keymap.set('n', 'st', ':<C-u>tabnew<Cr>', { desc = '-- :<C-u>tabnew<Cr>: 新規タブ' })
-- 次のタブに切替
vim.keymap.set('n', 'sn', 'gt', { desc = '-- gt: 次のタブへ移動' })
-- 前のタブに切替
vim.keymap.set('n', 'sp', 'gT', { desc = '-- gT: 前のタブへ移動' })
-- 前のタブに切替
vim.keymap.set('n', 'gr', ':tabprevious<Cr>', { desc = '-- :tabprevious<Cr>: 前のタブへ移動' })

-- -----------------------------------------------------------------------------
-- キーバインド（インサートモード）
-- -----------------------------------------------------------------------------
-- jjでエスケープ
-- inoremap <silent> jj <ESC>
vim.keymap.set('i', 'jj', '<Esc>', {silent = true}, { desc = '' })
-- 日本語入力時のjjでエスケープ
-- inoremap <silent> ｊｊ <ESC>
-- inoremap <silent> っｊ <ESC>
-- インサートモードでのカーソル移動
-- inoremap <C-j> <Down>
vim.keymap.set('i', '<C-j>', '<down>', { desc = '' })
-- inoremap <C-k> <Up>
vim.keymap.set('i', '<C-k>', '<Up>', { desc = '' })
-- inoremap <C-h> <Left>
vim.keymap.set('i', '<C-h>', '<Left>', { desc = '' })
-- inoremap <C-l> <Right>
vim.keymap.set('i', '<C-l>', '<Right>', { desc = '' })
-- 括弧補完
-- inoremap "<Enter> ""<left>
vim.keymap.set('i', '"<Enter>', '""<Left>', { desc = '' })
-- inoremap '<Enter> ''<left>
vim.keymap.set('i', '\'<Enter>', '\'\'<Left>', { desc = '' })
-- inoremap (<Enter> ()<Left>
vim.keymap.set('i', '(<Enter>', '()<Left>', { desc = '' })
-- inoremap [<Enter> []<Left>
vim.keymap.set('i', '[<Enter>', '[]<Left>', { desc = '' })
-- inoremap {<Enter> {}<Left>
vim.keymap.set('i', '{<Enter>', '{}<Left>', { desc = '' })

-- -----------------------------------------------------------------------------
-- キーバインド（ビジュアルモード）
-- -----------------------------------------------------------------------------
-- ビジュアルモードでペーストを実行した時にレジスタを"*に保存しない
vim.keymap.set('v', 'p', '"_dP', { desc = '' })

-- -----------------------------------------------------------------------------
-- Plugins
-- -----------------------------------------------------------------------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

    --- Appearance (DashBoard)
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()

            local alpha = require('alpha')
            local dashboard = require('alpha.themes.dashboard')

            -- Set header
            dashboard.section.header.val = {
                "                                                     ",
                "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                "                                                     ",
            }

            -- Set menu
            dashboard.section.buttons.val = {
                dashboard.button( "e", "  > New file"      , ":ene <BAR> startinsert <CR>"),
                dashboard.button( "f", "  > Find file"     , ":Telescope find_files<CR>"),
                dashboard.button( "r", "  > Recent"        , ":Telescope frecency<CR>"),
                dashboard.button( "s", "  > Settings"      , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
                dashboard.button( "d", "  > Dotfiles"      , ":cd ~/dotfiles | Telescope find_files<CR>"),
                dashboard.button( "q", "  > Quit NVIM"     , ":qa<CR>"),
            }

            -- Send config to alpha
            alpha.setup(dashboard.opts)

            vim.api.nvim_create_autocmd( 'FileType', {
                pattern = 'alpha',
                command = 'setlocal nofoldenable'
            })

        end
    },
    --- Appearance (Colorscheme)
    {
        "sainnhe/gruvbox-material",
        event = { "BufReadPre", "BufWinEnter" },
        config = function()
            vim.opt.background = "dark"
            vim.g.gruvbox_material_background = "hard"
            vim.g.gruvbox_material_ui_contrast = "high"
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_disable_italic_comment = 1
            vim.cmd("colorscheme gruvbox-material")
        end
    },
    --- Appearance (Status line)
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            require("lualine").setup {
                options = {
                    theme = "gruvbox-material"
                }
            }
        end
    },
    --- Appearance (Scroll bar)
    {
        "petertriho/nvim-scrollbar",
        event = "VimEnter",
        dependencies = { 
            "kevinhwang91/nvim-hlslens" ,
            "lewis6991/gitsigns.nvim" 
        },
        config = function()
            require("scrollbar").setup({
                show = true,
                set_highlights = true,
                handle = {
                    text = " ",
                    color = "#3F4A5A",
                    cterm = nil,
                    highlight = "CursorColumn",
                    hide_if_all_visible = true, -- Hides handle if all lines are visible
                },
                marks = {
                    Search = {
                        text = { "-", "=" },
                        priority = 0,
                        color = nil,
                        cterm = nil,
--                        highlight = "Search",
                        highlight = "DiagnosticVirtualTextError",
                    },
                    Error = {
                        text = { "-", "=" },
                        priority = 1,
                        color = nil,
                        cterm = nil,
                        highlight = "DiagnosticVirtualTextError",
                    },
                    Warn = {
                        text = { "-", "=" },
                        priority = 2,
                        color = nil,
                        cterm = nil,
                        highlight = "DiagnosticVirtualTextWarn",
                    },
                    Info = {
                        text = { "-", "=" },
                        priority = 3,
                        color = nil,
                        cterm = nil,
                        highlight = "DiagnosticVirtualTextInfo",
                    },
                    Hint = {
                        text = { "-", "=" },
                        priority = 4,
                        color = nil,
                        cterm = nil,
                        highlight = "DiagnosticVirtualTextHint",
                    },
                    Misc = {
                        text = { "-", "=" },
                        priority = 5,
                        color = nil,
                        cterm = nil,
                        highlight = "Normal",
                    },
                },
                excluded_buftypes = {
                    "terminal",
                },
                excluded_filetypes = {
                    "prompt",
                    "TelescopePrompt",
                },
                autocmd = {
                    render = {
                        "BufWinEnter",
                        "TabEnter",
                        "TermEnter",
                        "WinEnter",
                        "CmdwinLeave",
                        -- "TextChanged",
                        "VimResized",
                        "WinScrolled",
                    },
                },
                handlers = {
                    diagnostic = true,
                    search = true, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
                }, 
            })

            require('hlslens').setup()
            require('scrollbar.handlers.search').setup({})

            require('gitsigns').setup()
            require("scrollbar.handlers.gitsigns").setup()
        end
    },
    --- Appearance (UI hooks)
    {
        "stevearc/dressing.nvim",
        event = "VimEnter",
        init = function()
            require("dressing").setup()
        end
    },
    --- Appearance (Display command lines and messages in pop-up windows)
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    --- Appearance (Highlighting)
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufNewFile", "BufRead" },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "typescript", "javascript", "rust", "python", "go", "lua",
                    "bash", "html", "css", "vue", "vim", "yaml", "toml", "ini",
                    "json", "dockerfile", "markdown" , "markdown_inline", "diff",
                    "gitignore" , "regex"
                },
                highlight = {
                    enable = true,
                },
            })
        end
    },
    --- Appearance (Highlight of Yanked)
    {
        "machakann/vim-highlightedyank",
        event = "VeryLazy",
        config = function()
            vim.g.highlightedyank_highlight_duration = 300
            vim.cmd("highlight HighlightedyankRegion term=bold ctermfg=0 ctermbg=195 guifg=#000000 guibg=#FFCDD2")
--            vim.api.nvim_create_autocmd( 'ColorScheme', {
--                pattern = '*',
--                command = 'highlight HighlightedyankRegion term=bold ctermfg=0 ctermbg=195 guifg=#000000 guibg=#FFCDD2'
--            })
        end
    },
    --- Appearance (Highlight of cursor word)
    {
        "xiyaowong/nvim-cursorword",
        event = "VeryLazy",
        config = function()
            vim.g.cursorword_min_width = 3
            vim.g.cursorword_max_width = 20
            vim.g.cursorword_disable_filetypes = { "TelescopePrompt" }
            vim.cmd("highlight default CursorWord guifg=#0097A7 gui=underline ctermfg=155 cterm=underline")
        end,
    },
    --- Buffer (tab)
    {
        {
            'akinsho/bufferline.nvim', version = "*",
            event = "VimEnter",
            dependencies = 'nvim-tree/nvim-web-devicons',
            init = function()
                require("bufferline").setup({
--                    options = {
--                        separator_style = 'slant',
--                    },
                    highlights = {
                        separator = {
                            guifg = '#073642',
                            guibg = '#002b36',
                        },
                        separator_selected = {
                            guifg = '#073642',
                        },
                        background = {
                            guifg = '#657b83',
                            guibg = '#002b36'
                        },
                        buffer_selected = {
                            guifg = '#fdf6e3',
                            gui = "bold",
                        },
                        fill = {
                            guibg = '#073642'
                        }
                    },
                }) 
                vim.keymap.set('n', '<leader>wl',   '<Cmd>BufferLineCloseRight<CR>'  , { desc = '' })
                vim.keymap.set('n', '<leader>wh',   '<Cmd>BufferLineCloseLeft<CR>'   , { desc = '' })
                vim.keymap.set('n', '<leader>wall', '<Cmd>BufferLineCloseOthers<CR>' , { desc = '' })
                vim.keymap.set('n', '<leader>we',   '<Cmd>BufferLinePickClose<CR>'   , { desc = '' })
                vim.keymap.set('n', '<C-PageDown>', '<Cmd>BufferLineCycleNext<CR>'   , { desc = '' })
                vim.keymap.set('n', '<C-PageUp>',   '<Cmd>BufferLineCyclePrev<CR>'   , { desc = '' })
            end
        }
    },
    --- Buffer (reopens files at last edit position)
    {
        'ethanholz/nvim-lastplace',
        event = { 'BufNewFile', 'BufRead' },
    },
    --- Operator (Replace Textobject)
    {
        'gbprod/substitute.nvim',
        event = "VeryLazy",
        config = function()
            require("substitute").setup({})
            vim.keymap.set("n", "s",  require('substitute').operator, { noremap = true }, { desc = '' })
            vim.keymap.set("n", "ss", require('substitute').line,     { noremap = true }, { desc = '' })
            vim.keymap.set("n", "S",  require('substitute').eol,      { noremap = true }, { desc = '' })
            vim.keymap.set("x", "s",  require('substitute').visual,   { noremap = true }, { desc = '' })
        end
    },
    --- Operator (Replace Textobject)
--    {
--        'kana/vim-operator-replace',
--        dependencies = { 'kana/vim-operator-user' },
--        config = function()
--            -- nmap R <Plug>(operator-replace)
--            vim.keymap.set('n', '_', '<Plug>(operator-replace)' , { remap = true})
--        end
--    },
    --- Operator (Text modifier operation)
    {
        'tpope/vim-surround',
    },
    --- Operator (Repeat surround operation)
    {
        'tpope/vim-repeat',
    },
    --- Operator (Trim whitespace)
    {
        'bronson/vim-trailing-whitespace',
    },
    --- Operator (Paste without indenting)
    {
        'ConradIrwin/vim-bracketed-paste',
    },
    --- Motion (Cursor vertical move)
    {
        'easymotion/vim-easymotion',
        event = "VeryLazy",
        config = function()
            vim.keymap.set('',  '<Leader><Leader>', '<Plug>(easymotion-prefix)' , { remap = true }, { desc = '' })
            vim.keymap.set('',  '<Leader>j',        '<Plug>(easymotion-j)' ,      { remap = true }, { desc = '' })
            vim.keymap.set('',  '<Leader>k',        '<Plug>(easymotion-k)' ,      { remap = true }, { desc = '' })
            vim.keymap.set('n', '<Leader>s',        '<Plug>(easymotion-s2)' ,     { remap = true }, { desc = '' })
            vim.keymap.set('x', '<Leader>s',        '<Plug>(easymotion-s2)' ,     { remap = true }, { desc = '' })

            vim.g.EasyMotion_do_mapping = 0
            vim.g.EasyMotion_smartcase= 1
            vim.g.EasyMotion_startofline=0
            vim.g.EasyMotion_keys='ABCDEGHIJKLMNOPQRSTUVWXYZ,.;1234567890F'
            vim.g.EasyMotion_use_upper=1
            vim.g.EasyMotion_enter_jump_first=1
            vim.g.EasyMotion_space_jump_first=1
        end
    },
    --- Motion (stay * motions)
    {
        'haya14busa/vim-asterisk',
        event = "VeryLazy",
        config = function()
            vim.keymap.set('',  '*',   '<Plug>(asterisk-*)' ,   { remap = false }, { desc = '' })
            vim.keymap.set('',  '#',   '<Plug>(asterisk-#)' ,   { remap = false }, { desc = '' })
            vim.keymap.set('',  'g*',  '<Plug>(asterisk-g*)' ,  { remap = false }, { desc = '' })
            vim.keymap.set('',  'g#',  '<Plug>(asterisk-g#)' ,  { remap = false }, { desc = '' })
            vim.keymap.set('',  'z*',  '<Plug>(asterisk-z*)' ,  { remap = false }, { desc = '' })
            vim.keymap.set('',  'gz*', '<Plug>(asterisk-gz*)' , { remap = false }, { desc = '' })
            vim.keymap.set('',  'z#',  '<Plug>(asterisk-z#)' ,  { remap = false }, { desc = '' })
            vim.keymap.set('',  'gz#', '<Plug>(asterisk-gz#)' , { remap = false }, { desc = '' })
        end
    },
    --- Window (Tree)
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        init = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            -- nvim-web-devicons設定
            require('nvim-web-devicons').setup({
                default = true,
                color_icons = true,
                override = {
                    [""] = {
                        icon = " ",
                        color = "#6d8086",
                        name = "Config"
                    },
                },
            })

            require('nvim-tree').setup({
                view = {
                    adaptive_size = false,
                    width = 45,
                },
                renderer = {
                    icons = {
                        webdev_colors = true,
                        git_placement = "before",
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = true,
                        },
                        glyphs = {
                            default = " ",
                            symlink = "@",
                            folder = {
                                arrow_closed = ">",
                                arrow_open = "v",
                                default = "📁",
                                open = "📂",
                                empty = "📁",
                                empty_open = "📂",
                                symlink = "@",
                                symlink_open = "@",
                            },
                            git = {
                                unstaged = "✗",
                                staged = "✓",
                                unmerged = "",
                                renamed = "➜",
                                untracked = "★",
                                deleted = "",
                                ignored = "◌"
                            },
                        },
                    },
                },
            })

            -- キーマップ設定
            vim.keymap.set('n', '<leader>tn', ':NvimTreeToggle<CR>' ,   { silent = true , desc = '-- :NvimTreeToggle<CR> ツリーの表示/非表示切り替え' })
            vim.keymap.set('n', '<leader>tf', ':NvimTreeFindFile<CR>' , { silent = true , desc = '-- :NvimTreeFindFile<CR> ツリーのフォーカスをカレントファイルに移動' })
            vim.keymap.set('n', '<leader>tc', ':NvimTreeCollapse<CR>' , { silent = true , desc = '-- :NvimTreeCollapse<CR> ツリーを閉じる' })

            -- ファイルオープン時にnvim-treeを表示するがカーソルはバッファに残す
            -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup
            local function open_nvim_tree(data)
                -- buffer is a real file on the disk
                local real_file = vim.fn.filereadable(data.file) == 1
                -- buffer is a [No Name]
                local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

                if not real_file and not no_name then
                    return
                end
                -- open the tree, find the file but don't focus it
                require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })
            end

            vim.api.nvim_create_autocmd({ "VimEnter" }, {
                callback = open_nvim_tree
            })

            -- ファイルクローズ時にnvim-treeのみの場合は合わせて閉じる。
            -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
            vim.api.nvim_create_autocmd({ "BufEnter" }, {
                group = vim.api.nvim_create_augroup('NvimTreeClose', {clear = true}),
                pattern = 'NvimTree_*',
                callback = function()
                    local layout = vim.api.nvim_call_function('winlayout', {})
                    if layout[1] == "leaf" and
                        vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and
                        layout[3] == nil then
                        vim.cmd("confirm quit")
                    end
                end
           })
        end
    },
    --- Window (Window resize)
    {
        'simeji/winresizer',
    },
    --- Fazzy Finder
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        cmd = 'Telescope',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            {
                "nvim-telescope/telescope-frecency.nvim",
            },
            { 
                "nvim-telescope/telescope-live-grep-args.nvim" ,
                version = "^1.0.0",
            },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            },

        },
        init = function()

            local actions = require("telescope.actions")
            local lga_actions = require("telescope-live-grep-args.actions")
            local lga_shortcuts = require("telescope-live-grep-args.shortcuts")

            require('telescope').setup({
                defaults = {
                    file_ignore_patterns = {
                        '^.git/',
                        '^.cache/',
                        '^Library/',
                        '^Documents/',
                        '^Movies',
                        '^Music',
                    },
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--glob=!.git',
                        '--glob=!.gitignore',
                        '--glob=!node_modules',
                        '--glob=!*-sdk-*',
                        '--glob=!*vendor*',
                        '--glob=!*.lock',
                        '--smart-case',
                        '--sort=path',
                        '-uu',
                    },
                    mappings = {
                        i = { ["<esc>"] = actions.close },
                        n = { ["q"] = actions.close },
                    },
                },
                pickers = {
                    find_files = {
                        find_command = {
                            'rg',
                            '--files',
                            '--hidden',
                            '--glob', '!.git,',
                            '--glob', '!.gitignore,',
                            '--glob', '!node_modules',
                            '--glob', '!*-sdk-*', 
                            '--glob', '!*vendor*', 
                            '--glob', '!*.lock', 
                            '--smart-case'
                        },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = 'smart_case',        -- or "ignore_case" or "respect_case"
                    },
                    live_grep_args = {
                        auto_quoting = true, -- enable/disable auto-quoting
                        mappings = { -- extend mappings
                            i = {
--                                ["<C-q>"] = lga_actions.quote_prompt(),
--                                ["<C-f>"] = lga_actions.quote_prompt({ postfix = " -f " }),
                            },
                        },
                    }
                },
            })

            require('telescope').load_extension('fzf')
            require("telescope").load_extension("live_grep_args")
            require("telescope").load_extension("frecency")

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', "<C-r>f", builtin.find_files,              { desc = '-- Telescope ファイル検索' })
            -- Use frecency
--          vim.keymap.set('n', "<C-r>o", builtin.oldfiles,                { desc = '' })
            vim.keymap.set("n", "<C-r>o", "<Cmd>Telescope frecency<CR>",   { desc = '-- Telescope 最近開いたファイル' })
            vim.keymap.set('n', "<C-r>c", builtin.command_history,         { desc = '-- Telescope コマンド履歴' })
            vim.keymap.set('n', "<C-r>s", builtin.search_history,          { desc = '-- Telescope 検索履歴' })
            -- Use live_grep_args
--          vim.keymap.set('n', "<C-r>g", builtin.live_grep,               { desc = '' })
            vim.keymap.set("n", "<C-r>g", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = '-- Telescope Grep' })
--            vim.keymap.set("n", "<C-r>g", lga_shortcuts.grep_word_under_cursor, { desc = '' })
            vim.keymap.set('n', "<C-r>b", builtin.buffers, {},             { desc = '-- Telescope バッファ' })
            vim.keymap.set('n', "<C-r>h", builtin.help_tags, {},           { desc = '-- Telescope ヘルプ' })
            vim.keymap.set('n', "<C-r>r", builtin.registers, {},           { desc = '-- Telescope レジスタ' })
            vim.keymap.set('n', "<C-r>k", builtin.keymaps, {},             { desc = '-- Telescope キーマップ' })
        end
    },
    --- Terminal
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = true,
        init = function()
            require('toggleterm').setup({
                direction = 'float',
                float_opts = {
                    border = 'single'
                },
            })

            vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', { desc = '' })

            local Terminal = require('toggleterm.terminal').Terminal
            local lazygit = Terminal:new({
                cmd = "lazygit",
                hidden = true,
            })

            function _lazygit_toggle()
                lazygit:toggle()
            end

            vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true , desc = '' })
        end
    },
    --- Session
    {

    },
    --- Completion
    {
        'neovim/nvim-lspconfig',
        cmd = { "LspInfo", "LspLog" },
        event = { "BufRead" },
        config = function()
            -- Set up diagnostic signs
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            -- Configure diagnostics
            vim.diagnostic.config({
                virtual_text = {
                    spacing = 4,
                    prefix = "●",
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            -- Set up key mappings for LSP
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<space>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall" },
        event = { "WinNew", "WinLeave", "BufRead" },
        config = function()
            require("mason").setup()
        end,
    },
    {'hrsh7th/nvim-cmp', event = {'InsertEnter', 'CmdlineEnter'} } ,
    {'hrsh7th/cmp-nvim-lsp', event = 'InsertEnter'},
    {'hrsh7th/cmp-buffer', event = 'InsertEnter'},
    {'hrsh7th/cmp-path', event = 'InsertEnter'},
    {'hrsh7th/cmp-vsnip', event = 'InsertEnter'},
    {'hrsh7th/cmp-cmdline', event = 'ModeChanged'},
    {'hrsh7th/cmp-nvim-lsp-signature-help', event = 'InsertEnter'},
    {'hrsh7th/cmp-nvim-lsp-document-symbol', event = 'InsertEnter'},
    {'hrsh7th/cmp-calc', event = 'InsertEnter'},
    {'onsails/lspkind.nvim', event = 'InsertEnter'},
    {'hrsh7th/vim-vsnip', event = 'InsertEnter'},
    {'hrsh7th/vim-vsnip-integ', event = 'InsertEnter'},
    {'rafamadriz/friendly-snippets', event = 'InsertEnter'},
})

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end
    },

    window = {
        completion = cmp.config.window.bordered({
            border = 'single'
        }),
        documentation = cmp.config.window.bordered({
            border = 'single'
        }),
    },

    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),

    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',
        })
    },

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'calc' },
    }, {
        { name = 'buffer', keyword_length = 2 },
    })
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' }
    }, {
        { name = 'buffer' }
    })
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline', keyword_length = 2 }
    })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.cmd('let g:vsnip_filetypes = {}')

