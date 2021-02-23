syntax on
set number
set relativenumber
set ts=4
set shiftwidth=4
set cursorline
set showcmd
set wildmenu
set scrolloff=4
set laststatus=2
set ignorecase
set incsearch
set hlsearch
set nowrap
execute "nohlsearch"

nnoremap <ESC> <nop>
inoremap <ESC> <nop>
cnoremap <ESC> <nop>
vnoremap <ESC> <nop>
vnoremap u <nop>

nnoremap K <c-v>k
nnoremap J <c-v>j
vnoremap K <c-v>k
vnoremap J <c-v>j
nnoremap <ESC>h K
vnoremap <ESC>h K
nnoremap L V
vnoremap L V
nnoremap <ESC>k {
nnoremap <ESC>j }
inoremap <ESC>k <up>
inoremap <ESC>j <down>
inoremap <ESC>h <left>
inoremap <ESC>l <right>
cnoremap <ESC>k <up>
cnoremap <ESC>j <down>
cnoremap <ESC>h <left>
cnoremap <ESC>l <right>
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
inoremap jk <ESC>
cnoremap jk <C-U><ESC>
inoremap <ESC>d <DEL>
cnoremap <ESC>d <DEL>
nnoremap <ESC>n :nohlsearch<CR>
vnoremap <ESC>n :nohlsearch<CR>
noremap <ESC>t :NERDTreeToggle<CR>


nmap <ESC>d :call DeleteBuffer()<CR>
function! DeleteBuffer()
    let s:curBufNr=bufnr("%")
    execute "bprevious"
	execute "bdelete ".s:curBufNr
endfunction

let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <ESC>1 <Plug>AirlineSelectTab1
nmap <ESC>2 <Plug>AirlineSelectTab2
nmap <ESC>3 <Plug>AirlineSelectTab3
nmap <ESC>4 <Plug>AirlineSelectTab4
nmap <ESC>5 <Plug>AirlineSelectTab5
nmap <ESC>6 <Plug>AirlineSelectTab6
nmap <ESC>7 <Plug>AirlineSelectTab7
nmap <ESC>8 <Plug>AirlineSelectTab8
nmap <ESC>9 <Plug>AirlineSelectTab9
noremap s :w<CR>
noremap C <nop>
noremap S <nop>
"" :set paste 
set clipboard=unnamed
noremap P "+p
noremap Y "+y
cnoremap <ESC>P <C-R>+
cnoremap <ESC>p <C-R>"

call plug#begin('~/.vim/plugged')
"plug 'ycm-core/YouCompleteMe'
	Plug 'dense-analysis/ale'
	Plug 'vim-airline/vim-airline'
	Plug 'connorholyday/vim-snazzy'
	Plug 'preservim/nerdtree'
	Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}
call plug#end()

"终端选择powerline字体（没有要安装）后打开该选项，否则符号显示异常
let g:airline_powerline_fonts = 1
"打开标签显示
let g:airline#extensions#tabline#enabled = 1
"不显示分割窗口的标题和标题总数
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 0
"显示标签格式为只显示文件名 
let g:airline#extensions#tabline#formatter = 'unique_tail'
"关闭其他显示
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:SnazzyTransparent = 1
colorscheme snazzy

augroup mygroup
	autocmd!
	autocmd VimEnter * NERDTree | wincmd p
	" Exit Vim if NERDTree is the only window left.
	autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
augroup end

"显示nerd书签
let NERDTreeWinPos="right"
let NERDTreeMapCustomOpen="l"
let NERDTreeShowBookmarks=1
let NERDTreeMapCloseDir="h"
let NERDTreeMapJumpRoot="p"
let NERDTreeMapJumpParent="P"
let NERDTreeMapToggleHidden="i"
let NERDTreeMapDeleteBookmark="d"

"在此目录下放入以下代码 /home/ealge/.vim/plugged/nerdtree/plugin/NERD_tree.vim
"call NERDTreeAddKeyMap({
"       \ 'key': 'b',
"       \ 'callback': 'Mybookmark',
"       \ 'quickhelpText': 'mark bookmark',
"       \ 'scope': 'all' })
"function! Mybookmark()
"    exec "Bookmark"
"endfunction
"
"
" InstantMarkdownPreview and stop it via InstantMarkdownStop
let g:instant_markdown_autostart = 0
map <ESC>v :InstantMarkdownPreview<cr>
map <ESC>c :InstantMarkdownStop<cr> 

:iab zuhe always @(*)<Enter>begin<Enter>if ()begin<Enter><Enter>end<Enter>else begin<Enter><Enter>end<Enter>end
:iab test always @(*)beginif ()beginend	else begin	endend
:iab shixu always @( posedge clk or negedge res_n ) beginif() begin	endelse beginendend
:iab mokuai module t1(<Enter><Enter>);<Enter>endmodule

noremap <ESC>f :call Translate_word()<CR>
	function! Translate_word()
			" Get the bytecode.
		let bytecode = system("sdcv -n ".expand("<cword>"))

		" Open a new split and set it up.
		setlocal splitright
		vsplit _Translate_word_
		normal! ggdG
		setlocal filetype=help
		setlocal buftype=nofile
		setlocal bufhidden=hide
		setlocal noswapfile
		setlocal nobuflisted
		setlocal wrap

		" Insert the bytecode.
		call append(0, split(bytecode, '\v\n'))	
		normal! gg
		nnoremap <buffer> q :q<CR>
	endfunction

noremap <ESC>e :call Shell_sim("")<CR>
noremap <ESC>r :call Shell_sim(" -clean")<CR>
	function! Shell_sim(opt)
			" Get the bytecode.
		execute "normal! ma:cd %:h\<cr>gg/\\<module\\>\<cr>w"
		let model_tb = expand("<cword>")
		echo "执行仿真模块：".model_tb
		normal! `a

		silent !clear
		execute "! /home/ealge/Desktop/script/vcs_sim.sh ".model_tb.a:opt."&"

""		let bytecode = system("/home/ealge/Desktop/script/vcs_sim.sh ".model_tb.a:opt)
""		" Open a new split and set it up.
""		setlocal splitbelow
""		split _Shell_sim_
""		normal! ggdG
""		setlocal filetype=
""		setlocal buftype=nofile
""		setlocal bufhidden=hide
""		setlocal noswapfile
""		setlocal nobuflisted
""		setlocal nowrap
""
""		" Insert the bytecode.
""		call append(0, split(bytecode, '\v\n'))	
""		execute "normal! G\<C-l>"
""		nnoremap <buffer> q :q<CR>
	endfunction

function! HandleURL()
	let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
	echo s:uri
	if s:uri != ""
	call system("google-chrome ".s:uri."&")
	else
	  echo "No URI found in line."
	endif
	execute "normal! \<C-l>"
endfunction
noremap <ESC>w :call HandleURL()<cr>
