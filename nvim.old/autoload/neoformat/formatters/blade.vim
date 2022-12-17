function! neoformat#formatters#blade#enabled() abort
    return ['bladeformatter']
endfunction

function! neoformat#formatters#blade#bladeformatter() abort
    return {
           \ 'exe': 'blade-formatter',
           \ 'args': ['--write'],
           \ 'replace': 1,
           \ }
endfunction
