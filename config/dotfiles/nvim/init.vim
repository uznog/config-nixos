" Description {{{
" ===========
" Fisa-nvim-config
" http://nvim.fisadev.com
" version: 10.0
" ============================================================================
" }}}

" Vim-plug initialization {{{
" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" ============================================================================
" }}}

" Active plugins {{{

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin('~/.config/nvim/plugged')

"
" ============== Basic plugins ====================
"

" Terminal Vim with 256 colors colorscheme
Plug 'fisadev/fisa-vim-colorscheme'

" Molokai colorscheme 
"Plug 'fatih/molokai'

" Nord colorscheme
Plug 'arcticicestudio/nord-vim'

" Base16 colorscheme
" Plug 'chriskempson/base16-vim'

" Tmux Vim-like navigation
Plug 'christoomey/vim-tmux-navigator'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Better file browser
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}

" Search results counter
Plug 'vim-scripts/IndexedSearch'

" Window chooser
Plug 't9md/vim-choosewin'


" Relative numbering of lines (0 is the current line)
Plug 'myusuf3/numbers.vim'

" Find differences between directories
Plug 'will133/vim-dirdiff'

" Start screen
Plug 'mhinz/vim-startify'

"
" ============== Coding plugins ====================
"


Plug 'nvim-lua/completion-nvim'
"Plug 'nvim-treesitter/nvim-treesitter'
Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
Plug 'junegunn/fzf.vim'  " to enable preview (optional)
"Plug 'ojroques/nvim-lspfuzzy'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" TreeSitter

" Language Server for nvim
"Plug 'neovim/nvim-lspconfig'

" Utils for nvim lsp
"Plug 'RishabhRD/popfix'
"Plug 'RishabhRD/nvim-lsputils'

" Nix support
Plug 'LnL7/vim-nix'

" Surround
Plug 'tpope/vim-surround'

" Show func/class structure of file
Plug 'majutsushi/tagbar'

" Indent text object
Plug 'michaeljsmith/vim-indent-object'

" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'


" Code commenter
Plug 'scrooloose/nerdcommenter'

" Automatically close parenthesis, etc
Plug 'jiangmiao/auto-pairs'

" Completion from other opened files
Plug 'Shougo/context_filetype.vim'

" Git integration
Plug 'tpope/vim-fugitive'

" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'

" Yank history navigation
Plug 'vim-scripts/YankRing.vim'

"
" ============== Python plugins ====================
"

" Python syntax colors
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" Python folding
Plug 'tmhedberg/SimpylFold'

"
" ============== Go plugins ====================
"

" Main
Plug 'fatih/vim-go'
"Plug 'stamblerre/gocode'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

"
" ============== HTML/CSS plugins ====================
"

" Highlight matching html tags
Plug 'valloric/MatchTagAlways'

" Generate html in a simple way
Plug 'mattn/emmet-vim'

" Paint css colors with the real color
Plug 'lilydjwg/colorizer'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" }}}

" Install Plugin Initialization {{{

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" }}}

" Plugins settings and mappings {{{
" #autocmd BufEnter * lua require'completion'.on_attach()


let g:UltiSnipsExpandTrigger="<C-Tab>"
let g:UltiSnipsJumpForwardTrigger="<C-k>"
let g:UltiSnipsJumpBackwardTrigger="<C-j>"
let g:completion_enable_snippet = 'UltiSnips'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Tagbar -----------------------------

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 0

" NERDTree -----------------------------

" toggle nerdtree display
"map <F3> :NERDTreeToggle<CR>
nnoremap <F3> <cmd>CHADopen<cr>

" open nerdtree with the current file selected
"nmap ,t :NERDTreeFind<CR>

" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']


" LSP - let's hope this works >.<
" lua require('uz.lsp')

" Compe --------------------------------
"set completeopt=menuone,noselect

"let g:compe = {}
"let g:compe.enabled = v:true
"let g:compe.autocomplete = v:true
"let g:compe.debug = v:false
"let g:compe.min_length = 1
"let g:compe.preselect = 'enable'
"let g:compe.throttle_time = 80
"let g:compe.source_timeout = 200
"let g:compe.incomplete_delay = 400
"let g:compe.max_abbr_width = 100
"let g:compe.max_kind_width = 100
"let g:compe.max_menu_width = 100
"let g:compe.documentation = v:true

"let g:compe.source = {}
"let g:compe.source.path = v:true
"let g:compe.source.buffer = v:true
"let g:compe.source.calc = v:true
"let g:compe.source.vsnip = v:true
"let g:compe.source.nvim_lsp = v:true
"let g:compe.source.nvim_lua = v:true
"let g:compe.source.spell = v:true
"let g:compe.source.tags = v:true
"let g:compe.source.snippets_nvim = v:true
"let g:compe.source.treesitter = v:true

"let g:lexima_no_default_rules = v:true
"call lexima#set_default_rules()
"inoremap <silent><expr> <C-Space> compe#complete()
"inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))
"inoremap <silent><expr> <C-e>     compe#close('<C-e>')
"inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
"inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

"lua require 'gz.compe'

" CoC ----------------------------------


" Move in longer floating windows
"nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Show docs in floating
"nnoremap <silent> K :call CocActionAsync('doHover')<cr>

" Invoke completions with <C-Space>
"inoremap <silent><expr> <c-space> coc#refresh()


" Deoplete -----------------------------

" complete with words from any opened file
let g:context_filetype#same_filetypes       = {}
let g:context_filetype#same_filetypes._     = '_'

" needed so deoplete can auto select the first suggestion
"set completeopt+=noinsert
" comment this line to enable autocompletion doc in preview window
"set completeopt-=preview

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1


" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = [ 'git', 'hg' ]
" mappings to jump to changed blocks
nmap ,sn <plug>(signify-next-hunk)
nmap ,sp <plug>(signify-prev-hunk)

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Yankring -------------------------------

" Fix for yankring and neovim problem when system has non-text things copied
" in clipboard
let g:yankring_clipboard_monitor = 0
let g:yankring_history_dir = '~/.config/nvim/'
set clipboard+=unnamed,unnamedplus

" Airline ------------------------------

let g:airline_powerline_fonts = 1
let g:airline_theme = 'nord'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1

" to use fancy symbols for airline, uncomment the following lines and use a
" patched font (more info on docs/fancy_symbols.rst)
if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Startify -----------------------------
let g:startify_session_dir = '~/.config/nvim/session'


let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']                        },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']                     },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                    },
          \ ]


let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 1

let g:webdevicons_enable_startify = 1

"function! StartifyEntryFormat()
        "return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
    "endfunction

let g:startify_bookmarks = [
            \ { 'a': '~/.config/alacritty/alacritty.yml' },
            \ { 's': '~/.config/starship.toml' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'b': '~/.bashrc' },
            \ '~/src/snowdog',
            \ ]

let g:startify_enable_special = 0

" }}}

" Vim settings and mappings {{{

" Mapping for <leader>
let mapleader = ","

set runtimepath^=~/.config/nvim/ftplugin

au BufNewFile,BufRead /*etc/icinga2/*.conf,/*usr/share/icinga2/include/{itl,plugins,*.conf} set filetype=icinga2

" Paste and yank to + buffer
map <Leader>p "+p
map <Leader>y "+y

" Run macro from letter d
nnoremap <leader><Space> @d 

" Quick exit
nmap <leader>e :exit <CR>
" Quick write and exit
nmap <leader>w :wg <CR>

" save as sudo
cmap w!! w !sudo tee %

" enable highlighting current line
set cursorline

" don't show things like -- INSERT -- 
set noshowmode

" Always show signcolumn
set signcolumn=yes

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" show line numbers
set nu

" don't wrap long lines
set nowrap

" remove ugly vertical lines on window division
set fillchars+=vert:\ 

" Access colors present in 256 colorspace
let base16colorspace=256  

" colorscheme
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme nord

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" tab navigation mappings
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

" TAB in general mode will move to text buffer
"nnoremap <silent> <C-Tab> :bnext<CR>

" SHIFT-TAB will go back
"nnoremap <silent> <S-TAB> :bprevious<CR>

" CTRL-TAB to close buffer
"nnoremap <silent> <C-w>  :bdelete<CR>


" Horizontal splits - spawn below
set splitbelow

" Vertical splits - spawn right
set splitright

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" clear search results
nnoremap <silent> // :noh<CR>


" fix problems with uncommon shells (fish, xonsh) and plugins running commands

" Move naturally between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Set foldmethod
setlocal foldmethod=marker

" Fold with spacebar in normal mode
nnoremap <space> za

" better backup, swap and undos storage -----

" directory to place swap files in
set directory=~/.config/nvim/dirs/tmp
" make backup files
set backup       
" where to put backup files
set backupdir=~/.config/nvim/dirs/backups
" persistent undos - undo after you re-open the file
set undofile                      
set undodir=~/.config/nvim/dirs/undos
set viminfo+=n~/.config/nvim/dirs/viminfo

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" don't use swapfile
set noswapfile

" ============================================================================
" }}}

" Highlights - colors customization {{{
"hi DiffAdd           cterm=bold ctermbg=none ctermfg=119
"hi DiffDelete        cterm=bold ctermbg=none ctermfg=167
"hi DiffChange        cterm=bold ctermbg=none ctermfg=227
"hi SpellBad          cterm=underline ctermbg=none ctermfg=167
"hi SpellCap          cterm=underline ctermbg=none ctermfg=167
"hi Error             cterm=bold ctermbg=none ctermfg=167
"hi CursorColumn      ctermbg=none
"hi SignifySignAdd    cterm=bold ctermbg=none  ctermfg=119
"hi SignifySignDelete cterm=bold ctermbg=none  ctermfg=167
"hi SignifySignChange cterm=bold ctermbg=none  ctermfg=227
"hi ErrorMsg          cterm=bold ctermbg=none ctermfg=167
"hi MatchParen        cterm=bold ctermbg=none ctermfg=202
"hi SpellLocal        cterm=none ctermbg=none ctermfg=227
"hi Search            cterm=bold ctermbg=none ctermfg=119
"hi Visual            cterm=reverse ctermbg=none
"hi SignColumn        ctermbg=none
"hi Folded            ctermbg=none ctermfg=blue
"hi Pmenu             ctermbg=236 ctermfg=7
"hi PmenuSel          cterm=bold ctermbg=238 ctermfg=208
"hi VertSplit         cterm=none ctermbg=none ctermfg=none
"hi CursorLineNr      ctermfg=208
"hi LineNr            ctermfg=249
"hi CursorLine        ctermbg=236
"hi NormalFloat       ctermbg=235

hi LspDiagnosticsDefaultError cterm=bold ctermfg=167
hi LspReferenceRead  cterm=bold ctermbg=none ctermfg=202
hi LspReferenceText  cterm=bold ctermbg=none ctermfg=202
hi LspReferenceWrite cterm=bold ctermbg=none ctermfg=202

function SemshiHighlights()
    hi semshiBuiltin ctermfg=39
endfunction

autocmd FileType python call SemshiHighlights()
"}}}
