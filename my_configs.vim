set nu

syntax on
set tags=tags;

" 自动更新ctags文件
function! UpdateCtags()
    let curdir=getcwd()
    while !filereadable("./tags")
        cd ..
        if getcwd() == "/"
            break
        endif
    endwhile
    if filewritable("./tags")
        !ctags -R --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q
        TlistUpdate
    endif
    execute ":cd " . curdir
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autochdir

"How can I open a NERDTree automatically when vim starts up if no files were specified?
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

nmap be :BufExplorer<CR>
nmap nt :NERDTree<CR>
nmap tl :Tlist<CR>
nmap vs :vsplite<CR>
nmap <F9> :call UpdateCtags()<CR>
" autocmd BufWritePost *.c,*.h,*.cpp call UpdateCtags()

colors peaksea 


