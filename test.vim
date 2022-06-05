function! CFold()
    if getline(v:lnum - 1)[0] ==# '}'
        return '<1'
    elseif getline(v:lnum + 1)[0] ==# '{'
        return '>1'
    endif
    return '='
endfunction

function! CFoldText()
    let line = getline(v:foldstart)
    let sub = substitute(line, '.*\<\(\w\+\)(.*).*', '\1(...)', 'g')
    return '+-- ' . sub . ' (' . (v:foldend - v:foldstart + 1) . ' lines)'
endfunction

setlocal foldmethod=expr
setlocal foldexpr=CFold()
setlocal foldtext=CFoldText()
setlocal fillchars-=fold:-


" set foldenable
" set foldcolumn=1
" set foldlevel=3
" set foldlevelstart=99
" set foldmarker=//{,//}
" 
" set foldenable              " 开始折叠
" set foldmethod=syntax       " 设置语法折叠
" set foldcolumn=0            " 设置折叠区域的宽度
" setlocal foldlevel=1        " 设置折叠层数为
" set foldlevelstart=99       " 打开文件是默认不折叠代码
" "set foldclose=all          " 设置为自动关闭折叠

"设置起止符号 
syn region myFold start="{" end="}" transparent fold
syn sync fromstart
set foldnestmax=2   " 设置最大折叠深度"
" 
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
set foldmethod=indent
" set foldmethod=syntax
" " set fdm=marker
" set foldmethod=marker
" " flod
" nmap <F2> za
" " nmap <F2> zc
" " nmap <F2><F2> zm
" " unfold
" " nmap <F2><F2> zo
" " flod all
" nmap <F4> zm
" " unflod all
" nmap <F4><F4> zr
