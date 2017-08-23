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
" %代表文件所有行，!xxx代表执行外部命令xxd，结合在一起就是把当前vim上显示的所有行传递给xxd，xxd把处理后的结果重新显示在vim上
" 注意这里直接修改十六进制后，右侧对应的ascii码并不会改变，需要采用asc重新写回才行。
nmap hex :%!xxd<CR>
nmap asc :%!xxd -r<CR>
" autocmd BufWritePost *.c,*.h,*.cpp call UpdateCtags()

" colors peaksea 

map <F9> :call CompileRunGcc()<CR>

func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == 'sh'
        exec "!chmod +x %"<CR>
        :!./%
    endif
endfunc

