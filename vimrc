source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin


"""""" UNMAP GVIM FOR WINDOWS SHORTCUTS in mswin.vim """"""
"""""" (or provide substitute for overrided shortcuts) """"""

" Don't use ALT key for GUI menu (F10 can still be used to focus on menu)
set winaltkeys=no

" Next page (opens GUI search panel in gwim for windows)
" (Pairs with <C-B>)
unmap <C-F>
" Scroll up one line (<C-Y> is mapped to be the same as <C-R> in windows)
" (Pairs with <C-E>)
" (<C-@> is somehow the only usable Ctrl+Number)
nnoremap <C-@> <C-Y>
" Increment/Decrement number (substitute for <C-A> and <C-X>)
:nnoremap <F3> <C-a>
:nnoremap <F2> <C-x>

" Use inclusive selection for visual mode (since "behave mswin" set it to
" exclusive mode). (fanfingtastic used to not support exclusive mode but
" it should be working fine now without the setting.)
set selection=inclusive
