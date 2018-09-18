set number
syntax on
set tabstop=4
set backspace=indent,eol,start  
" 你在此设置运行时路径
set rtp+=~/.vim/bundle/vundle
call vundle#begin()
" 让vundle管理插件版本,必须。" 这应该始终是第一个
Plugin 'VundleVim/Vundle.vim'		
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe' 
Plugin 'vim-airline'
Plugin 'vim-airline-themes'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'chxuan/cpp-mode'
Plugin 'haya14busa/incsearch.vim'
call vundle#end()
map <f2> :NERDTreeToggle<cr>

""NERDTree
""修改树的显示图标
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
""窗口位置
let g:NERDTreeWinPos='left'
""窗口尺寸
let NERDTreeWinSize=15


"YouCompleteMe
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
""inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	"回车即选中当前项
let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview

" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=1

""打开后光标回到上次位置
if has("autocmd")

  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif
set cindent

""taglist
let Tlist_Show_One_File=1     "不同时显示多个文件的tag，只显示当前文件的    
let Tlist_Exit_OnlyWindow=1   "如果taglist窗口是最后一个窗口，则退出vim 
let Tlist_Ctags_Cmd="/usr/bin/ctags" "将taglist与ctags关联 
let Tlist_Use_Right_Window=1 "在Vim窗口右侧显示taglist窗口
let Tlist_WinWidth=20        "设置taglist宽度
let Tlist_Show_One_File=1    "只显示当前文件的tags
map <f3> :TlistToggle<cr>


""airline
set laststatus=2  "永远显示状态栏
let g:airline#extensions#tabline#enabled = 1
nnoremap <C-n> :bn<CR>
nnoremap <C-n> :bn<CR>

""buffer
nnoremap <C-a> :A<CR>


"cpp-enhanced-highlight
"高亮类，成员函数，标准库和模板
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
"文件较大时使用下面的设置高亮模板速度较快，但会有一些小错误
"let g:cpp_experimental_template_highlight = 1


""cpp-mode 
""nnoremap <C-y> :CopyCode<cr>
"nnoremap <C-p> :PasteCode<cr>

""incsearch"
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


set hlsearch            " 高亮显示搜索结果
set incsearch           " 开启实时搜索功能
set ignorecase          " 搜索时大小写不敏感"

""airline
"let g:airline_theme='bubblegum'
