function! ft#go#ImportAndFormat()
    execute 'GoImports'
    execute 'GoFmt'
endfunction
