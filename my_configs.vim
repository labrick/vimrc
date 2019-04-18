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
" set autochdir

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
" ---------------------
nmap gb :Gblame<CR>
nmap gs "Ggrep <C-R>=expand("<cword>")<CR><CR>

" ---------------------
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
nmap mbt :TMiniBufExplorer<CR>
nmap bn :bn<CR>
nmap bp :bp<CR>

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

nmap <S-w> b
nmap <S-e> ge
nmap <C-i> gf
nmap ff <C-z>

nmap <F4> :set mouse=i<CR>
nmap <F4><F4> :set mouse=a<CR>
nmap <F5> :set paste<CR>
nmap <F5><F5> :set nopaste<CR>
nmap <F6> :set scrollbind<CR>
nmap <F6><F6> :set noscrollbind<CR>
nmap <F7> :set expandtab<CR>
nmap <F7><F7> :set noexpandtab<CR>

set list
set listchars=tab:>\ ,trail:.,extends:#,nbsp:.
set colorcolumn=80
" set t_ti= t_te=

let MRU_Add_Menu = 1
let MRU_Use_Current_Window = 1

" -- Cscope setting --
if has("cscope")
    set csto=0      " cstag命令查找次序，0：先查找cscope数据库，1：先查找tags
    set cst         " 同时搜索cscope数据库和tags
    " set cscopequickfix=s-,c-,d-,i-,t-,e-  " 使用QuickFix窗口显示cscope结果
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif

nmap css :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap csg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap csc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap cst :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap cse :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap csf :cs find f <C-R>=expand("<cword>")<CR><CR>
nmap csi :cs find i <C-R>=expand("<cword>")<CR><CR>
nmap csd :cs find d <C-R>=expand("<cword>")<CR><CR>

nnoremap - :call bufferhint#Popup()<CR>
nnoremap \ :call bufferhint#LoadPrevious()<CR>
