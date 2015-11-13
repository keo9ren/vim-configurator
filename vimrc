" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

"vim-pathogen (plugin-manager)
execute pathogen#infect()
if has("syntax")
     syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

if has("autocmd")
	filetype plugin indent on
endif
" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

set cursorline
set ruler
set showmode
set wildmenu
set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)


" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

if has("gui_running")
	colorscheme meta5
else
	colorscheme darkblue
endif
" To ignore plugin indent changes, instead use:
"filetype plugin on



"size of window
set lines=999 columns=150

set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

"Strg-s für Speichern
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" Shortcuts for moving between tabs.
" Alt-j to move to the tab to the left
noremap <A-j> gT
" Alt-k to move to the tab to the right
noremap <A-k> gt

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=999
" Use UTF-8.
set encoding=utf-8

" Status line
set laststatus=2
set statusline=
set statusline+=%3.3n\		"buffer number
set statusline+=%f\		"filename
set statusline+=%h%m%r%w	"status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] "filetype
set statusline+=%=		"right align remainder
set statusline+=0x%-8B		"character value
set statusline+=%-14(%l,%c%V%)	"line, character
set statusline+=%<%P		"file position

let  g:C_UseTool_cmake    = 'yes'
let  g:C_UseTool_doxygen = 'yes' 

"begin clang-format
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>
"end clang-format
"NERDtree
"startsup automatically
"autocmd vimenter * NERDTree
"
"YCM py file for c
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"


"okular latex
function! SyncTexForward()
    let execstr = "silent !okular --unique %:p:r.pdf\\#src:".line(".")."%:p &"
    exec execstr
endfunction

"shortcut
nmap <Leader>f :call SyncTexForward()<CR>
let b:easytags_auto_highlight = 0
" open easytags on the rigth
nnoremap <F3> :TlistToggle<CR>
let Tlist_Use_Right_Window   = 1
"
map <F2> :NERDTreeTabsToggle<CR>
" change root to file automatically
"set autochdir
" set spellcheck automatically if *.tex is loaded
"autocmd BufNewFile,BufRead *.tex set spell
" ClangFormat
nnoremap <F5> :ClangFormat<CR>
"Latex suite search with okular
function! SyncTexForward()
   let execstr = "silent !okular --unique %:p:r.pdf\\#src:".line(".")."%:p &"
   exec execstr
endfunction
nmap <Leader>f :call SyncTexForward()<CR>
