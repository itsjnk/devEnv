" -- Generial --
set number
set mouse=a
if !has('nvim')
	set ttymouse=xterm2
endif
set encoding=UTF-8
set showcmd
set showmatch
set noshowmode
set laststatus=2
set title
set nowrap
set nobackup
set noswapfile
set ignorecase
set smartcase
" For ASCII C
autocmd BufEnter *.c setlocal sts=8 sw=8 ts=8
autocmd BufEnter *.h setlocal sts=8 sw=8 ts=8
" When there is no filetype specified, keep the same indent as the above line
set autoindent
" Tab stop
set ts=4
set softtabstop=4
" When indenting with '>', use 4 spaces width
set shiftwidth=4
" Always use space instead of tabs
" set expandtab
set listchars=tab:>·,space:·
" Horizontal split below
set splitbelow
" Vertical split right
set splitright
" Better command-line completion
set wildmenu
" Raise a dialogue asking if you wish to save changed files
set confirm
" Allow backspacing over autoindent, line breaks, and start of insert action
set backspace=indent,eol,start
" Always show sigcolumn
set signcolumn=yes
let mapleader=","
" Auto close quickfix windows when leaving a file
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
aug END

" -- Plugins --
let s:try_auto_install_missing = 1
let s:updated_missing_files = 0
let s:vim_plug_path = $HOME . '/.vim/autoload/plug.vim'
let s:nvim_plug_path = $HOME . '/.local/share/nvim/site/autoload/plug.vim'
let s:gtags_conf_path = $HOME . '/.config/gtags/gtags.conf'
let s:need_install_plug = 0
let s:need_install_gtags_conf = 0

if has('nvim')
	let $MYVIMRC = $HOME . '/.config/nvim/init.vim'
else
	let $MYVIMRC = $HOME . '/.vimrc'
endif

if empty(glob(s:nvim_plug_path)) || empty(glob(s:vim_plug_path))
	let s:need_install_plug = 1
endif
if empty(glob(s:gtags_conf_path))
	let s:need_install_gtags_conf = 1
endif

if v:version >= 800 && !s:need_install_plug
	call plug#begin()
		Plug 'vim-airline/vim-airline'
		Plug 'vim-airline/vim-airline-themes'
		Plug 'ludovicchabant/vim-gutentags'
		Plug 'Yggdroot/LeaderF'
		Plug 'ervandew/supertab'
		Plug 'octol/vim-cpp-enhanced-highlight'
		if has('nvim') || has('patch-8.0.902')
			Plug 'mhinz/vim-signify'
		else
			Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
		endif
		Plug 'altercation/vim-colors-solarized'
    call plug#end()

	" Supertab
	let g:SuperTabDefaultCompletionType = "<c-n>"

    " Gtags/Cscope : go to defination or references
    "" Need `Global (Gtags)` for Gutentags to update tags db automatically.
    "" Need `Universal ctags` for LeaderF to show function list.
	"" `pip install pygments` must be runned by current user.
    let $GTAGSLABEL = 'native-pygments'
    let $GTAGSCONF = s:gtags_conf_path

    " Gutentags : update tags database automatically
    let g:gutentags_modules = []
    if executable('gtags-cscope') && executable('gtags')
		let g:gutentags_modules += ['gtags_cscope']
    endif
    let g:gutentags_cache_dir = expand('~/.cache/tags')
    let g:gutentags_ctags_tagfile = '.tags'
    let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
    let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
    let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
	if !s:need_install_gtags_conf
		let g:gutentags_auto_add_gtags_cscope = 1
	endif
	let g:gutentags_define_advanced_commands = 1

	noremap <silent> <leader>s :cs f s <C-R><C-W><cr>
	noremap <silent> <leader>g :cs f g <C-R><C-W><cr>
	noremap <silent> <leader>c :cs f c <C-R><C-W><cr>
	noremap <silent> <leader>t :cs f t <C-R><C-W><cr>
	noremap <silent> <leader>e :cs f e <C-R><C-W><cr>
	noremap <silent> <leader>f :cs f f <C-R>=expand("<cfile>")<cr><cr>
	noremap <silent> <leader>i :cs f i <C-R>=expand("<cfile>")<cr><cr>
	noremap <silent> <leader>d :cs f d <C-R><C-W><cr>
	noremap <silent> <leader>a :cs f a <C-R><C-W><cr>

    " LeaderF : files/functions searching
    noremap <leader>lr :Leaderf! mru --nowrap<cr>
    noremap <leader>lf :Leaderf! file --nowrap<cr>
    noremap <leader>ll :Leaderf! function --nowrap<cr>
    let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
    let g:Lf_WorkingDirectoryMode = 'Ac'
    let g:Lf_WindowHeight = 0.20
    let g:Lf_CacheDirectory = expand('~/.cache')
    let g:Lf_ShowRelativePath = 0
    let g:Lf_HideHelp = 1
    let g:Lf_StlColorscheme = 'powerline'
    let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
	let g:Lf_StlSeparator = {'left': '', 'right': '', 'font': ''}

	" Vim-cpp-enhanced-highlight
	let g:cpp_class_scope_highlight = 1
	let g:cpp_member_variable_highlight = 1
	let g:cpp_class_decl_highlight = 1
	let g:cpp_posix_standard = 1

	" Airline
	noremap <silent> <A-n> :bn<cr>
	noremap <silent> <A-p> :bp<cr>
	noremap <silent> <A-k> :bd<cr>
	let g:airline_powerline_fonts = 0
	let g:airline_theme = 'solarized_flood'
	let g:airline_statusline_ontop = 0
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#formatter = 'unique_tail'
endif

" -- Color scheme --
syntax enable
if s:need_install_plug
	colorscheme default
else
	colorscheme solarized
endif
if !has('gui_running')
	set background=dark
	let g:solarized_termcolors=16
elseif has('win32') || has('win64')
	set guifont=Consolas:h11
	set background=light
endif
set hlsearch
set cursorline
set colorcolumn=100
" set list

" Donwload & install plug.vim from cloud
function! GInstallPlug()
	let l:vim_plug_path = $HOME . '/.vim/autoload/plug.vim'
	let l:nvim_plug_path = $HOME . '/.local/share/nvim/site/autoload/plug.vim'
	let l:plug_url = 'https://gitee.com/jnkuo/devEnv/raw/master/unixDevEnv/user_root/plug.vim'
	let l:output_redirect = ' > /dev/null 2>&1'

	if has('nvim') && empty(glob(l:nvim_plug_path))
		silent execute '!' . 'curl -fLo '
					\ . l:nvim_plug_path . ' --create-dirs '
					\ . l:plug_url . l:output_redirect
	elseif empty(glob(l:vim_plug_path))
		silent execute '!' . 'curl -fLo '
					\ . l:vim_plug_path . ' --create-dirs '
					\ . l:plug_url . l:output_redirect
	else
		echo 'plug.vim has been installed already.'
	endif
	return v:shell_error
endfunc

" Download & install gtags.conf from cloud
function! GInstallGtagsConf()
	let l:gtags_conf_path = $HOME . '/.config/gtags/gtags.conf'
	let l:gtags_conf_url = 'https://gitee.com/jnkuo/devEnv/raw/master/unixDevEnv/user_etc/gtags.conf'
	let l:output_redirect = ' > /dev/null 2>&1'

	if empty(glob(l:gtags_conf_path))
		silent execute '!' . 'curl -fLo '
					\ . l:gtags_conf_path . ' --create-dirs '
					\ . l:gtags_conf_url . l:output_redirect
	else
		echo 'gtags.conf has been installed already.'
	endif
	return v:shell_error
endfunc

" Check whether plug.vim & gtags.conf have been installed
if s:need_install_plug
	if s:try_auto_install_missing
		if GInstallPlug() == 0
			let s:updated_missing_files = 1
		else
			echo 'Need plug.vim! Run ":call GInstallPlug()" please!'
		endif
	endif
endif
if s:need_install_gtags_conf
	if s:try_auto_install_missing
		if GInstallGtagsConf() == 0
			let s:updated_missing_files = 1
		else
			echo 'Need gtags.conf! Run ":call GInstallGtagsConf()" please!'
		endif
	endif
endif
if s:updated_missing_files
	source $MYVIMRC
endif
