" Don't try to be vi compatible
set nocompatible

" Line numbers
set number

" enable mouse
set mouse=a

" Sync clipboard between OS and vim
set clipboard=unnamedplus

" Enable break indent
set breakindent
filetype on
syntax on
set autoindent autoread background=dark
set backspace=indent,eol,start belloff=all
set display=lastline encoding=utf-8 hidden
set history=10000 hlsearch incsearch
set nojoinspaces laststatus=2 ruler
set showcmd smarttab nostartofline
set switchbuf=usetab,newtab wildmenu "wildoptions=pum,tagfile

" Enable undo history
set undodir=~/.local/state/vim/undo//
set undofile

" Keep signcolumn on by default
set signcolumn=yes

" Decrease update time
set updatetime=250

" Decrease mapped sequence wait time
" Displays vim-which-key sooner
set timeoutlen=300

" Case-insensitive searching UNLESS \C or capital in search
set ignorecase
set smartcase

" Configure how new splits should be opened
set splitright
set splitbelow

" Sets how vim will display certain whitespace characters in the editor.
set list
set listchars=tab:»\ ,trail:·,nbsp:␣

let mapleader=' '
let maplocalleader=' '

" Keybinds to make split navigation easier.
"  Use CTRL+<hjkl> to switch between windows
"
"  See `:help wincmd` for a list of all window commands
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>

" Map esc to disable hlsearch
nnoremap <esc><esc> :silent! nohls<cr>

" Tab navigation like Firefox.
nnoremap <C-S-h> :sbprevious<CR>
nnoremap <C-S-l> :sbnext<CR>

" Plugins
call plug#begin()
" Detect tabstop and shiftwidth automatically
Plug 'tpope/vim-sleuth'

" Adds git related signs to the gutter
Plug 'airblade/vim-gitgutter'

" Useful plugin to show you pending keybinds.
Plug 'liuchengxu/vim-which-key'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" GitHub Copilot
Plug 'github/copilot.vim'

" Enable LSP
Plug 'prabirshrestha/vim-lsp'

" Install language servers and configure them for vim-lsp
Plug 'mattn/vim-lsp-settings'

Plug 'ntpeters/vim-better-whitespace'

" Autocompletion
"Plug 'prabirshrestha/asyncomplete.vim'
" Use <Tab> to auto complete
Plug 'ervandew/supertab'

" [ Visual ]
" Colorscheme
Plug 'ericbn/vim-solarized'
call plug#end()

" [[ Configure vim-which-key ]]

call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  '<Space>'<CR>

" Document existing key chains
let g:which_key_map =  {}
let g:which_key_map.c = { 'name' : '[C]ode' }
let g:which_key_map.d = { 'name' : '[D]ocument' }
let g:which_key_map.f = { 'name' : '(F)ind'}
let g:which_key_map.r = { 'name' : '[R]ename' }
let g:which_key_map.w = { 'name' : '[W]orkspace' }

" [[ Configure fzf.vim ]]
" See `:help fzf-vim`
nmap <leader>ff :Files<CR>
let g:which_key_map.f.f = { 'name' : '(F)ind (F)iles '}
nmap <leader>fh :Helptags<CR>
let g:which_key_map.f.h = '(F)ind [H]elp'
nmap <leader>fk :Maps<CR>
let g:which_key_map.f.k = '(F)ind [K]eymaps'
nmap <leader>fg :Rg<CR>
let g:which_key_map.f.g = '(F)ind by [G]rep'
nmap <leader>f. :History<CR>
let g:which_key_map.f['.'] = '(F)ind Recent Files ("." for repeat)'
nmap <leader><leader> :Buffers<CR>
let g:which_key_map[' '] = '[ ] Find existing buffers'

nmap <leader>/ :BLines<CR>
let g:which_key_map['/'] = '[/] Fuzzily search in current buffer'

" [[ Configure LSP ]]
" NOTE: Install new language server using `:LspInstallServer` in the filetype
" you are trying to install LSP for.
" For example, if you want LSP server for C/C++, type
" `:LspInstallServer clangd` in a C/C++ buffer.

" Performance related settings, requires Vim 8.2+
let g:lsp_use_native_client = 1
let g:lsp_semantic_enabled = 0
let g:lsp_format_sync_timeout = 1000
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_echo_cursor = 0


function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

    " Keymaps
    " Go to previous diagnostic message
    nmap <buffer> [d <plug>(lsp-previous-diagnostic)
    " Go to next diagnostic message
    nmap <buffer> ]d <plug>(lsp-next-diagnostic)

    nmap <buffer> <leader>rn <plug>(lsp-rename)
    let g:which_key_map.r.n = '[R]e[n]ame'
    nmap <buffer> <leader>ca <plug>(lsp-code-action-float)
    let g:which_key_map.c.a = '[C]ode [A]ction'

    " [G]oto [D]efinition
    nmap <buffer> gd <plug>(lsp-definition)
    " [G]oto [R]eferences
    nmap <buffer> gr <plug>(lsp-references)
    " [G]oto [I]mplementation
    nmap <buffer> gI <plug>(lsp-implementation)

    nmap <buffer> <leader>D <plug>(lsp-peek-type-definition)
    let g:which_key_map.D = 'Type [D]efinition'
    nmap <buffer> <leader>ds <plug>(lsp-document-symbol-search)
    let g:which_key_map.d.s = '[D]ocument [S]ymbols'
    nmap <buffer> <leader>ws <plug>(lsp-workspace-symbol-search)
    let g:which_key_map.w.s = '[W]orkspace [S]ymbols'

  " See `:help K` for why this keymap
  " Hover Documentation
  nmap <buffer> K <plug>(lsp-hover)
  " Signature Documentation
  nmap <buffer> <C-k> <plug>(lsp-signature-help)

  " Lesser used LSP functionality
  " [G]oto [D]eclaration
  nmap <buffer> gD <plug>(lsp-declaration)

  " Create a command `:Format` local to the LSP buffer
  command! Format LspDocumentFormatSync
endfunction

augroup lsp_install
  au!
  " call s:on_lsp_buffer_enabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" [[ Configure completion ]]
" Set Omni Completion
"  See `:help compl-omni` and `:help omnifunc`
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Enter key confirms the current selection when completion is open
inoremap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'

" <Tab> triggers Omni completion (<C-x><C-o>) in a coding context
let g:SuperTabDefaultCompletionType = "context"

" [[ Configure visual settings ]]
let g:solarized_base16 = 1

if (has("termguicolors"))
  set termguicolors
endif

" Check current gui theme by running darkman get
function! CheckDarkman()
    let output = system('darkman get')

    if output =~ "light"
        set background=light
    else
        set background=dark
    endif

    if !v:shell_error
        return 0
    endif

endfunction

colorscheme solarized

autocmd VimEnter * call CheckDarkman()
