set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'ycm-core/YouCompleteMe'
Plugin 'VundleVim/Vundle.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Bundle 'ervandew/supertab'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'preservim/nerdtree'
" note that if you are using Plug mapping you should not use `noremap` mappings.
" git repos on your local machine (i.e. when working on your own plugin)
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line"format
" Specify language servers for different filetypes
let g:ycm_auto_hover=''
set tabstop=4
set	softtabstop=4
set shiftwidth=4
set relativenumber
set timeoutlen=200
set autoindent
set	smartindent
set	completeopt=menuone,longest
packadd! vimspector
let g:vimspector_enable_mappings = 'HUMAN'
let g:UltiSnipsExpandTrigger = "<tab>"
"shortcuts
command CC !cc -g -Wall -Wextra -Werror *.c -o output && ./output
command C !norminette *.c
nnoremap K <plug>(YCMHover)
nnoremap <C-t> :tabnew<cr>
nnoremap <C-p> :tabprev<CR>
nnoremap <C-n> :tabnext<CR>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>
inoremap jk <esc>
vnoremap jk <esc>
cnoremap jk <esc>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-a> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
inoremap { {<CR><CR>}<Esc>ki<tab>
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha

let g:user42 = 'vvobis'
let g:mail42 = 'vvobis@student.42vienna.com' 

function! GenerateVimspectorConfig()
    let cwd = expand('%:p:h')
    let vimspector_config = {
        \ 'configurations': {
        \   'MyCDebugConfig': {
        \     'adapter': 'vscode-cpptools',
        \     'configuration': {
        \       'setupCommands': [
        \         {
        \           'description': 'Enable pretty-printing for gdb',
        \           'text': '-enable-pretty-printing',
        \           'ignoreFailures': v:true
        \         }
        \       ]
        \     },
        \     'request': 'launch',
        \     'program': cwd . '/output',
        \     'args': [],
        \     'cwd': cwd,
        \     'stopOnEntry': v:false,
        \     'name': 'C Debug Configuration'
        \   }
        \ }
        \}
    let json_content = json_encode(vimspector_config)
    call writefile([json_content], $HOME . '/.vimspector.json')
endfunction

let s:ycm_hover_popup = -1

function! s:ToggleHover()
  " Check if hover popup is visible
  if s:ycm_hover_popup != -1
    " If visible, hide it
    call popup_hide(s:ycm_hover_popup)
    let s:ycm_hover_popup = -1
  else
    " If not visible, show it
    call s:Hover()
  endif
endfunction

function! s:Hover()
  let response = youcompleteme#GetCommandResponse('GetDoc')
  if response == ''
    return
  endif

  " Hide previous hover popup
  call popup_hide(s:ycm_hover_popup)

  " Show new hover popup
  let s:ycm_hover_popup = popup_atcursor(balloon_split(response), {})
endfunction

" CursorHold triggers in normal mode after a delay
autocmd CursorHold * call s:Hover()

" Toggle hover mapping
nnoremap <silent> K :call <SID>ToggleHover()<CR>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<CR>"
let g:UltiSnipsJumpForwardTrigger = "<left>"
let g:UltiSnipsJumpBackwardTrigger = "<right>"
