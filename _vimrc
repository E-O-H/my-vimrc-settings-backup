"""""" ENCODING """"""
set encoding=utf-8

"""""" DIR CONFIG """"""
" Store swap, backup and undo files in temp directory
set directory=D:/vim_swap_backup_undo_files//
set backupdir=D:/vim_swap_backup_undo_files//
set undodir=D:/vim_swap_backup_undo_files//

"""""" COLOR SCHEME """"""
syntax on                       " turn on syntax highlighting
                                " note this must be set BEFORE color configuration or some colors can be overriden
colo morning                                         " color scheme theme
hi CursorLine   cterm=NONE ctermbg=2 guibg=#88ddff   " line highlight color
hi CursorColumn cterm=NONE ctermbg=6 guibg=#ffc0cb   " column highlight color
" Note Cursor can only be changed for GVim; terminal cursor is always determined by the terminal.
hi Cursor  guifg=white guibg=blue                    " GUI cursor color
hi iCursor guifg=white guibg=blue                    " GUI cursor color (insert-mode)

"""""" UI CONFIG """"""
if has('gui_running')
  set guifont=Consolas:h11:cANSI:qDRAFT     " set gui font
  set guifontwide=NSimsun:h12               " set gui font for utf-8 chars
endif
set backspace=indent,eol,start              " in Insert Mode, allow backspace through indent, end of line and previous content.
set number              " show line number
set relativenumber      " show relative line number (to current line)
set ruler               " display current position of the cursor in status bar
set cursorline          " highlight current line
set cursorcolumn        " highlight current column
set showcmd             " show command in bottom bar
set wildmenu            " show visual menu for command auto-complete
set showmatch           " highlight matching [{()}]
set lazyredraw          " redraw only when we need to (improves performance)
"set noerrorbells        " no alert sound
"set visualbell          " use visual alert
set belloff=all         " no any alert

"""""" SPELL CHECK CONFIG """"""
set spell

"""""" SPACES, TABS AND INDENTATION CONFIG """"""
filetype indent on      " load filetype-specific indent file
set autoindent          " auto-indent after pressing enter
set tabstop=4           " number of visual spaces per TAB
set expandtab           " tabs are spaces
set softtabstop=4       " number of spaces in tab when editing
set shiftwidth=4        " number of spaces per indentation
set textwidth=0         " limit line length (auto line-breaking); 0 means no limit
set linebreak           " set auto line-breaking to not break inside a word
set formatoptions-=tc   " Don't limit line length 
                        "( vim's default "set textwidth=0" should have the same behavior but it could be overriden by some filetype plug-ins)

"""""" SEARCHING CONFIG """"""
set incsearch           " search as characters are being entered
set hlsearch            " highlight matches
set ignorecase          " default to case insensitive
set smartcase           " auto case sensitive when there is uppercase letter

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

" toggle relative line number
function! ToggleLineNumber()
    set relativenumber!
endfunction
nnoremap ,l :call ToggleLineNumber()<CR>


" use 4 to move to end of line (and $ for the number 4)
"noremap 4 $
"noremap $ 4

" prevent cursur from moving back one character when exiting insert-mode
"let CursorColumnI = 0 "the cursor column position in INSERT
"autocmd InsertEnter * let CursorColumnI = col('.')
"autocmd CursorMovedI * let CursorColumnI = col('.')
"autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

"""""" MULTI-WINDOW CONFIG """"""
set autochdir     " change working directory according to active window

" Shortcut to switch between windows created by the :sp or :vs command. It also sets 
" the current file path to that of the file in the window that gains focus.
" EDIT: Disabled <Tab> map because <Tab> in vim is strictly equivalent to 
"<C-i>, which is used to navigate forward in the jump list. 
" Map to <C-tab> instead (actually this is mapped in mswin.vim by default)
"noremap <Tab> <C-W>w:cd %:p:h<CR>:<CR>
noremap <S-Tab> <C-W>W:cd %:p:h<CR>:<CR>
noremap <C-Tab> <C-W>w:cd %:p:h<CR>:<CR>

"""""" OTHER VIM CONFIG """"""
set history=1000  " number of history operations to remember
set autoread      " detect external changes to a file while editing and give a prompt
set mouse=a       " enable mouse

"""""" PLUGIN CONFIG """"""
" fanfingtastic config
let g:fanfingtastic_ignorecase = 1
let g:fanfingtastic_all_inclusive = 1


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

" Highlight same words under cursor
" (Note this shortcut only works on GVim/MacVim; in terminal <C-Space> is
" badly interpreted and Vim would only receive <Nul>.)
nnoremap <C-space> *#

" use alt key to input !@#$%^&*()
noremap <A-1> !
noremap <A-2> @
noremap <A-3> #
noremap <A-4> $
noremap <A-5> %
noremap <A-6> ^
noremap <A-7> &
noremap <A-8> *
noremap <A-9> (
noremap <A-0> )

" Use ",," for the original "," functionality,
" so "," can be used for other shortcut as a leader
" (I'm using the fanfingtastic plugin so it's not mapped to vanilla comma)
"map ,, ,
map ,, <Plug>fanfingtastic_,

" Edit file in current file's directory map
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>

" Paste last yank
map ,p "0p
map ,P "0P

" jump between first level braces (C++ methods)
" (from official help, makes [[/]]/[]/][ work on non-first column braces)
map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

"""""" INSERT MODE SHORTCUTS """"""
" insert mode navigation/editing
" (Note vim does not distinguish between <C-a> and <C-A>,
" but it DOES distinguish between <A-a> and <A-A>)
imap <A-h> <LEFT>
imap <A-j> <C-O>gj
imap <A-k> <C-O>gk
imap <A-l> <RIGHT>
imap <A-w> <C-O>w
imap <A-W> <C-O>W
imap <A-b> <C-O>b
imap <A-B> <C-O>B
imap <A-e> <C-O>e<C-O>a
imap <A-E> <C-O>E<C-O>a
imap <A-I> <C-O>zz
imap ° <C-O>0
inoremap ´ <C-O>$
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

" Automatically break undo sequence in Insert Mode: 
" before deleting line and word
" before new line
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
inoremap <CR> <c-g>u<CR>

"""""" LEADER SHORTCUTS """"""
" Use the default vim leader key "\".
" Use this section for non-frequently-used shortcuts.
" For frequently used shortcuts, a "," leader shortcut is recommended.

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
" Alt+a is escape
map! <A-a> <Esc>
map <A-a> <Esc>
" Alt+; is :
" map <A-;> :
" Alt+1 is ! (does not work)
imap ± !
" Alt+2 is @ (does not work)
imap ² @
" Alt+m is Enter
imap <A-m> <CR> 


set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction


" move to next/previous line but retain cursor line position on screen
function! s:Saving_scroll(cmd)
  let save_scroll = &scroll
  execute 'normal! ' . a:cmd
  let &scroll = save_scroll
endfunction
nnoremap <C-J> :call <SID>Saving_scroll("1<C-V><C-D>")<CR>
vnoremap <C-J> <Esc>:call <SID>Saving_scroll("gv1<C-V><C-D>")<CR>
nnoremap <C-K> :call <SID>Saving_scroll("1<C-V><C-U>")<CR>
vnoremap <C-K> <Esc>:call <SID>Saving_scroll("gv1<C-V><C-U>")<CR>
