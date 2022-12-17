function! neoformat#formatters#antlers#enabled() abort
    return ['antlersformat']
endfunction

function! neoformat#formatters#antlers#antlersformat() abort
    return {
           \ 'exe': 'antlersformat',
           \ 'args': ['format', '--f=' ],
           \ 'replace': 1,
           \ }
endfunction
