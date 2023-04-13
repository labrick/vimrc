func! SetTetrasComment()
    call setline(1, "/*")
    call append(line("."), " * (C) Copyright 2022, Shenzhen Tetras.AI Technology Co., Ltd")
    call append(line(".")+1, " *")
    call append(line(".")+2, " * SPDX-License-Identifier: Apache-2.0")
    call append(line(".")+3, " *")
    call append(line(".")+4, " * Change Logs:")
    call append(line(".")+5, " * Date           Author         Notes")
    call append(line(".")+6, " * ".strftime("%Y-%m-%d")."     Martin         Initialize.")
    call append(line(".")+7, " */")
    call append(line(".")+8, "")
    call append(line(".")+9, "/**")
    call append(line(".")+10, " * @brief")
    call append(line(".")+11, " * @date    ".strftime("%Y-%m-%d"))
    call append(line(".")+12, " */")
endfunc
" tetras.ai comment for .c .h
autocmd BufNewFile *.c,*.h exec ":call SetTetrasComment()"
