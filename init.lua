-- I am $MYVIMRC for nvim
-- Put me in ~/.config/nvim/ on linux and ~\AppData\Local\nvim\ on windows
-- make sure colors bundle autoload and all that is in those folders
-- On Windows:
-- See repo for disable capslock reg file for windows 10, double click to merge it then restart your computer.
-- Windows key repeat rate: https://ludditus.com/2016/07/15/microsoft-the-keyboard-repeat-rate-and-sleeping-how-to-work-around-their-idiocy/
-- linux search keyboard set to 200ms delay, 40c/s
-- colors:
-- Linux: ~/.config/nvim/colors
-- Windows: %UserProfile%\AppData\Local\nvim\colors
-- try to set kb pollrate (~40 keys/s) and delay (~200ms)
-- TODO:
-- [] why the hl screwup on load?
-- [] so $MYVIMRC causes clinet quit error
-- Good poast on teh quickfix list https://vonheikemen.github.io/devlog/tools/vim-and-the-quickfix-list/``

--------------------------------------------------------------------------------
-- BOOTSTRAP LAZY.NVIM (Automated Installation)
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------------------------
-- PLUGIN LIST (Lazy.nvim)
--------------------------------------------------------------------------------
require("lazy").setup({
    -- Navigation & Search
    { 'junegunn/fzf', build = "./install --all" },
    { 'junegunn/fzf.vim' },
    { 'phaazon/hop.nvim', config = true },

    -- LSP, Treesitter & Completion (The Engines)
    { 'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
        ensure_installed = { 'cpp', 'c', 'lua', 'vim', 'cmake', 'json', 'python', 'vimdoc' },
        auto_install = true,
        highlight = {
            enable = true,
            -- Disable slow treesitter highlight for large files (>100 KB)
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
    },
    },
    { 'williamboman/mason.nvim', config = true },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require("mason-lspconfig").setup({
                -- This list ensures these servers are always installed
                ensure_installed = { "cmake", "clangd", "vimls", "pyright", "lua_ls" },
                -- This will automatically set up servers you have installed via mason
                automatic_installation = true,
            })
        end
    },
    { 'neovim/nvim-lspconfig' },
    { 'ray-x/lsp_signature.nvim' },
    { 'hrsh7th/nvim-cmp', dependencies = {
        'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline','hrsh7th/cmp-nvim-lua', 'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    }},

    -- UI Modernization
    { 'akinsho/nvim-bufferline.lua' },
    { 'voldikss/vim-floaterm' },
    { 'vimwiki/vimwiki', init = function() vim.g.vimwiki_global_ext = 0 end },

    -- Modern Replacements for "Legacy" Plugins
    { 'tpope/vim-surround' },
    { 'tomtom/tcomment_vim' },
    { 'jiangmiao/auto-pairs' },
    { 'kalvinpearce/ShaderHighlight' },
    { 'itchyny/vim-qfedit' },
    { 'vim-scripts/star-search' },

    -- Git & Utilities
    { 'tpope/vim-fugitive' },
    { 'wellle/targets.vim' },
})
--------------------------------------------------------------------------------
-- 3.5. PLUGIN SETTINGS
--------------------------------------------------------------------------------
vim.g.fzf_buffers_jump = 1
vim.g.fzf_preview_window = ''
vim.g.vimwiki_list = {
    { path = '~/clones/NOTES/', path_html = '~/clones/NOTES/public_html/' }
}
vim.g.vimwiki_global_ext = 0
vim.g.tcomment_mapleader1 = ''
vim.g.tcomment_mapleader2 = ''
vim.g.tcomment_mapleader_comment_anyway = ''
vim.g.tcomment_textobject_inlinecomment = ''
vim.b.AutoPairs = {
    ['('] = ')',
    ['['] = ']',
    ['{'] = '}',
    ["'"] = "'",
    ['"'] = '"',
    ['`'] = '`',
    ['```'] = '```',
    ['"""'] = '"""',
    ["'''"] = "'''"
}
vim.g.AutoPairsShortcutJump = ''
vim.g.AutoPairsShortcutBackInsert = ''
vim.g.AutoPairsShortcutFastWrap = ''
vim.g.AutoPairsShortcutToggle = ''

--------------------------------------------------------------------------------
-- SETTINGS
--------------------------------------------------------------------------------
-- Colorscheme and Highlights
-- COLORSCHEME must come before any hl or color overrides
-- Copy this to your alduin.vim file in colors folder
-- https://raw.githubusercontent.com/AlessandroYorba/Alduin/nightly/colors/alduin.vim
-- Replace the baby blue "Cyan" with a Custom_Cyan color. That or Soft_Yellow
-- highlight! Custom_Cyan guifg=#505f5f guibg=NONE gui=NONE ctermfg=23 ctermbg=NONE cterm=NONE
-- highlight! link Identifier Custom_Cyan
-- Black background
-- let g:alduin_Shout_Become_Ethereal = 1
vim.cmd("colorscheme alduin2")
vim.g.mapleader = " "
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.laststatus = 0
vim.opt.ruler = false
vim.opt.showcmd = true
vim.opt.showmode = false
vim.opt.wrapscan = false
vim.opt.modeline = false
vim.opt.foldenable = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autowrite = true
vim.opt.magic = true
vim.opt.fenc = "utf-8"
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.splitbelow = true
vim.opt.switchbuf:append("useopen")
vim.opt.lazyredraw = true
vim.opt.diffopt:append("vertical")
vim.opt.visualbell = true
vim.opt.wildignorecase = true
vim.opt.textwidth = 300
vim.opt.wrap = false
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.shortmess:append("c")
vim.opt.path:append("**")
vim.opt.completeopt = { "menuone", "noinsert", "noselect", "preview" }
vim.opt.winblend = 15 -- set all floating windows transparent(0-100)

-- Tell vim to use ripgrep as its grep program
-- NOTE: --sort path can be used to get consistent order, but it will run with 1 thread.
-- in terminal see rg --help for options to ripgrep 12
-- set grepprg=rg\ --vimgrep\ --glob\ !tags\ --sort\ path
-- NOTE: these globs work when you cd to root with Gcd using <leader>cr
-- <leader>a does <leader>cr automatically
-- set grepprg=rg\ --vimgrep\ --path-separator\ /\ -g\ 'src/**'\ -g\ 'public/src/**'\ -g\ 'specs/**'\ -g\ 'lib/**'\ -g\ 'include/**'\ -g\ 'tests/**'\ -g\ 'applications/**'\ -g\ 'cmake/**'
-- NOTE: one slash for line break, one for space
-- NOTE: keep --vimgrep at the end
-- add root level folders you want to search with -g
-- Grep configuration
if vim.fn.has("win32") == 1 then
    vim.opt.grepprg = "rg --path-separator / -g src/** --vimgrep"
else
    vim.opt.grepprg = "rg --path-separator / -g 'src/**' --vimgrep"
end

-- COLORCOLUMN
-- CURSORLINE (can be slower in some terminals)
-- purple4 black
-- You can also specify a color by its RGB (red, green, blue) values.
-- The format is "#rrggbb", where
-- hi Comment guifg=#11f0c3 guibg=#ff00ff
vim.api.nvim_set_hl(0, "cursorline", { bg = "purple4" })
vim.api.nvim_set_hl(0, "cursorcolumn", { bg = "purple4" })
vim.g.useCursorline = 1
-- No fuss terminal colors
vim.g.terminal_color_0  = '#2e3436'
vim.g.terminal_color_1  = '#cc0000'
vim.g.terminal_color_2  = '#4e9a06'
vim.g.terminal_color_3  = '#c4a000'
vim.g.terminal_color_4  = '#3465a4'
vim.g.terminal_color_5  = '#75507b'
vim.g.terminal_color_6  = '#0b939b'
vim.g.terminal_color_7  = '#d3d7cf'
vim.g.terminal_color_8  = '#555753'
vim.g.terminal_color_9  = '#ef2929'
vim.g.terminal_color_10 = '#8ae234'
vim.g.terminal_color_11 = '#fce94f'
vim.g.terminal_color_12 = '#729fcf'
vim.g.terminal_color_13 = '#ad7fa8'
vim.g.terminal_color_14 = '#00f5e9'
vim.g.terminal_color_15 = '#eeeeec'
vim.g.floaterm_position = 'right'
vim.g.floaterm_height = 0.99

-- trailing whitespace, and end-of-lines. Very useful if in a code base that requires it.
-- Also highlight all tabs and trailing whitespace characters.
-- vim.opt.listchars = { tab = '»·', trail = '·', nbsp = '·' } -- Display extra whitespace
-- vim.opt.list = true                                       -- Show problematic characters.
-- NOTE see vim-better-whitespace plugin
vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = "black", bg = "black" })

--------------------------------------------------------------------------------
-- BUFFERLINE CONFIGURATION
--------------------------------------------------------------------------------
local hlColor = "GreenYellow"
-- local hlColor = "LemonChiffon3"

require('bufferline').setup({
    options = {
        tab_size = 12,
        max_name_length = 40,
        show_buffer_close_icons = false,
    },
    highlights = {
        buffer_selected = {
            fg = "Black",
            bg = hlColor,
            bold = true,
        },
        -- Accent the split buffer thats not selected
        buffer_visible = {
            fg = hlColor,
        },
    },
})

--------------------------------------------------------------------------------
-- CMP & LUASNIP SETUP
--------------------------------------------------------------------------------
local luasnip = require('luasnip')
local cmp = require('cmp')

-- Global setup
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

-- `/` cmdline setup (Search)
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- `:` cmdline setup (Command mode)
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

--------------------------------------------------------------------------------
-- LSP_SIGNATURE CONFIGURATION
--------------------------------------------------------------------------------
require('lsp_signature').setup({
    hint_enable = true,      -- virtual hint enable
    hint_prefix = "",
    floating_window = true,  -- false for virtual text only
    handler_opts = {
        border = "single"    -- double, single, shadow, none
    },
    extra_trigger_chars = { "(", "," }
})



--------------------------------------------------------------------------------
-- LSPCONFIG LANGUAGE SERVERS
--------------------------------------------------------------------------------
local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
    -- Activate lsp_signature when attaching to a buffer
    -- This uses the config we defined in the previous block
    require('lsp_signature').on_attach()

    -- Buffer local options
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Standard LSP commands
    vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gk', vim.lsp.buf.hover, opts)
    -- Rename/References (includes your "wyiw" register trick from init.vim)
    vim.keymap.set('n', 'gR', '"wyiw<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set('n', 'gr', '"wyiw<cmd>lua vim.lsp.buf.references()<cr>', opts)
    -- Custom automation binds
    vim.keymap.set('n', '<a-f>', '<cmd>call RunLSPFormatter()<cr>', opts)
    vim.keymap.set('n', 'ge', vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', '<a-o>', '<cmd>ClangdSwitchSourceHeader<cr>', opts)
end

-- Server list
-- To install manually via Mason: :MasonInstall cmake-language-server clangd vim-language-server pyright lua-language-server
local servers = { "cmake", "clangd", "vimls", "pyright", "lua_ls" }

-- Capabilities for nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, lsp in ipairs(servers) do
    if lsp ~= "clangd" then
        lspconfig[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end
end
lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "clangd", "--background-index", "--clang-tidy" },
})

-- some debug stuff:
    -- -- lsp config
    -- -- https://github.com/neovim/nvim-lspconfig
    -- -- Check that an LSP client has attached to the current buffer:  >
    -- --     :lua print(vim.inspect(vim.lsp.buf_get_clients()))
    -- --     :LspInfo
    -- --     make sure no ERRORS in
    -- --     :lua vim.cmd('e'..vim.lsp.get_log_path())
    -- -- -- NOTE: use these for debug info
    -- -- -- uncomment vim.lsp.set_log_level("debug") above
    -- -- -- :lua print(vim.inspect(vim.lsp.buf_get_clients()))
    -- -- -- :LspInfo
    -- -- -- to look in the lsp's log:
    -- -- -- :lua vim.cmd('e'..vim.lsp.get_log_path())

    -- Use to debug clangd, remove from server list above but remember to put it back when fixed
    -- nvim_lsp.clangd.setup{
    --     cmd = { "clangd", "-j=1", "--log=verbose" },
    --     flags = {
    --         debounce_text_changes = 500,
    --     },
    --     on_attach = on_attach,
    -- }

    -- -- Turn on debug logging
    -- vim.lsp.set_log_level("debug")
--

vim.diagnostic.config = {
    virtual_text = true,
    signs = false,
    underline = false,
}

--------------------------------------------------------------------------------
-- AUTOCMD & GROUP LOGIC
--------------------------------------------------------------------------------
local my_augroup = vim.api.nvim_create_augroup("MyAutoCommands", { clear = true })

-- 1. Cursorline Toggle Logic
if vim.g.useCursorline == 1 then
    vim.opt.cursorline = true
    vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
        group = my_augroup,
        callback = function() vim.opt_local.cursorline = false end,
    })
    vim.api.nvim_create_autocmd({ "InsertLeave", "VimEnter", "WinEnter" }, {
        group = my_augroup,
        callback = function()
            vim.opt_local.cursorline = true
            vim.cmd("silent! update!")
        end,
    })
else
    vim.opt.cursorline = false
    vim.api.nvim_create_autocmd("InsertEnter", {
        group = my_augroup,
        callback = function() vim.opt_local.cursorline = true end,
    })
    vim.api.nvim_create_autocmd("InsertLeave", {
        group = my_augroup,
        callback = function()
            vim.opt_local.cursorline = false
            vim.cmd("silent! update!")
        end,
    })
end

-- 2. Notify if file changed outside Neovim
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "WinEnter", "CursorHold", "CursorHoldI" }, {
    group = my_augroup,
    command = "checktime",
})

-- 3. Preserve last editing position
vim.api.nvim_create_autocmd("BufReadPost", {
    group = my_augroup,
    callback = function()
        local last_pos = vim.fn.line("'\"")
        if last_pos > 0 and last_pos <= vim.fn.line("$") then
            vim.cmd([[normal! g`" ]])
        end
    end,
})

-- 4. Whitespace Highlighting Logic
vim.api.nvim_create_autocmd({ "BufWinEnter", "InsertLeave" }, {
    group = my_augroup,
    command = "match ExtraWhitespace /\\s\\+$/",
})
vim.api.nvim_create_autocmd("InsertEnter", {
    group = my_augroup,
    command = "match ExtraWhitespace /\\s\\+\\%#\\@<!$/",
})
vim.api.nvim_create_autocmd("BufWinLeave", {
    group = my_augroup,
    callback = function() vim.fn.clearmatches() end,
})

-- 5. Filetype Specific Settings
vim.api.nvim_create_autocmd("FileType", {
    group = my_augroup,
    pattern = "markdown",
    callback = function() vim.opt_local.spell = true end,
})
vim.api.nvim_create_autocmd("FileType", {
    group = my_augroup,
    pattern = "json",
    command = "syntax match Comment +\\/\\/.\\+$+",
})
-- vim.api.nvim_create_autocmd("FileType", {
--     group = my_augroup,
--     pattern = "javascript",
--     callback = function()
--         vim.opt_local.tabstop = 2
--         vim.opt_local.shiftwidth = 2
--     end,
-- })

--------------------------------------------------------------------------------
-- GIT & FILE MANAGEMENT FUNCTIONS
--------------------------------------------------------------------------------

-- @see MakeFileAndAddToGit
function CreateAddFile(currFilename, filename)
    vim.cmd("silent edit " .. filename)
    vim.cmd("silent write")
    vim.fn.system("git add " .. filename)
    print('===== UPDATE CMAKELISTS.TXT: ' .. filename .. ' =====')
end

-- @see MakeFileAndAddToGit
function RemoveFile(currFilename, filename)
    vim.fn.system("git rm -f " .. currFilename)
    print('===== UPDATE CMAKELISTS.TXT: ' .. currFilename .. ' =====')
end

-- @see MakeFileAndAddToGit
function MoveFile(currFilename, filename)
    vim.fn.system("git mv " .. currFilename .. " " .. filename)
    print('===== UPDATE CMAKELISTS.TXT: ' .. currFilename .. ' -> ' .. filename .. ' =====')

    vim.cmd("silent edit " .. filename)

    -- TODO: here: go back to the old file with c-6
    -- vim.cmd("silent bd!")

    vim.cmd("silent edit " .. filename)
end

--------------------------------------------------------------------------------
-- FILEGIT: AUTOMATED C++/H REPO MANAGEMENT
--------------------------------------------------------------------------------
function FileGit(fn, filename)
    -- 1. Setup local paths
    vim.cmd('cd %:p:h')
    local fullCurrFilePath = vim.fn.expand('%:p')
    print('fullCurrFilePath: ' .. fullCurrFilePath)

    -- 2. Sanitize and get full path of target
    local filenameSanitized = filename:gsub('^/', '')
    local fullFilePath = vim.fn.getcwd() .. '/' .. filenameSanitized
    print('fullFilePath: ' .. fullFilePath)

    -- 3. Use Fugitive's Gcd to hit repo root
    vim.cmd('Gcd')
    local rootPath = vim.fn.getcwd() .. '/'
    print('rootPath: ' .. rootPath)

    -- 4. Calculate relative paths (Windows Safe)
    -- Normalize everything to forward slashes first to avoid \ vs / confusion
    local normFull = fullFilePath:gsub("\\", "/")
    local normCurr = fullCurrFilePath:gsub("\\", "/")
    local normRoot = rootPath:gsub("\\", "/"):gsub("/$", "") -- remove trailing slash for clean math
    -- Instead of gsub, we find the length of the root and slice the string
    -- This ignores all "magic" characters in the path
    local fileRootRel = normFull:sub(#normRoot + 2) -- +2 to skip the leading slash
    local currFileRootRel = normCurr:sub(#normRoot + 2)
    -- print('DEBUG: Corrected fileRootRel: ' .. fileRootRel)

    -- 5. Calculate directory and mkdir -p
    local fileDirRootRel = fileRootRel:match("(.*[/\\])") or ""
    print('fileDirRootRel: ' .. fileDirRootRel)

    if fileDirRootRel ~= "" then
        print('Running mkdir -p ' .. fileDirRootRel)
        vim.fn.system('mkdir -p ' .. fileDirRootRel)
    end

    -- 6. Execute the passed function (CreateAddFile, MoveFile, etc.)
    fn(currFileRootRel, fileRootRel)

    -- 7. C/CPP Logic for .h mirroring
    -- Check if target or current is a C/CPP file
    local isCFile = fileRootRel:match("%.c[p]?[p]?$") ~= nil
    local isCurrCFile = currFileRootRel:match("%.c[p]?[p]?$") ~= nil

    -- We check the function name by comparing it to the global function reference
    if fn == CreateAddFile then
        print('CALLED CreateAddFile')
        if not isCFile then
            print('WAS NOT A C/CPP FILE: ' .. fileRootRel .. ' : DONE!')
            return
        end
    else
        print('DID NOT CALL CreateAddFile')
        if not isCurrCFile then
            print('WAS NOT A C/CPP FILE: ' .. currFileRootRel .. ' : DONE!')
            return
        end
    end

    print('THIS IS A C/CPP FILE: RUNNING OPERATION FOR H FILE')

    -- Generate .h relative paths
    local hFileRootRel = fileRootRel:gsub("%.c[p]?[p]?$", ".h")
    local hCurrFileRootRel = currFileRootRel:gsub("%.c[p]?[p]?$", ".h")

    -- 8. Check for 'include' directory (Platform Independent)
    -- vim.uv.fs_stat returns information about a path if it exists
    local stat = vim.uv.fs_stat(vim.fn.getcwd() .. '/include')
    local hasIncludeDir = stat and stat.type == 'directory'

    if not hasIncludeDir then
        print('DOES NOT HAVE INCLUDE DIR: DONE')
        fn(hCurrFileRootRel, hFileRootRel)
        return
    end

    print('HAS INCLUDE DIR')

    -- 9. Mirror src -> include or source -> include
    local prefixes = { "src", "source" }
    for _, prefix in ipairs(prefixes) do
        -- Use a pattern to find the prefix regardless of leading slashes
        -- This looks for the prefix at the start (^) optionally preceded by a /
        -- and ensures it is followed by a separator so "src_extra" doesn't match "src"
        local pattern = "^" .. prefix .. "/"  -- Simple and clean

        -- print("DEBUG: Prefix is '" .. prefix .. "'")
        -- print("DEBUG: Path start is '" .. fileDirRootRel:sub(1, #prefix) .. "'")
        -- print("DEBUG: pattern is '" .. pattern .. "'")

        if fileDirRootRel:match(pattern) then
            print('MATCHED PREFIX: ' .. prefix:upper())

            -- Replace the prefix with 'include' at the start of the string
            local hFileDirRootRel = fileDirRootRel:gsub("^/?" .. prefix, "include")

            -- Normalize slashes for Windows compatibility
            hFileDirRootRel = hFileDirRootRel:gsub("\\", "/")

            print('Running mkdir -p ' .. hFileDirRootRel)
            vim.fn.mkdir(hFileDirRootRel, "p")

            local hFileStem = hFileRootRel:gsub("^/?" .. prefix, "include")
            local hCurrFileStem = hCurrFileRootRel:gsub("^/?" .. prefix, "include")

            fn(hCurrFileStem, hFileStem)
            return
        end
    end
end

--------------------------------------------------------------------------------
-- LSP FORMATTING & UTILITIES
--------------------------------------------------------------------------------
function RunLSPFormatter()
    -- Format file if it's not markdown
    if vim.bo.filetype ~= 'markdown' then
        vim.lsp.buf.format()
    end

    -- Remove ^M (Carriage Returns)
    -- The 'keystroke' approach via vim.cmd is still the most efficient way
    vim.cmd([[silent! %s/\r//ge]])

    -- Save file if it changed
    vim.cmd("silent! up!")
end

function Flash()
    -- This mimics your current logic of updating the file.
    -- If you want to re-enable the visual flash later,
    -- you can uncomment the cursorline/column logic here.
    vim.cmd("silent! up!")
end

--------------------------------------------------------------------------------
-- CUSTOM USER COMMANDS
--------------------------------------------------------------------------------
-- :MyGrep <args>
vim.api.nvim_create_user_command('MyGrep', function(opts)
    vim.cmd('mark A')
    vim.cmd('silent grep! ' .. opts.args)
    vim.cmd('bot cw 20')
end, { nargs = '+' })

-- :MyGrepCurrentFile <args>
vim.api.nvim_create_user_command('MyGrepCurrentFile', function(opts)
    vim.cmd('mark A')
    vim.cmd('silent grep! ' .. opts.args .. ' %')
    vim.cmd('bot cw 20')
end, { nargs = '+' })

-- :MyCdo <args>
vim.api.nvim_create_user_command('MyCdo', function(opts)
    vim.cmd('silent cdo! ' .. opts.args)
    vim.cmd('cfdo update')
    vim.cmd('cclose')
    vim.cmd('normal! `A')
end, { nargs = '+' })

--------------------------------------------------------------------------------
-- KEY BINDINGS
--------------------------------------------------------------------------------
-- put nop's at the top of mappings
local nop_keys = { '<c-e>', '<c-y>', '<c-f>', '<c-b>', 'R', }
for _, key in ipairs(nop_keys) do
    vim.keymap.set({ '' }, key, '<nop>', { silent = true })
end
vim.keymap.set({ 'n', }, 'S', '<nop>', { silent = true })


vim.keymap.set('n', '<leader>L', '<cmd>Lazy<cr>', { desc = "Lazy Menu" })
vim.keymap.set('n', '<leader>vs', ':so $MYVIMRC<cr>', { desc = "Reload Config" })
vim.keymap.set('n', '<esc>', ':noh<cr>', { silent = true })

-- FZF Binds
vim.keymap.set('n', '<leader>fr', ':Rg<cr>')
vim.keymap.set('n', '<leader>F', ':Files<cr>')

-- Buffer Navigation
vim.keymap.set('n', '<a-l>', ':BufferLineCycleNext<CR>')
vim.keymap.set('n', '<a-h>', ':BufferLineCyclePrev<CR>')

vim.keymap.set('n', '<leader><leader>', '<cmd>LspRestart<cr>')

-- Source the config and re-center
-- In init.lua, $MYVIMRC points to init.lua automatically
vim.keymap.set('n', '<leader>vs', '<cmd>so $MYVIMRC<cr>msHmt<cmd>e<cr>`tzt`s', { silent = true })

-- Escape clears highlights and runs your Flash function
vim.keymap.set('n', '<esc>', function()
    Flash() -- Calling the Lua function we converted earlier
    vim.cmd('noh')
end, { silent = true })

-- Toggle Floaterm
vim.keymap.set('n', '<c-\\>', '<cmd>FloatermToggle<cr>', { silent = true })
vim.keymap.set('t', '<c-\\>', [[<c-\><c-n><cmd>FloatermToggle<cr>]], { silent = true })

-- Terminal escape logic
vim.keymap.set('t', '<esc>', [[<c-\><c-n><cmd>hide<cr>]], { silent = true })
vim.keymap.set('t', '<c-\\>', [[<c-\><c-n>]], { silent = true })

-- Simulate i_CTRL-R in terminal-mode
vim.keymap.set('t', '<c-r>', function()
    local char = vim.fn.nr2char(vim.fn.getchar())
    return [[<c-\><c-n>"]] .. char .. "pi"
end, { expr = true })

-- Manually remove whitespace, tabs to spaces, and ^M
vim.keymap.set('n', '<leader>w', function()
    vim.cmd('mark w')
    vim.cmd([[silent! %s/\s\+$//ge]])
    vim.cmd([[silent! %s/\t/    /ge]])
    vim.cmd([[silent! %s/\r//ge]])
    vim.cmd('noh')
    vim.cmd('normal! `w')
end)

-- BufferLine navigation
vim.keymap.set('n', '<a-l>', '<cmd>BufferLineCycleNext<cr>', { silent = true })
vim.keymap.set('n', '<a-h>', '<cmd>BufferLineCyclePrev<cr>', { silent = true })
vim.keymap.set('n', '<a-s-l>', '<cmd>BufferLineMoveNext<cr>', { silent = true })
vim.keymap.set('n', '<a-s-h>', '<cmd>BufferLineMovePrev<cr>', { silent = true })

-- Save and kill buffer
vim.keymap.set('n', '<a-q>', '<cmd>silent! up! | silent! bd!<cr>', { silent = true })

function SetScroll()
    local scrAmount = math.floor(vim.o.lines / 4)
    vim.keymap.set('n', '<c-d>', scrAmount .. '<c-e>')
    vim.keymap.set('n', '<c-u>', scrAmount .. '<c-y>')
end

-- Initialize and set autocmd for resizing
SetScroll()
vim.api.nvim_create_autocmd("VimResized", {
    callback = function() SetScroll() end
})

-- Custom Ripgrep command with preview
vim.api.nvim_create_user_command('Rg', function(opts)
    -- Using the fzf#vim# functions via vim.fn
    local spec = vim.fn['fzf#vim#with_preview']({ options = { '--layout=reverse' } })
    vim.fn['fzf#vim#grep'](
        "rg -S --path-separator / " .. vim.fn.shellescape(opts.args),
        0,
        spec,
        opts.bang and 1 or 0
    )
end, { nargs = '*', bang = true })

vim.keymap.set('n', '<leader>fr', '<cmd>Rg<cr>')

-- Global FZF layout
vim.g.fzf_layout = {
    window = {
        width = 0.9,
        height = 0.6,
        border = 'horizontal'
    }
}

-- :Files command (using fd)
vim.api.nvim_create_user_command('Files', function(opts)
    vim.fn['fzf#vim#files'](opts.args, {
        options = { '--layout=reverse' },
        source = 'fd --no-ignore --hidden --follow --type f'
    }, opts.bang and 1 or 0)
end, { nargs = '?', bang = true, complete = 'dir' })

-- :GFiles command
vim.api.nvim_create_user_command('GFiles', function(opts)
    vim.fn['fzf#vim#gitfiles'](opts.args, {
        options = { '--layout=reverse' }
    }, opts.bang and 1 or 0)
end, { nargs = '?', bang = true, complete = 'dir' })

-- :Buffers command
vim.api.nvim_create_user_command('Buffers', function(opts)
    vim.fn['fzf#vim#buffers'](opts.args, {
        options = { '--layout=reverse' }
    }, opts.bang and 1 or 0)
end, { nargs = '?', bang = true, complete = 'dir' })

-- :History command
vim.api.nvim_create_user_command('History', function(opts)
    vim.fn['fzf#vim#history']({
        options = { '--layout=reverse' }
    }, opts.bang and 1 or 0)
end, { nargs = '?', bang = true })

-- FZF Keybinds
vim.keymap.set('n', '<leader>F', '<cmd>Files<cr>', { silent = true })
vim.keymap.set('n', '<leader>fg', '<cmd>GFiles<cr>', { silent = true })
vim.keymap.set('n', '<leader>fb', '<cmd>Buffers<cr>', { silent = true })
vim.keymap.set('n', '<leader>fh', '<cmd>History<cr>', { silent = true })

-- Tagbar
-- vim.keymap.set('n', '<f2>', '<cmd>TagbarToggle<cr>', { silent = true })

-- Fugitive: Repo root navigation
vim.keymap.set('n', '<leader>cr', '<cmd>Gcd<cr><cmd>pwd<cr>', { silent = true })
vim.keymap.set('n', '<leader>gg', '<cmd>G<cr><c-w>H', { silent = true })

-- Hop: Easy motion replacement
vim.keymap.set({ 'n', 'x' }, 's', '<cmd>HopChar2<cr>', { silent = true })

-- Spelling suggestions
vim.keymap.set('n', '<c-s>', 'i<right><c-x>s')
vim.keymap.set('i', '<c-s>', '<right><c-x>s')

-- Change local directory to current file
vim.keymap.set('n', '<leader>cd', '<cmd>lcd %:p:h | pwd<cr>', { silent = true })

-- Make A and I work in visual line mode
vim.keymap.set('x', 'A', function()
    return vim.fn.mode() == "V" and ":norm A" or "A"
end, { expr = true })

vim.keymap.set('x', 'I', function()
    return vim.fn.mode() == "V" and ":norm I" or "I"
end, { expr = true })

-- Git Add
vim.keymap.set('n', '<leader>ga', [[:lua FileGit(CreateAddFile, "")<left><left>]], { remap = false })

-- Git Remove
vim.keymap.set('n', '<leader>gr', [[:lua FileGit(RemoveFile, "")<left><left>]], { remap = false })

-- Git Move
vim.keymap.set('n', '<leader>gm', [[:lua FileGit(MoveFile, "")<left><left>]], { remap = false })

-- Force "Very No Magic" search by default
vim.keymap.set({ 'n', 'x' }, '/', [[/\V]])

-- System Clipboard mappings (Avoiding unnamedplus slowness)
vim.keymap.set('x', '<c-y>', '"+y')
vim.keymap.set({ 'n', 'x' }, '<c-p>', '"+p')

-- Insert specialized C++ style block comment
-- vim.keymap.set('n', '<leader>/', [[O/****************************************************<cr><backspace>***************************************************/<esc>ko]])

-- Normal Mode navigation
vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-l>', '<c-w>l')

-- Insert Mode navigation (Escapes and moves)
vim.keymap.set('i', '<c-h>', '<Esc><c-w>h')
vim.keymap.set('i', '<c-j>', '<Esc><c-w>j')
vim.keymap.set('i', '<c-k>', '<Esc><c-w>k')
vim.keymap.set('i', '<c-l>', '<Esc><c-w>l')

-- Terminal Mode navigation
vim.keymap.set('t', '<c-h>', [[<c-\><c-n><c-w>h]])
vim.keymap.set('t', '<c-j>', [[<c-\><c-n><c-w>j]])
vim.keymap.set('t', '<c-k>', [[<c-\><c-n><c-w>k]])
vim.keymap.set('t', '<c-l>', [[<c-\><c-n><c-w>l]])


-- Location List
vim.keymap.set('n', '<a-s-c>o', '<cmd>lopen<cr>')
vim.keymap.set('n', '<a-s-n>', '<cmd>lnext<cr>')
vim.keymap.set('n', '<a-s-p>', '<cmd>lprevious<cr>')

-- Quickfix List
vim.keymap.set('n', '<a-c>o', '<cmd>copen<cr>')
vim.keymap.set('n', '<a-n>', '<cmd>cnext<cr>')
vim.keymap.set('n', '<a-p>', '<cmd>cprevious<cr>')

-- Single hit indent
vim.keymap.set('n', '<', '<<')
vim.keymap.set('n', '>', '>>')

-- Indent scope (marks position, indents inside braces, returns)
vim.keymap.set('n', '==', 'ms=i{`s')

-- Macros
vim.keymap.set('n', 'Q', '@q')
vim.keymap.set('v', 'Q', ':norm @q<cr>')

-- Display lines navigation (useful for wrapped lines)
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

--This is the "Very No Magic" style for your d, y, and c operations to ensure they are inclusive.
vim.keymap.set('o', 'T', 'vT')
vim.keymap.set('o', 'F', 'vF')
vim.keymap.set('o', 'B', 'vB')
vim.keymap.set('o', 'b', 'vb')

-- Split resizing
vim.keymap.set('n', '<c-left>',  '<cmd>vert res -8<cr>')
vim.keymap.set('n', '<c-right>', '<cmd>vert res +8<cr>')
vim.keymap.set('n', '<c-down>',  '<cmd>res -8<cr>')
vim.keymap.set('n', '<c-up>',    '<cmd>res +8<cr>')

-- Config editing and Exit
vim.keymap.set('n', '<leader>ve', '<cmd>e $MYVIMRC<cr>', { silent = true })
vim.keymap.set('n', '<leader>qq', '<cmd>wa! | qa!<cr>', { silent = true })

if vim.fn.has('win32') == 1 then
    -- Windows paths (using %userprofile%)
    vim.keymap.set('n', '<leader>vd', [[<c-\>pushd .<cr>cd %userprofile%\clones\vim<cr>git pull<cr>copy /y %userprofile%\AppData\Local\nvim\init.lua .<cr>git diff<cr>]], { silent = true })
    vim.keymap.set('n', '<leader>vp', [[<c-\>pushd .<cr>cd %userprofile%\clones\vim<cr>git pull<cr>copy /y init.lua %userprofile%\AppData\Local\nvim<cr>popd<cr>]], { silent = true })
else
    -- Linux/macOS paths
    vim.keymap.set('n', '<leader>vd', [[<c-\>cd ~/clones/vim<cr>git pull<cr>cp $MYVIMRC .<cr>git diff<cr>]], { silent = true })
    vim.keymap.set('n', '<leader>vp', [[<c-\>cd ~/clones/vim<cr>git pull<cr>cp init.lua $MYVIMRC<cr>cd -<cr>]], { silent = true })
end

-- Save all and quit all
vim.keymap.set('n', '<leader>qq', '<cmd>wa! | qa!<cr>', { silent = true, desc = "Save and quit all" })

-- Prettier format Json using Python's built-in tool
vim.keymap.set('n', '<leader>p', '<cmd>%!python -m json.tool<cr>', { desc = "Format JSON" })

-- Hex view toggle (xxd)
-- Useful for your systems programming and reverse engineering work
vim.keymap.set('n', '<leader>xx', '<cmd>%!xxd<cr>', { desc = "Convert to Hex" })
vim.keymap.set('n', '<leader>xr', '<cmd>%!xxd -r<cr>', { desc = "Reverse Hex to Binary" })

--------------------------------------------------------------------------------
-- SEARCH & SUBSTITUTE LOGIC
--------------------------------------------------------------------------------
-- thing thang thong
-- thing thang thong
-- thing thang thong
-- thing thang thong
-- thing thang thong
-- -- 1. Edit last search within visual selection or whole file
-- -- These use <leader>,es for "last search" and <leader>,ew for "word under cursor"
-- vim.keymap.set('x', '<leader>,es', [[:s///gI<left><left><left>]])
-- vim.keymap.set('x', '<leader>,ew', [[:s/<c-r><c-w>//gI<left><left><left>]])
-- vim.keymap.set('n', '<leader>,es', [[:%s///gI<left><left><left>]])
-- vim.keymap.set('n', '<leader>,ew', [[:%s/<c-r><c-w>//gI<left><left><left>]])
-- -- Expression maps to choose between last search or word under cursor
-- vim.keymap.set('x', '<leader>e', function()
--     return vim.v.hlsearch == 1 and "<leader>,es" or "<leader>,ew"
-- end, { expr = true })
-- vim.keymap.set('n', '<leader>e', function()
--     return vim.v.hlsearch == 1 and "<leader>,es" or "<leader>,ew"
-- end, { expr = true })
-- Expression maps to choose between last search or word under cursor
vim.keymap.set('n', '<leader>e', function()
    local search_reg = vim.fn.getreg('/')
    -- If search highlighting is on AND the search register isn't empty,
    -- prioritize the search register. Otherwise, use word under cursor.
    if vim.v.hlsearch == 1 and search_reg ~= "" then
        return ":%s///gI<left><left><left>"
    else
        return ":%s/<c-r><c-w>//gI<left><left><left>"
    end
end, { expr = true })

-- Do the same for Visual Mode
vim.keymap.set('x', '<leader>e', function()
    local search_reg = vim.fn.getreg('/')
    if vim.v.hlsearch == 1 and search_reg ~= "" then
        return ":s///gI<left><left><left>"
    else
        return ":s/<c-r><c-w>//gI<left><left><left>"
    end
end, { expr = true })

-- 2. Grep / Ripgrep Integration (Automated Clean-up of Search Register)
-- This function mimics your nested substitute calls to clean up Vim regex for Ripgrep
local function clean_search_reg()
    local search = vim.fn.getreg('/')
    search = vim.fn.substitute(search, [[\V]], '', 'g')
    search = vim.fn.substitute(search, [[\n$]], '', 'g')
    search = vim.fn.substitute(search, [[\<]], '', 'g')
    search = vim.fn.substitute(search, [[\>]], '', 'g')
    search = vim.fn.substitute(search, [[\]], [[\\]], 'g')
    return search
end

-- -- Grep from current location
-- vim.keymap.set('n', '<leader>,as', function()
--     vim.fn.setreg('w', "")
--     vim.cmd('MyGrep "' .. clean_search_reg() .. '"')
-- end)
--
-- vim.keymap.set('n', '<leader>,aw', function()
--     vim.fn.setreg('w', vim.fn.expand('<cword>'))
--     vim.cmd('MyGrep "-w" "' .. vim.fn.expand('<cword>') .. '"')
-- end)
--
-- -- Grep from root or with glob patterns
-- vim.keymap.set('n', '<leader>,aS', function()
--     vim.fn.setreg('w', "")
--     vim.cmd('MyGrep "-g" "*/**" "' .. clean_search_reg() .. '"')
-- end)
--
-- vim.keymap.set('n', '<leader>,aW', function()
--     vim.fn.setreg('w', vim.fn.expand('<cword>'))
--     vim.cmd('MyGrep "-w" "-g" "*" "' .. vim.fn.expand('<cword>') .. '"')
-- end)
--
-- -- 3. Context-Aware Grep Mappings (Current dir vs Root)
-- -- Leader aa: Local search
-- vim.keymap.set('n', '<leader>aa', function()
--     local search = vim.fn.getreg('/')
--     return (vim.v.hlsearch == 1 and search:match([[\<]])) and "<leader>,aW" or "<leader>,aS"
-- end, { expr = true })
--
-- -- Leader ad: Search in current file's directory
-- vim.keymap.set('n', '<leader>ad', function()
--     local search = vim.fn.getreg('/')
--     local target = (vim.v.hlsearch == 1 and search:match([[\<]])) and "<leader>,aW" or "<leader>,aS"
--     return "<leader>cd" .. target .. ":lcd -<cr>"
-- end, { expr = true })
--
-- -- Leader ar: Search from Root (Fugitive Gcd)
-- vim.keymap.set('n', '<leader>ar', function()
--     local search = vim.fn.getreg('/')
--     local target = (vim.v.hlsearch == 1 and search:match([[\<]])) and "<leader>,aw" or "<leader>,as"
--     return "<leader>cr" .. target .. ":cd -<cr>"
-- end, { expr = true })
--------------------------------------------------------------------------------
-- CONTEXT-AWARE GREP
--------------------------------------------------------------------------------
local function smart_grep(target_dir)
    local search_reg = vim.fn.getreg('/')
    local cword = vim.fn.expand('<cword>')
    -- Using 'getcwd(0)' ensures we get the global CWD for the current window
    local original_cwd = vim.fn.getcwd(0)

    -- 1. Determine the search term
    local final_search = ""
    local is_word_search = false

    if vim.v.hlsearch == 1 and search_reg ~= "" then
        final_search = clean_search_reg()
        is_word_search = false
    else
        final_search = cword
        is_word_search = true
    end

    if final_search == "" then
        print("Grep: No term found.")
        return
    end

    -- 2. Handle Directory Jump
    if target_dir then
        if target_dir == "Gcd" then
            pcall(vim.cmd, "Gcd")
        else
            -- On Windows, we must wrap the path in quotes and handle backslashes
            -- We use 'cd' instead of 'lcd' temporarily to ensure the tool sees it
            vim.cmd('cd ' .. vim.fn.fnameescape(target_dir))
        end
    end

    -- 3. Execute the Grep
    local flag = is_word_search and "-w " or ""
    -- We wrap the search term in double quotes for the shell
    local cmd = 'MyGrep ' .. flag .. '"' .. final_search .. '"'

    -- Perform the search
    local status, err = pcall(vim.cmd, cmd)
    if not status then
        print("Grep Error: " .. tostring(err))
    end

    -- 4. Return Home (Crucial: always return to original_cwd)
    if target_dir then
        vim.cmd('cd ' .. vim.fn.fnameescape(original_cwd))
    end
end
-- Leader aa: Search in current project/cwd
vim.keymap.set('n', '<leader>aa', function()
    smart_grep()
end)

-- Leader ad: Search in current file's directory
vim.keymap.set('n', '<leader>ad', function()
    -- Expand the path in Lua before passing it to the function
    local dir = vim.fn.expand("%:p:h")
    smart_grep(dir)
end)

-- Leader ar: Search from Git Root
vim.keymap.set('n', '<leader>ar', function()
    smart_grep("Gcd")
end)

-- 4. Global Refactoring (MyCdo)
-- Uses the 'w' register for word boundaries or the clean search register
vim.keymap.set('n', '<leader>,rs', function()
    local search = vim.fn.getreg('/')
    search = vim.fn.substitute(search, [[\n$]], '', 'g')
    search = vim.fn.substitute(search, '/', [[\/]], 'g')
    vim.api.nvim_feedkeys(":MyCdo s/" .. search .. "//gIe", 'n', false)
    -- Feed keys used here to allow user to type the replacement and confirm
    local keys = vim.api.nvim_replace_termcodes("<left><left><left><left>", true, false, true)
    vim.api.nvim_feedkeys(keys, 'm', true)
end)

vim.keymap.set('n', '<leader>,rw', function()
    local word = vim.fn.getreg('w')
    vim.api.nvim_feedkeys(":MyCdo s/\\<" .. word .. "\\>//gIe", 'n', false)
    local keys = vim.api.nvim_replace_termcodes("<left><left><left><left>", true, false, true)
    vim.api.nvim_feedkeys(keys, 'm', true)
end)

-- Mapping to decide between word or raw search refactor
vim.keymap.set('n', '<leader>r', function()
    return vim.fn.getreg('w') ~= "" and "<leader>,rw" or "<leader>,rs"
end, { expr = true })

--------------------------------------------------------------------------------
-- EASY GLOBAL MARKS
--------------------------------------------------------------------------------
-- Open the marks preview (requires marks.nvim or similar)
vim.keymap.set('n', '<leader>`', '<cmd>Marks<cr>', { desc = "Show all marks" })

-- Generate global mark mappings (a-z)
-- This maps 'ma' to 'mA' (set mark) and '`a' to '`A' (jump to mark)
local alphabet = "abcdefghijklmnopqrstuvwxyz"

for i = 1, #alphabet do
    local char = alphabet:sub(i, i)
    local upper_char = char:upper()

    -- Set global mark: ma -> mA
    vim.keymap.set('n', 'm' .. char, 'm' .. upper_char, { desc = "Set global mark " .. upper_char })

    -- Jump to global mark: `a -> `A
    vim.keymap.set('n', '`' .. char, '`' .. upper_char, { desc = "Jump to global mark " .. upper_char })
end

--""""""""""""""""""""""""""""""""""""""""""""""""""
--"""""""""""""""""""" RETIRED """""""""""""""""""""
--""""""""""""""""""""""""""""""""""""""""""""""""""
--
--""""""""""""""""""""""""""""""""""""""""""""""""""
--"""""""""""""""""""" RETIRED """""""""""""""""""""
--""""""""""""""""""""""""""""""""""""""""""""""""""
--
--"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
--"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
--" NOTES
--"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
--"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- Folds
-- zR zM open/close all folds
-- zo zc open/close fold
-- zE remove all folds
--
-- ga will tell you the different binary represenations of the char under cursor
-- fzf works in the linux terminal:
-- cd **<tab> (or fzf's alt-c)
-- nvim **<tab> (or fzfs' nvim <c-t>)
-- <c-r> (linux reverse command search, fzf picks this up automatically)
--
-- tags <c-]>:
-- <c-t> will pop through the tag stack, g<c-]> will list ambiguous tag
--
-- vim's autocomplete:
-- good stuff documented in ins-completion
-- c-x c-n for just this buffer
-- c-x c-f for filenames (need to keep hitting the sequence after every slash)
-- c-x c-] for tags only
--
-- look up cfdo, quickfix list, location-list, vimgrep lvimgrep
-- if vim is launched from terminal ctrl-z will take you back to terminal. fg in terminal will take you back to vim (fg is for foreground)
-- gn and gN visually select the current search selction
-- gv will go to the last vis selction and select it
-- Auto generate remappings, targets.vim does this nicely
-- Example: noremap ci, T,ct,
-- Add other text objects to perform ci and ca with
-- n means jump to next pair, l means jump to last pair
-- SINGLE LINE VERSION
-- for charBound in [ "<Bar>", "/", "\\", "'", "`", "\"", "_", ".", ",", "*", "-", "&", "^", "+"]
--     for editType in ["c", "y"]
--         execute 'nnoremap ' . editType . 'i'  . charBound . ' T' . charBound . 'ct' . charBound
--         execute 'nnoremap ' . editType . 'in' . charBound . ' f' . charBound . ';T' . charBound . 'ct' . charBound
--         execute 'nnoremap ' . editType . 'il' . charBound . ' F' . charBound . ';f' . charBound . 'cT' . charBound
--     endfor
-- endfor
--
-- SEARCH VERSION
-- \d is a number
-- . is any char
-- \. is .
-- \s is white space
-- \S in non-white space
-- \a is letter
-- search quote with some non-white stuff in it /".*\S\+.*"
-- search quote with white stuff in it /"\s+"
-- search quote with nothing /""
-- search quote followed by \ or quote followed by any char /"\\\|".
-- nnoremap ci" ?"<cr>vNc""<Esc>:noh<cr>i
-- nnoremap cin" /".*\S\+.*"<cr>:noh<cr>iasdf
-- nnoremap cil" ?".*\S\+.*"<cr>cs""<Esc>:noh<cr>i
--
--NOTES:
-- c-r" to paste from register doublequote when in command/search/terminal
-- highlighing lines then doing a :w TEST will write those lines to TEST
-- :r TEST will put lines from test at the cursor
-- :r !ls will put the result of ls at the cursor
-- Re-flow comments by visually selecting it and hit gq
-- :qa! quits all without saving
-- :wqa! write and quits all
--  with tcomment_vim installed you can comment lines with gc when they are visually selected
-- possibly useful nomral mode keys:
-- ; will repeat t/T and f/F (line movement to and find) commonds. , will repeat reverse directio direction
-- c-w + s,v opens the same buffer in a horiz or vert split
-- K will search in man pages for the command under cursor (this has been remapped)
-- :sh will open a shell
-- di{ to delete method body, can do this with these as well: " ( [ ' <
-- daw deletes around(includes white space) word use this instead of db unless you really need db
-- :windo diffthis (diff windows in current tab, :diffoff! to turn it off)
-- :tab sball -> convert buffers to tabs
-- :mks! to save Session.vim in current folder
-- :source Session.vim to load its session config
-- c-n, c-p tab-like completion pulling from variety of sources (also for prompt navigation, prev, next)
-- c-x c-l whole line completion
-- c-x c-o syntax aware omnicompletion
-- see this for native vim auto complete https://robots.thoughtbot.com/vim-you-complete-me
-- clipboard reg 1 yank in word nmode: "1yiw vmode: "1y
-- paste in word from reg 1: nmode: viw"1p vmode: "1p
-- open prevoius file: <c-6> good for toggling .h and .cpp (can also use fzf's :History command <leader>hh)
-- paste in word from reg 1: nmode: viw"1p vmode: "1p
-- c-x subtracts 1 from number under curosr c-a adds 1
-- [{ ]} will jump to beginning and end of a {} scope
-- vip will highlight a block bound by blank lines
-- % will jump to (), [], [] on a line
--
-- In the "power of g" how do I do the display context of search across all files in project/pwd to do what sublime does?
-- https://vim.fandom.com/wiki/Power_of_g
-- gD go to def of word under cursor in current file
-- gd go to def of word under cursor in current function
-- g; goes to last edited position
-- gt (next tab) gT(prev tab) #gt (jump to tab #)
-- gf will open file under cursor, <c-w>gf to open file under cursor in a new tab
-- <c-<tab>> toggles to last used tab
-- :+tabmove,:-tabmove moves tabs around in the tablinee
-- gf will open file under cursor, <c-w>gf to open file under cursor in a new tab
-- :g/^\s*$/d - global delete lines containing regex(blank or whitespace-only lines)
-- :g/pattern/d _ - fast delete lines matching pattern
-- :g!/error\|warn\|fail/d - opposite of global delete (equivalent to global inverse delete (v//d)) keep the lines containing the regex(error or warn or fail)
-- :g/pattern/z#.5|echo "==========" - display context, 5 lines, of pattern
-- :g/pattern/t$  - copy all lines matching pattern to the end of the file
-- :g/pattern/m$  - move all lines matching pattern to the end of the file
-- qaq:g/pattern/y A Copy all lines matching a pattern to register 'a'. qa starts recording a macro to register a, then q stops recording, leaving the 'a' reg empty. y is yank, A is append to register a.
-- :g/pattern/normal @q - run macro recorded in q on matching lines
-- g<c-a> say you had a numbered list like this 1.1.1. example. if you select from the second 1 to the end and go g<c-a> it will increment them appropriately
-- 1.
-- 1.
-- 1.
-- 1.
-- 1.
--
-- INSERT MODE:
-- c-w   Delete word to the left of cursor
-- c-u   Delete everything to the left of cursor
-- c-o   Goes to normal mode to execute 1 normal mode command
-- c-a   Insert last inserted text
-- c-y   Hold down to start repeating text from the line above
-- c-r{register}   insert text from register (spit out macro register with <c-r>q, edit it and copy back into register after select with "qy)
-- COMMAND MODE:
-- ctrl-n, p next previous command in history
-- c-f will pop up a buffer of previous command history, you can edit like a normal buffer and hit enter to execute
-- c-f will do the same thing for / searching
-- c-v  followed by an action key, say delete, will insert <Del>
--
-- COMPLETION:
-- c-x c-f filepath completion
-- c-x c-o "omni" completion, code aware completion
-- c-x c-l line completion
-- c-x c-d macro completion
-- c-x c-i current and included files
-- c-x c-] tags
--
-- [ COMMANDS (The ] key is the forward version of the [ key)
-- [ ctrl-i jump to first line in current and included files that contains the word under the cursor
-- [ ctrl-d jump to first #define found in current and included files matching the word under cursor
-- [/ cursor n times back to start of // comment
-- [( cursor n times back to unmatched (
-- [{ cursor n times back to unmatched {
-- [[ cursor n times back to unmatched [
-- [D list all defines found in current and included files matching word under cursor
-- [I list all lines found in current and included files matching word under cursor
-- [m cursor n times back to start of member function
--
-- REGISTERS
-- :reg to list whats in all the registers
-- @: uses this register to execute the command again
-- Editing macros since they are stored in registers: For example, if you forgot to add a semicolon in the end of that w macro, just do something like :let @W='i;'. Noticed the uppercase W
-- That’s just how we append a value to a register, using its upcased name, so here we are just appending the command i; to the register, to enter insert mode (i) and add a semicolon.
-- If you need to edit something in the middle of the register, just do :let @w='<Ctrl-r w>, change what you want, and close the quotes in the end. Done, no more recording a macro 10 times before you get it right.
-- "" is the unamed register (d,x,s,c) will go there
-- "0 is the last yank, 1-9 are the deletes, youngest to oldest
-- ". is THE LAST INSTERTED TEXT, GOOD FOR REPEATED PASTES
-- "% is the current file name
-- ": most recent command. Ex: if you saved with :w then w will be in this reg
-- "+ is the system clipboard for copying into and out of vim
-- "# is the name of the last edited file (what vim uses for c-6)
-- "= is the expression regiser: This is easier to understand with an example. If, in insert mode, you type Ctrl-r =, you will see a “=” sign in the command line. Then if you type 2+2 <enter>, 4 will be printed.
-- This can be used to execute all sort of expressions, even calling external commands. To give another example, if you type Ctrl-r = and then, in the command line, system('ls') <enter>, the output of the ls command will be pasted in your buffer
-- "/ is the search register, the last thing searched for
--
-- Jump to tag. / will do fuzzy match
-- nnoremap <leader>j :tjump /
--
-- list the buffers and prepare open buffer command
-- nnoremap <leader>b :ls<CR>:b<space>
--
-- Bad but might have nugget of good idea
-- Bind p in visual mode to paste without overriding the current register
-- bad: this will put you back to your previous visual selection which is annoying, need to figure out how to go back to where you pasted
-- nnoremap p pgvy
--
-- quickfix list
-- :copen " Open the quickfix window
-- :ccl   " Close it
-- :cw    " Open it if there are errors, close it otherwise
-- :cn    " Go to the next error in the window
-- :cnf   " Go to the first error in the next file
--
-- Vim script guide :h usr_41.txt
--
-- arg example
-- :args *.c
-- :argadd file1 file2 file3
-- :argdo %s/\<x_cnt\>/x_counter/gIe | update
-- others: windo bufdo cdo cfdo ldo
--
-- ctags (use Universal ctags)
-- use tagbar or c-] or :tag someTag or <leader>t
-- :ptag someTag will open a preview window for the tag and put the cursor back where it was so you can keep typing
-- use :pclose to close preview window
--
--If you want to complete system functions you can do something like this.  Use
-- ctags to generate a tags file for all the system header files:
--     % ctags -R -f ~/.vim/systags /usr/include /usr/local/include
-- In your vimrc file add this tags file to the 'tags' option:
--     set tags+=~/.vim/systags
--
-- :Cfilter some-string to filter the quickfix list, :Cfilter will grab entries not matching some-string
-- :Cfilter[!] /{pat}/
-- :Lfilter[!] /{pat}/
-- packadd cfilter
--
-- Toggle header and source
-- :e file:p is full path of file. the :s are a chain of substitutes the , are the sub delimiters
-- the X123X is just for putting an X123X extension on it.
-- this only works if in the same directory
-- nnoremap <A-o> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<cr>
--
-- fugitive notes:
-- :Gdiffsplit        - show git diff for file or provide a file or commit as an arg (newer version is on right or bottom)
--                         - do will obtain theirs (other buffer)
--                         - dp will put ours (current buffer)
-- :Gdiffsplit!       - used for merge conflict?
-- :Gread             - git checkout -- on this file.
-- :Gwrite            - git add the file. stage it otherwise.
-- :GRename           - git mv this file to path relative to the file
-- :GDelete!          - git rm -f this file
-- :GRemove           - git rm --cached (keeps the file around)
-- :[range]Gclog      - wow. vis something :Gclog for quckfix of commits relating to selected code will load up diff of the file for that commit
-- G                  - place to stage and unstage files
--                    - '-' toggle stage status
--                    - U unstage all
--                    - X checkout file (a command is echoed to undo this see :messages to see again)
--                    - = toggle diff fold
-- :G blame           - A vertical window on left showing commit hashes. Can walk backwards through git commits to follow history of changes with <cr> for patch or - to load up file at commit and rerun G blame.
-- :G difftool        - quickfix of line changes in the current file
-- :G diff            - open a split and show the normal git diff but for only this file
-- :Gclog or G log    - like fzf's :Commits - open quickfix or split of commit hashes and their messages, press enter to open a buffer showing its patch diff.


