local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    --- Appearance (Colorscheme)
    {
        "blueshirts/darcula",
        config = function()
            vim.cmd([[colorscheme darcula]])
        end
    },
    --- Appearance (Indent line)
    {
        "Yggdroot/indentLine",
        init = function()
            vim.g["indentLine_color_gui"] = "#e0e0e0"
        end
    },
    --- Appearance (Status line)
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            require("lualine").setup()
        end
    },
    --- Appearance (UI hooks)
    {
        "stevearc/dressing.nvim",
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
        config = function()
            vim.g.highlightedyank_highlight_duration = 300
            vim.api.nvim_create_autocmd( 'colorscheme', {
                command = 'hi HighlightedyankRegion term=bold ctermfg=0 ctermbg=195 guifg=#000000 guibg=#FFCDD2',
                pattern = '*'
            })
        end
    },
--    {
--        -- Appearance (Highlight of movable)
--        'unblevable/quick-scope',
--        config = function()
--            vim.g.qs_highlight_on_keys = "['f', 'F', 't', 'T']"
--        end
--    },
    --- Buffer (reopens files at last edit position)
    {
        'ethanholz/nvim-lastplace',
        event = { 'BufNewFile', 'BufRead' },
    },
    -- Operator (Text Replace)
    {
        'kana/vim-operator-replace',
        dependencies = { 'kana/vim-operator-user' },
        config = function()
            -- nmap R <Plug>(operator-replace)
            vim.keymap.set('n', '_', '<Plug>(operator-replace)' , {remap = true})
        end
    },
    --- Operator (Text modifier operation)
    {
        'tpope/vim-surround',
    },
    --- Operator (Repeat surround operation)
    {
        'tpope/vim-repeat',
    },
    --- Operator (Cursor vertical move)
    {
        'easymotion/vim-easymotion',
        config = function()
            vim.keymap.set('', '<Leader><Leader>', '<Plug>(easymotion-prefix)' , {remap = true})
            vim.keymap.set('', '<Leader>j', '<Plug>(easymotion-j)' , {remap = true})
            vim.keymap.set('', '<Leader>k', '<Plug>(easymotion-k)' , {remap = true})
            vim.keymap.set('n', '<Leader>s', '<Plug>(easymotion-s2)' , {remap = true})
            vim.keymap.set('x', '<Leader>s', '<Plug>(easymotion-s2)' , {remap = true})

            vim.g.EasyMotion_do_mapping = 0
            vim.g.EasyMotion_smartcase= 1
            vim.g.EasyMotion_startofline=0
            vim.g.EasyMotion_keys='ABCDEGHIJKLMNOPQRSTUVWXYZ,.;1234567890F'
            vim.g.EasyMotion_use_upper=1
            vim.g.EasyMotion_enter_jump_first=1
            vim.g.EasyMotion_space_jump_first=1
        end
    },
    --- Operator (Trim whitespace)
    {
        'bronson/vim-trailing-whitespace',
    },
    --- Operator (Paste without indenting)
    {
        'ConradIrwin/vim-bracketed-paste',
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

            require('nvim-tree').setup({
                vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>' , {silent = true})
            })

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
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        cmd = 'Telescope',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. "-Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            },
        },
        init = function()
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
                        '--smart-case',
                        '-uu',
                    },
                },
                pickers = {
                    find_files = {
                        find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = 'smart_case',        -- or "ignore_case" or "respect_case"
                    }
                },
            })

            require('telescope').load_extension('fzf')

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fc', builtin.command_history, {})
            vim.keymap.set('n', '<leader>fs', builtin.search_history, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>fr', builtin.registers, {})
            vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
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

            vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>' , {})

            local Terminal  = require('toggleterm.terminal').Terminal
            local lazygit = Terminal:new({
                cmd = "lazygit",
                hidden = true,
            })

            function _lazygit_toggle()
                lazygit:toggle()
            end

            vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
        end
    },
    --- completion
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

