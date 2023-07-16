set nu
set nowrap
syntax on
set tags=tags;
set autochdir
set splitright
set statusline+=%f
set laststatus=2
set ls=2
" set cursorline

nmap ff <C-z>
nmap zz :q<CR>
nmap sf :set ff?<CR>
nmap cc :%s/\s\+$//CR>

set foldenable
set foldcolumn=0
set foldlevelstart=99       " 打开文件是默认不折叠代码
set foldmethod=indent
nnoremap <silent><space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" nmap <F2> zm
" nmap <F2><F2> zr
" set foldlevel=5

"How can I open a NERDTree automatically when vim starts up if no files were specified?
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

nmap be :BufExplorer<CR>
nmap nt :NERDTree<CR>
nmap tl :Tlist<CR>
nmap vs :vsplite<CR>
" %代表文件所有行，!xxx代表执行外部命令xxd，结合在一起就是把当前vim上显示的所有行传递给xxd，xxd把处理后的结果重新显示在vim上
" 注意这里直接修改十六进制后，右侧对应的ascii码并不会改变，需要采用asc重新写回才行。
nmap hex :%!xxd<CR>
nmap asc :%!xxd -r<CR>
" autocmd BufWritePost *.c,*.h,*.cpp call UpdateCtags()
" ---------------------
nmap gb :Gblame<CR>
nmap gs "Ggrep <C-R>=expand("<cword>")<CR><CR>
nmap <F6> @w<C-R>

" ---------------------
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
nmap mbt :TMiniBufExplorer<CR>
nmap bn :bn<CR>
nmap bp :bp<CR>
" nmap <leader>c gc
" nmap <leader>u gcu

" ctrlp config
let g:ctrl_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
" search in PATH
" nmap <leader>b :CtrlP
" search in Buffer
" nmap <leader>b :CtrlPBuffer
" search in MRU files
nmap <leader>f :CtrlPMRUFiles<CR>
" search in Files, Buffers and MRU files at the same time
nmap <leader>b :CtrlPMixed<CR>
let g:ctrlp_woring_path_mode = 'ra'
let g:ctrlp_user_caching = 1
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_max_height = 15
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_mruf_max= 500
let g:ctrlp_follow_symlinks = 1
" ttb: top to bottom, btt: bottom to top
" let g:ctrlp_match_window = 'bottom,order:bbt,min:1,max:10,results:20'

" let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" let g:indentLine_char = 'x'
" let g:indentLine_first_char = '|'
" let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_color_term = 239
" indentLine 
autocmd FileType json,markdown let g:indentLine_conceallevel = 0
" let g:vim_json_syntax_conceal = 0

colors peaksea
" colors mayansmoke
" colors pyte
" set background=light     " dark
" colorscheme solarized
set mouse=a
nmap <F5> :set paste<CR>
nmap <F5><F5> :set nopaste<CR>
" nmap <F6> :set scrollbind<CR>
" nmap <F6><F6> :set noscrollbind<CR>
function! SetCPlusPlus()
	:set expandtab
	:set tabstop=2
	:set softtabstop=2
	:set shiftwidth=2
endfunc
function! SetLinuxKernel()
	:set noexpandtab
	:set tabstop=8
	:set softtabstop=8
	:set shiftwidth=8
endfunc
function! SetLinuxUser()
	:set expandtab
	:set tabstop=4
	:set softtabstop=4
	:set shiftwidth=4
endfunc
" :call SetLinuxUser()
:call SetLinuxKernel()
" :call SetCPlusPlus()
nmap <F7> :call SetLinuxUser()<CR>
nmap <F7><F7> :call SetLinuxKernel()<CR>
nmap <F7><F7><F7> :call SetCPlusPlus()<CR>

set list
set listchars=tab:>\ ,trail:.,extends:#,nbsp:.
" set colorcolumn=80
" set t_ti= t_te=

let MRU_Add_Menu = 1
let MRU_Use_Current_Window = 1
let Tlist_Show_One_File = 1

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

nmap css :vs<CR>:cs find s <C-R>=expand("<cword>")<CR><CR>
nmap csg :vs<CR>:cs find g <C-R>=expand("<cword>")<CR><CR>
nmap csc :vs<CR>:cs find c <C-R>=expand("<cword>")<CR><CR>
nmap cst :vs<CR>:cs find t <C-R>=expand("<cword>")<CR><CR>
nmap cse :vs<CR>:cs find e <C-R>=expand("<cword>")<CR><CR>
nmap csf :vs<CR>:cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap csi :vs<CR>:cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap csd :vs<CR>:cs find d <C-R>=expand("<cword>")<CR><CR>
nmap tt :vs<CR>:cs find g 
nmap ts :vs<CR>:cs find s 
set csre

function! UpdateCscope()
    let curdir=getcwd()
    while !filereadable("./tags")
        cd ..
        if getcwd() == "/"
            break
        endif
    endwhile
    if filewritable("./tags")
        !tag
        TlistUpdate
    endif
    execute ":cd" . curdir
endfunction

function! ReplaceCscope()
    " :cs kill 0
    :cs add $CSCOPE_DB
endfunction

nmap <F9><F9> :call UpdateCscope()<CR>
nmap <F9> :call ReplaceCscope()<CR>

func! SetTetrasComment()
    call setline(1, "/*")
    call append(line("."), " * (C) Copyright 2023, Shenzhen Tetras.AI Technology Co., Ltd")
    call append(line(".")+1, " * This file is classified as confidential level C3 within Tetras.AI")
    call append(line(".")+2, " *")
    call append(line(".")+3, " * SPDX-License-Identifier: Apache-2.0")
    call append(line(".")+4, " *")
    call append(line(".")+5, " * Change Logs:")
    call append(line(".")+6, " * Date           Author         Notes")
    call append(line(".")+7, " * ".strftime("%Y-%m-%d")."     Martin         Initialize.")
    call append(line(".")+8, " */")
    call append(line(".")+9, "")
    call append(line(".")+10, "/**")
    call append(line(".")+11, " * @brief")
    call append(line(".")+12, " * @date    ".strftime("%Y-%m-%d"))
    call append(line(".")+13, " */")
endfunc
" tetras.ai comment for .c .h
autocmd BufNewFile *.c,*.h exec ":call SetTetrasComment()"

nnoremap - :call bufferhint#Popup()<CR>
nnoremap \ :call bufferhint#LoadPrevious()<CR>
