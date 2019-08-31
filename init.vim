"""""""""""
" plugins "
"""""""""""
"First time, execute in terminal to install vim-plug:
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"                              https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

":PlugInstall and :UpdateRemotePlugins to make changes effective
call plug#begin('~/.vim/plugged')
  Plug 'alaviss/nim.nvim'                    
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'davidgranstrom/scnvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'SirVer/ultisnips'
  Plug 'Shougo/deoplete.nvim',  { 'do': ':UpdateRemotePlugins' }
  Plug 'deoplete-plugins/deoplete-tag'
call plug#end()

"""""""""""""""
" look n feel "
"""""""""""""""
"set background = dark

"""""""
" nim "
"""""""

"Async autocompletion for nim with asyncomplete
au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'nim',
    \ 'whitelist': ['nim'],
    \ 'completor': {opt, ctx -> nim#suggest#sug#GetAllCandidates({start, candidates -> asyncomplete#complete(opt['name'], ctx, start, candidates)})}
    \ })

""""""""""
" scnvim "
""""""""""

" hard coded path to sclang executable
let g:scnvim_sclang_executable = '/usr/local/bin/sclang'

" enable snippets support
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'scnvim-data']
let g:UltiSnipsExpandTrigger = "<tab>"

" Add tags
set tags = "/home/francesco/.vim/plugged/scnvim/scnvim-data/tags"

"Enable deoplete at startup (For SC's autocompletion)
let g:deoplete#enable_at_startup = 1
let deoplete#tag#cache_limit_size = 5000000

" remap send block to Enter
nmap <Enter> <Plug>(scnvim-send-block)

" remap post window show/hide toggle to Space+o
nmap <Space>o <Plug>(scnvim-postwindow-toggle)

" eval flash colors
highlight SCNvimEval guifg=black guibg=cyan ctermfg=black ctermbg=cyan
" this autocmd keeps the custom highlight when changing colorschemes
augroup scnvim_vimrc
  autocmd!
  autocmd ColorScheme *
        \ highlight SCNvimEval guifg=black guibg=cyan ctermfg=black ctermbg=cyan
augroup END

" create a custom status line for supercollider buffers
function! s:set_sclang_statusline()
  setlocal stl=
  setlocal stl+=%f
  setlocal stl+=%=
  setlocal stl+=%(%l,%c%)
  setlocal stl+=\ \|
  setlocal stl+=%18.18{scnvim#statusline#server_status()}
endfunction

augroup scnvim_stl
  autocmd!
  autocmd FileType supercollider call <SID>set_sclang_statusline()
augroup END