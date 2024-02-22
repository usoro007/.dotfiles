"Type ('P) to bring me directly to my python configuration, when in vim
"This merely adds to the std python settings. Thanks Leeren Chang!

set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent smartindent

setlocal path=.,**

" Include Search configuration - Thank you Leeren Chang - Vim: Vim as and IDE
" 45:45 to complete!
set include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\ as\\)
"import conv.metrics (1)
"/conv.metrics/
"conv/meterics.py
"from conv import conversion as conv (2)
"/conv import conversion/
"conv/conversion.py conv.py
function! PyInclude(fname)
    let parts = split(a:fname, 'import') " (1) [conv.conversion] (2) [conv, conversion]
    let l = parts[0] " (1) conv.metrics (2) conv
    if len(parts) > 1
        let r = parts[1] " conversion
        let joined = join([l, r], '.') " conv.conversion
        let fp = substitute(joined, '\.', '/', 'g') . 'py'
        let found = glob(fp, 1)
        if len(found)
            return found
        endif
    endif
    return substitute(l, '\.', '/', 'g') . 'py'
endfunction
setlocal includeexpr=PyInclude(v:fname)

setlocal define=^\\s*\\<\\(def\\\|class\\)\\>

compiler python

nnoremap <buffer> <F9> :w<cr> :!reset<cr> :!python3 %<cr>

"set cmdheight=2

" Type ('G) to get to vimrc.plug file
if filereadable(expand("~/.vim/vimrc.plug"))
    source ~/.vim/vimrc.plug
endif
