" Indentation
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Run Python code
nmap <leader>r :!python3 % <CR>


" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled          = 0
" Go to definition
let g:jedi#goto_command                 = ',d'
" Find ocurrences
let g:jedi#usages_command               = ',o'
" Find assignments
let g:jedi#goto_assignments_command     = ',a'

" Go to definition in new tab
nmap <leader>D :tab split<CR>:call jedi#goto()<CR>

" clear empty spaces at the end of lines on save
autocmd BufWritePre *.py :%s/\s\+$//e

" Move to next placeholder with Tab
let g:coc_snippet_next = '<tab>'

" Use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Finish completion with Enter
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Move through options with Tab and S-Tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-k>"
