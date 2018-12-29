"""""" ENCODING """"""
set encoding=utf-8

"""""" DIR CONFIG """"""
" Store backup, undo, and swap files in temp directory
set directory=D:/Program\ Files\ (x86)/Vim/temp//
set backupdir=D:/Program\ Files\ (x86)/Vim/temp//
set undodir=D:/Program\ Files\ (x86)/Vim/temp//

"""""" LEADER KEY """"""
let mapleader=","       " leader is comma

"""""" UI CONFIG """"""
if has('gui_running')
  set guifont=Consolas:h11:cANSI:qDRAFT     " set gui font
  set guifontwide=NSimsun:h12               " set gui font for utf-8 chars
endif
set backspace=indent,eol,start              " in Insert Mode, allow backspace through indent, end of line and previous content.
set number              " show line number
set cursorline          " highlight current line
set showcmd             " show command in bottom bar
filetype indent on      " load filetype-specific indent file
set wildmenu            " show visual menu for command auto-complete
set lazyredraw          " redraw only when we need to (improves performance)
set showmatch           " highlight matching [{()}]

"""""" SPELL CHECK CONFIG """"""
set spell

"""""" SPACES, TABS AND INDENTATION CONFIG """"""
set tabstop=4           " number of visual spaces per TAB
set expandtab           " tabs are spaces
set softtabstop=4     " number of spaces in tab when editing
set shiftwidth=4        " number of spaces per indentation
set formatoptions-=tc     " Don't limit line length 
                                           "( vim's default "set textwidth=0" should have the same behavior but it could be overriden by some filetype plug-ins)

"""""" SEARCHING CONFIG """"""
set incsearch           " search as characters are being entered
set hlsearch            " highlight matches

"""""" FOLDING CONFIG """"""
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default

"""""" NAVIGATION CONFIG """"""
" use ijkl instead of hjkl
" also move vertically by visual line instead of unwrapped line
" (remember use "h" for insert, "chw" for changing wHole word)
"noremap i gk
"noremap j h
"noremap k gj
"noremap h i

" move vertically by visual line for hjkl configuration
nnoremap j gj
nnoremap k gk

" move across lines with cursor keys
set whichwrap+=<,>,[,]
" move across lines with h and l
"set whichwrap+=h,l

" toggle zero: pressing "0" first (and odd) number of times behaves like "^"; second (and even) number of times goes to start of line.
function! ToggleZero()
  let pos = getpos('.')
  execute "normal! ^"
  if pos == getpos('.')
    execute "normal! 0"
  endif
endfunction
nnoremap 0 :call ToggleZero()<CR>

" use 4 to move to end of line (and $ for the number 4)
noremap 4 $
noremap $ 4

" prevent cursur from moving back one character when exiting insert-mode
let CursorColumnI = 0 "the cursor column position in INSERT
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

"""""" NORMAL MODE SHORTCUTS """"""
" select last inserted text
nnoremap gV `[v`]

" Insert empty line before current line
nmap <S-Enter> O<Esc>
" Insert empty line after current line
nmap <CR> o<Esc>
" Insert space after cursor
nnoremap <Space> a<Space><ESC>h
" Insert space before cursor
nnoremap <S-Space> i<Space><ESC>l

" Join current line with previous line
nnoremap K kJ

" Swap line with previous/next line
nnoremap <silent><A-k> :let save_o=@o<CR><Up>"odd"op<Up>:let @o=save_o<CR>
nnoremap <silent><A-j> :let save_o=@o<CR>"odd"op:let @o=save_o<CR>
" Swap Visual Mode selection with previous/next line (side effect: overwrites the o register)
" (Note Visual Line has different implementation from other Visual Mode)
xnoremap <silent><expr> <A-k> mode() ==# "V" ? "\"od<Up>\"oP`[V`]l" : "\"od<Up>\"oP`[v`]l"
xnoremap <silent><expr> <A-j> mode() ==# "V" ? "\"od\"op`[V`]l" : "\"od<Down>\"oP`[v`]l"

" Highlight same word under cursor
nnoremap <leader><space> * #

"""""" INSERT MODE SHORTCUTS """"""
" insert mode navigation/editing
imap <A-h> <LEFT>
imap <A-j> <C-O>gj
imap <A-k> <C-O>gk
imap <A-l> <RIGHT>
imap <A-w> <C-O>w
imap <A-W> <C-O>W
imap <A-b> <C-O>b
imap <A-B> <C-O>B
imap <A-e> <C-O>e
imap <A-E> <C-O>E
imap <A-a> <C-O>zz
imap ° <C-O>0
imap ´ <C-O>4
imap <C-A-b> <C-O><C-B>
imap <C-A-f> <C-O><C-F>
imap <C-A-u> <C-O><C-u>
imap <C-A-d> <C-O><C-d>
imap <A-f> <C-O>f
imap <A-;> <C-O>;
imap <A-,> <C-O>,
imap <A-F> <C-O>F
imap <A-t> <C-O>t
imap <A-T> <C-O>T
imap <A-u> <Esc>u
imap <A-U> <Esc>U
imap <A-o> <C-O>o
imap <A-O> <C-O>O
imap <A-z> <BS>
imap <A-x> <Del>
imap <A-d><A-d> <C-O>dd
imap <A-c> <C-O>ciw
imap <A-C> <C-O>ciW
imap <A-v> <C-O>v
imap <A-V> <C-O>V
imap <A-q> <C-O><C-Q>
imap <A-n> <C-O>n
imap <A-N> <C-O>N
imap <A-m> <C-O>m

" break undo sequence without leaving Insert Mode
inoremap <A-Space> <C-G>u

"""""" LEADER SHORTCUTS """"""
" map shortcut for turning off search highlight
nnoremap <leader><backspace> :nohlsearch<CR>

" toggle gundo (get at https://github.com/sjl/gundo.vim)
nnoremap <leader>u :GundoToggle<CR>

" save session
nnoremap <leader>s :mksession<CR>

" open ag.vim (get at https://github.com/rking/ag.vim)
nnoremap <leader>a :Ag

" CtrlP https://github.com/kien/ctrlp.vim

"""""" OTHER SHORTCUTS """"""
" Alt+i is escape
imap <A-i> <Esc>
vmap <A-i> <Esc>
" Alt+; is :
map <A-;> :
" Alt+1 is ! (does not work)
imap ± !
" Alt+2 is @ (does not work)
imap ² @
" Alt+m is Enter
imap <A-m> <CR> 

" Use the Tab key to switch windows created by the :sp command. It also sets
" the current file path to that of the file in the window that gains focus.
" EDIT: Disabled map because <Tab> in vim is strictly equivalent to <C-i>,
" which is used to navigate forward in the jump list. 
" Map to <C-tab> instead (actually this is mapped in mswin.vim by default)
set autochdir
"noremap <Tab> <C-W>w:cd %:p:h<CR>:<CR>
noremap <S-Tab> <C-W>W:cd %:p:h<CR>:<CR>
noremap <C-Tab> <C-W>w:cd %:p:h<CR>:<CR>


"""""" UNMAP GVIM FOR WINDOWS SHORTCUTS in mswin.vim """"""
"""""" (or provide substitute for overrided shortcuts) """"""
" Next page (opens GUI search panel in gwim for windows)
" (Pairs with <C-B>)
unmap <C-F>
" Scroll up one line (<C-Y> is mapped to be the same as <C-R> in windows)
" (Pairs with <C-E>)
" (<C-@> is somehow the only usable Ctrl+Number)
nnoremap <C-@> <C-Y>
" Increment/Decrement number (substitute for <C-A> and <C-X>)
:nnoremap <A-a> <C-a>
:nnoremap <A-x> <C-x>

" Don't use ALT key for GUI menu (F10 can still be used to focus on menu)
set winaltkeys=no
