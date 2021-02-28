setlocal foldmethod=syntax

" Indentation
set noexpandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Run 'go run' with a shortcut
nmap <leader>r :GoRun <CR>

" Disable :GoDoc running from K - we'll use CoC
let g:go_doc_keywordprg_enabled = 0

" Don't close folds automatically
let g:go_fmt_experimental               = 1

" Highlighting
let g:go_highlight_build_constraints    = 1
let g:go_highlight_extra_types          = 1
let g:go_highlight_fields               = 1
let g:go_highlight_function_calls       = 1
let g:go_highlight_functions            = 1
let g:go_highlight_methods              = 1
let g:go_highlight_operators            = 1
let g:go_highlight_structs              = 1
let g:go_highlight_types                = 1
let g:go_auto_sameids                   = 1


" Show variable type on airline
let g:go_auto_type_info                 = 1

" Organize code on write 
"autocmd BufWritePre *.go call ft#go#ImportAndFormat()
autocmd BufWritePre *.go lua goimports(1000)
