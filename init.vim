"|   _ \                 __    __     (_)                                  (_)
"|  |_| | ___   _ __  __|  |__|  |     _   ____  __   ___ ___    _ ____   ___ _ __ ___  _ __ ___
"| |\__/ / _ \ | '_ \ |__  __||  |__  | | /  _ \ | |  | |/ __|  | '_ \ \ / / | '_ ` _ \| '__/ __|
"| |    <  __/ | | | |  |  |  |   _ \ | | | |_| || \__/ |\__ \  | | | \ V /| | | | | | | | | (__
"\_|     \___| |_| |_|  |__|  |__| |_||_| \____/ \_____/ |___/  |_| |_|\_/ |_|_| |_| |_|_|  \___| 
"
" Author: Tomas Leffew
" repo  : https://github.com/penthious/dotfiles/
" Setup ---------------------------------------------------------------------{{{ 

":UpdateRemotePlugins
let g:python3_host_prog = "/usr/local/bin/python3"
if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
  call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
  call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
endif

if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
  call system(expand("mkdir -p $HOME/.config/nvim/.VIM_UNDO_FILES"))
endif

set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/
"Plugins {{{
call dein#begin(expand('~/.config/nvim'))

call dein#add('Shougo/dein.vim')
call dein#add('ryanoasis/vim-devicons')
call dein#add('vim-airline/vim-airline')
call dein#add('mhartington/oceanic-next')
call dein#add('Yggdroot/indentLine')
call dein#add('tpope/vim-surround')
call dein#add('scrooloose/nerdtree')
call dein#add('Xuyuanp/nerdtree-git-plugin')
call dein#add('valloric/MatchTagAlways', {'on_ft': 'html'}) " Matches the closing html tag
call dein#add('neomake/neomake') " Alows for async actions 
call dein#add('editorconfig/editorconfig-vim')
call dein#add('vim-scripts/HTML-AutoCloseTag')
call dein#add('ap/vim-css-color')
call dein#add('jiangmiao/auto-pairs')

" Git
call dein#add('mhinz/vim-signify') " Shows git differences in file
call dein#add('tpope/vim-fugitive')

" Auto complete
call dein#add('Shougo/deoplete.nvim')

" Javascript plugins
call dein#add('ternjs/tern_for_vim', {'do': 'npm install && npm install -g tern'})
call dein#add('carlitux/deoplete-ternjs')
call dein#add('mxw/vim-jsx')
call dein#add('pangloss/vim-javascript')

call dein#add('mattn/emmet-vim')
" call dein#add('Raimondi/delimitMate', {'on_ft': ['javascript', 'css', 'scss']})
" call dein#add('tpope/vim-repeat')
" call dein#add('tomtom/tcomment_vim')
" call dein#add('Chiel92/vim-autoformat')
"}}}
if dein#check_install()
  call dein#install()
  let pluginsExist=1
endif

call dein#end()
filetype plugin indent on
" }}}

" System Settings  ----------------------------------------------------------{{{
" Neovim Settings

  let g:spacevim_plugin_manager=1
  let g:closetag_filenames = "*.html,*.xhtml,*.phtml, *.php"
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " ----------------------- sets true vim colors
  
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1 " --------------------- 
  
  let $NEOVIM_JS_DEBUG='nvimjs.log' " ----------------------- logs error messages
  
  set clipboard+=unnamedplus " ------------------------------ copy to clipboard
  
  set pastetoggle=<f6> " ------------------------------------ set paste for outside vim sorces into vim
   
  set nopaste " --------------------------------------------- turn paste mode off

  set noshowmode " ------------------------------------------ removes default mode indictaor in airline
  
  set breakindent " ----------------------------------------- word wrap correct indent
  
  set noswapfile " ------------------------------------------ prevents vim from creating a .swp file

  " set filetype " -------------------------------------------- auto detect file types

  set relativenumber number " ------------------------------- set hybrid number, show current line number, then shows numbers relative to your position

  set tabstop=2 shiftwidth=2 expandtab " -------------------- sets the max tab space , and how many tab spaces will be added on tap, converts taps to spaces

  set conceallevel=0 " -------------------------------------- concealed text will be shown normaly

  set virtualedit=all " ------------------------------------- allows for insert past end of line

  set wildmenu " -------------------------- enables menu at bottom of vim window, options will be displayed in a list
  set wildmode=full

  set statusline=2 " ----------------------------------------- allways shows status line

  set wrap linebreak nolist " -------------------------------- wordwrap that makes the new line counted part of the original line

  set laststatus=2 " -----------------------------------------  show filename in staus line

  let mapleader = ',' " -------------------------------------- sets the mapleader to ,
  set undofile " --------------------------------------------- writes to a undo file for persistant undo

  set undodir="$HOME/.config/nvim/.VIM_UNDO_FILES" " --------- the file path to write undo

  " puts cursor back to where it was when you last closed the file
  autocmd BufReadPost *
              \ if line("'\"") > 0 && line ("'\"") <= line("$") |
              \   exe "normal! g'\"" |
              \ endif
  let g:deoplete#enable_at_startup = 1 " --------------------- start deoplete on startup

  let g:indentLine_char='│' " -------------------------------- set indent line to |
"}}}

" System mappings  ----------------------------------------------------------{{{
  let g:mta_use_matchparen_group = 1
  "atom like saving
  map <C-s> <esc>:w<CR>
  set splitbelow " ------------------------------------------- Make splits default to below

  set splitright " ------------------------------------------- And to the right. This feels more natural.

  "We'll set simpler mappings to switch between splits.
  if has('nvim')
     "work around for nvim left split navigation
     nmap <BS> <C-W>h
  endif
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-h> <C-w-h>
  nnoremap <C-l> <C-w>l
  
  " opens up neovim config with <leader>ev
  nmap <Leader>ev :tabedit $MYVIMRC<cr>

  " no need for ex mode
  nnoremap Q <nop>

  " recording macros is not my thing
  map q <Nop>

  " navigate between display lines
  noremap  <silent> <Up>   gk
  noremap  <silent> <Down> gj
  noremap  <silent> k gk
  noremap  <silent> j gj
  noremap  <silent> <Home> g<Home>
  noremap  <silent> <End>  g<End>
  inoremap <silent> <Home> <C-o>g<Home>
  inoremap <silent> <End>  <C-o>g<End>
 
  " copy current files path to clipboard
  nmap cp :let @+ = expand("%") <cr>

  " return to normal mode in neovims terminal
  tmap <esc> <c-\><c-n><esc><cr>

  " ,f to format code, requires formatters
  noremap <leader>f :Autoformat<CR>

  " moves to begining of line, end of line, 5 lines up, 5 lines down
  noremap H ^
  noremap L g_
  noremap K 5k
  noremap J 5j

  "remaps ; to : no need to hit shifi ;
  nnoremap ; :

  " copy to clipboard
  vnoremap <C-c> "*y<CR>
  vnoremap y "*y<CR>
  nnoremap Y "*Y<CR>

  " requires ('terryma/vim-multiple-cursors')
  let g:multi_cursor_next_key='<C-n>'
  let g:multi_cursor_prev_key='<C-p>'
  let g:multi_cursor_skip_key='<C-x>'
  let g:multi_cursor_quit_key='<Esc>'

  " Align blocks of text to the left and keep them selected
  vmap < <gv

  " Align blocks of text to the right and keep them selected
	vmap > >gv

" }}}

" Themes --------------------------------------------------------------------{{{ 

  "turns syntax highlighting on
  syntax on

  "sets the colorscheme for syntax
  colorscheme OceanicNext

  "sets the background color
  set background=dark

 " Keep my terminal window open when I navigate away
  autocmd TermOpen * set bufhidden=hide
  
  set guifont=SourceCodePro\ Code:h12
"}}}

" Plugin settings -----------------------------------------------------------{{{
  "nerdtree {{{
  map <C-\> :NERDTreeToggle<CR>
  autocmd StdinReadPre * let s:std_in=1
  " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  let NERDTreeShowHidden=1
  let g:NERDTreeWinSize=45
  let g:NERDTreeAutoDeleteBuffer=1
  " NERDTress File highlighting
  function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
  endfunction

  call NERDTreeHighlightFile('jade', 'green', 'none', 'green', 'none')
  call NERDTreeHighlightFile('md', 'blue', 'none', '#6699CC', 'none')
  call NERDTreeHighlightFile('config', 'yellow', 'none', '#d8a235', 'none')
  call NERDTreeHighlightFile('conf', 'yellow', 'none', '#d8a235', 'none')
  call NERDTreeHighlightFile('json', 'green', 'none', '#d8a235', 'none')
  call NERDTreeHighlightFile('html', 'yellow', 'none', '#d8a235', 'none')
  call NERDTreeHighlightFile('css', 'cyan', 'none', '#5486C0', 'none')
  call NERDTreeHighlightFile('scss', 'cyan', 'none', '#5486C0', 'none')
  call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', 'none')
  call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', 'none')
  call NERDTreeHighlightFile('ts', 'Blue', 'none', '#6699cc', 'none')
  call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', 'none')
  call NERDTreeHighlightFile('gitconfig', 'black', 'none', '#686868', 'none')
  call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#7F7F7F', 'none')
  "}}}

  "vim-airline {{{
  let g:airline#extensions#tabline#enabled = 1
  set hidden
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#show_tab_nr = 1
  let g:airline_powerline_fonts = 1
  let g:airline_theme='oceanicnext'
  cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'Sayonara' : 'x'
  tmap <leader>x <c-\><c-n>:bp! <BAR> bd! #<CR>
  nmap <leader>t :term<cr>
  nmap <leader>, :bnext<CR>
  tmap <leader>, <C-\><C-n>:bnext<cr>
  nmap <leader>. :bprevious<CR>
  tmap <leader>. <C-\><C-n>:bprevious<CR>
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  tmap <leader>1  <C-\><C-n><Plug>AirlineSelectTab1
  tmap <leader>2  <C-\><C-n><Plug>AirlineSelectTab2
  tmap <leader>3  <C-\><C-n><Plug>AirlineSelectTab3
  tmap <leader>4  <C-\><C-n><Plug>AirlineSelectTab4
  tmap <leader>5  <C-\><C-n><Plug>AirlineSelectTab5
  tmap <leader>6  <C-\><C-n><Plug>AirlineSelectTab6
  tmap <leader>7  <C-\><C-n><Plug>AirlineSelectTab7
  tmap <leader>8  <C-\><C-n><Plug>AirlineSelectTab8
  tmap <leader>9  <C-\><C-n><Plug>AirlineSelectTab9
  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9
"}}}

  "Fold {{{

  function! MyFoldText() " {{{
      let line = getline(v:foldstart)

      let nucolwidth = &fdc + &number * &numberwidth
      let windowwidth = winwidth(0) - nucolwidth - 3
      let foldedlinecount = v:foldend - v:foldstart

      " expand tabs into spaces
      let onetab = strpart('          ', 0, &tabstop)
      let line = substitute(line, '\t', onetab, 'g')

      let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
      let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
      return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
  endfunction " }}}

  set foldtext=MyFoldText()

"{{{
  let s:exclude_tags_list = [
        \ '\/',
        \ '!',
        \ 'html',
        \ 'area',
        \ 'base',
        \ 'br',
        \ 'col',
        \ 'embed',
        \ 'hr',
        \ 'img',
        \ 'input',
        \ 'keygen',
        \ 'link',
        \ 'menuitem',
        \ 'meta',
        \ 'param',
        \ 'source',
        \ 'track',
        \ 'wbr',
        \ 'ion-spinner',
        \ 'ion-tab',
        \ 'ion-icon',
        \ 'ion-item',
        \ 'ion-input',
        \ 'ion-content'
        \ ]
  let s:exclude_tags = join(s:exclude_tags_list, '\|')
"}}}

  function! HTMLFolds() "{{{
    let line = getline(v:lnum)

    " Ignore tags that open and close in the same line
    if line =~# '<\(\w\+\).*<\/\1>'
      return '='
    endif

    if line =~# '<\%(' . s:exclude_tags . '\)\@!'
      return 'a1'
    endif

    if line =~# '<\/\%(' . s:exclude_tags . '\)\@!'
      return 's1'
    endif

    return '='
  endfunction "}}}

  autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
  autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

  autocmd FileType vim setlocal fdc=1
  set foldlevel=99
  " Space to toggle folds.
  nnoremap <Space> za
  vnoremap <Space> za
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevel=0

  autocmd FileType html setlocal fdl=99

  autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99
  autocmd FileType css,scss,json setlocal foldmethod=marker
  autocmd FileType css,scss,json setlocal foldmarker={,}

  autocmd FileType coffee setl foldmethod=indent
  autocmd FileType html setl foldmethod=expr
  autocmd FileType html setl foldexpr=HTMLFolds()

  autocmd FileType javascript,typescript,json setl foldmethod=syntax
" }}}

  "Linting {{{

    function! JscsFix()
        let l:winview = winsaveview()
        % ! jscs -x
        call winrestview(l:winview)
    endfunction
    command JscsFix :call JscsFix()
    noremap <leader>j :JscsFix<CR>
  "}}}

  "Deoplete {{{
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_ignore_case = 1
    let g:deoplete#enable_smart_case = 1
    let g:deoplete#enable_camel_case = 1
    let g:deoplete#enable_refresh_always = 1
    let g:deoplete#max_abbr_width = 0
    let g:deoplete#max_menu_width = 0
    let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})

    let g:tern_request_timeout = 1
    let g:tern_request_timeout = 6000
    let g:tern#command = ["tern"]
    let g:tern#arguments = ["--persistent"]

  "}}}
  
  "Emmet {{{
  let g:user_emmet_leader_key='<Tab>'
  let g:user_emmet_settings = {
    \  'javascript.jsx' : {
      \      'extends' : 'jsx',
    \  },
  \}
  "}}}
"}}}
