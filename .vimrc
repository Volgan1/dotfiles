call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'mileszs/ack.vim'
Plug 'simeji/winresizer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'w0rp/ale'
Plug 'morhetz/gruvbox'
"Plug 'Valloric/YouCompleteMe'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'tpope/vim-repeat'
Plug 'sjl/gundo.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'tpope/vim-obsession'
Plug 'bling/vim-bufferline'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'benmills/vimux'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'Rip-Rip/clang_complete', { 'for': ['c', 'cpp'] ],
"Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
Plug 'xuyuanp/nerdtree-git-plugin'

call plug#end()
filetype plugin indent on

set confirm
set nocompatible " not compatible with vi"
syntax on

let g:mapleader = ","
let g:maplocalleader = ";"

" Цветовые схемы
  set t_Co=256
  colorscheme gruvbox
  set background=dark
  let g:gruvbox_contrast_dark = "light"
  set autoread
  syntax enable
  
  let g:airline_powerline_fonts=1
  let g:airline_left_sep=''
  let g:airline_right_sep=''
  let g:airline_theme='bubblegum'

" Interface
  let g:startify_files_number = 100
  let g:startify_bookmarks = [
            \ { 'v': '~/.vimrc' },
            \ { 't': '~/.tmux.conf' },
            \ { 'z': '~/.zshrc' }
            \ ]
  set encoding=utf-8
  set fileencodings=utf-8,cp1251
  set fileformat=unix
  set wildmenu
  set wildmode=list:longest,full
  set wildignore+=.hg,.git,.svn
  set wildignore+=*.pyc
  set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
  set title
  set showcmd
  set scrolljump=5
  set scrolloff=999
  set showtabline=2
  set list
  set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×
  set startofline

  set wrap
  set linebreak
  if has("linebreak")
    let &sbr = nr2char(8618).' '
  endif

  set colorcolumn=80
  set textwidth=80
  set autoindent
  set smartindent
  set shiftwidth=2
  set expandtab
  set tabstop=2
  set softtabstop=2
  set cursorline
  set splitbelow
  set splitright
  set shortmess+=I
  set mouseshape=s:udsizing,m:no
  set hidden

  set visualbell
  set t_vb=

  set path=.,,**

  let g:bufferline_echo = 0
  " F2  Переключение нумерации строк 
    let g:relativenumber = 1
    set norelativenumber
    set number
    function! ToogleRelativeNumber()
      if g:relativenumber == 0
        let g:relativenumber = 1
        set norelativenumber
        set number
        echo "Прямая нумерация"
      elseif g:relativenumber == 1
        let g:relativenumber = 2
        set nonumber
        set relativenumber
        echo "Относительная нумерация"
      else
        let g:relativenumber = 0
        set nonumber
        set norelativenumber
        echo "Без нумерации"
      endif
    endfunction
    nnoremap <F2> :<C-u>call ToogleRelativeNumber()<cr>

  " F3  Показать / убрать линии отступов 
    nnoremap <F3> :<C-u>IndentGuidesToggle<CR>

    let g:indent_guides_guide_size = 1

" Create encodings menu
  menu Encoding.UTF-8 :e ++enc=utf8 <CR>
  menu Encoding.Windows-1251 :e ++enc=cp1251<CR>
  menu Encoding.koi8-r :e ++enc=koi8-r<CR>
  menu Encoding.cp866 :e ++enc=cp866<CR>

" Folding
  nnoremap <F4> zM
  nnoremap <F5> zR
  nnoremap <Space> za
  set foldcolumn=4
  function! MyFoldText()
    let line = getline(v:foldstart)
    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart
    " expand tabs into spaces
    let onetab = strpart(' ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')
    let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
  endfunction
  set foldtext=MyFoldText()
  set foldmethod=indent
  set foldnestmax=10
  set nofoldenable
  set foldlevel=1
  set fillchars="fold: "

" Search
  set incsearch
  set hlsearch
  set ignorecase
  set smartcase
  set gdefault

  " ,r Найти и заменить во всех буферах слово под курсором
    function! Replace()
      let s:word = input("Replace " . expand('<cword>') . " with:")
      :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/gce'
      :unlet! s:word
    endfunction
    nnoremap <Leader>r :<C-u>call Replace()<CR>
  
  " <Esc><Esc> Сброс поиска в Normal mode
    nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

  " ,f Поиск через Аск слова под курсором
    nnoremap <Leader>f :<C-u>execute "Ack " . expand("<cword>") <Bar> cw<CR>
  " ,a Поиск фразы через Аск
    nnoremap <leader>a :<C-u>Ack<Space>
  " ,s Вывод в командной строке начало поиска ':%s//'
    nnoremap <leader>s :<C-u>%s//<left>
    vnoremap <leader>s :s//<left>

  " n и N
    " Search matches are always in center
    nnoremap n nzz
    nnoremap N Nzz
    nnoremap * *zz
    nnoremap # #zz

  "Recursive search in current directory for matches with current word
    nnoremap g* g*zz
    nnoremap g# g#zz

" mappings
  "Вставка ' ; '  в конец строки
    nnoremap <leader>; <Esc>A;<Esc>

  " ,m  Активация / деактивация мыши
    set mouse=a
    function! ToggleMouse()
      if &mouse == 'a'
        set mouse=
        echo "Мышь не активна"
      else
        set mouse=a
        echo "Мышь активна"
      endif
    endfunction
    nnoremap <leader>m :call ToggleMouse()<CR>

  " < > Переход на прошлое / следующее выделение
    vnoremap < <gv
    vnoremap > >gv

  " ,p Переключение режимов вставки (вставка/вклейка) 
    set pastetoggle=<Leader>p

  "Переместить строки вверх / вниз
    " одна строка
    nnoremap <leader>k ddkP
    nnoremap <leader>j ddp
    " выделенные строки
    vnoremap <leader>k xkP'[V']
    vnoremap <leader>j xp'[V']

  " Y Копирование от курсора до конца строки 
    nnoremap Y y$

  " Pasting with correct indention
    " nnoremap p p=`]
    " nnoremap P P=`[

  " Деактивация стрелок
    inoremap <Up> <NOP>
    inoremap <Down> <NOP>
    inoremap <Right> <NOP>
    inoremap <Left> <NOP> 
    noremap <Up> <NOP>
    noremap <Down> <NOP>
    noremap <Left> <NOP>
    noremap <Right> <NOP>

  " Навигация в режиме Insert по J K H L
    inoremap <C-h> <C-o>h
    inoremap <C-j> <C-o>j
    inoremap <C-k> <C-o>k
    inoremap <C-l> <C-o>l

  " Перемещение по сплитам
    nnoremap <C-h> <C-W>h
    nnoremap <C-j> <C-W>j
    nnoremap <C-k> <C-W>k
    nnoremap <C-l> <C-W>l
  " ,w Прыжок на следующий сплит
    nnoremap <Leader>w <C-w>w


  " <localleader>z Открыть .zshrc в новой вкладке
    nnoremap <localleader>z :<C-u>tabedit ~/.zshrc<CR>
    :cabbrev e NERDTreeClose<CR>:e!
  " <localleader>v Открыть .vimrc в новой вкладке
    nnoremap <localleader>v :<C-u>tabedit $MYVIMRC<CR>
    :cabbrev e NERDTreeClose<CR>:e!
  " <localleader>t Открыть .tmux.conf в новой вкладке 
    nnoremap <localleader>t :<C-u>tabnew ~/.tmux.conf<CR>
    :cabbrev e NERDTreeClose<CR>:e!

  " Hовое окно относительно текущего
    nnoremap <Leader><left>  :<C-u>leftabove  vnew<CR>
    nnoremap <Leader><right> :<C-u>rightbelow vnew<CR>
    nnoremap <Leader><up>    :<C-u>leftabove  new<CR>
    nnoremap <Leader><down>  :<C-u>rightbelow new<CR>

  " K перенос строки (начало следующей- позиция курсора)
    nnoremap K <nop>
    nnoremap K h/[^ ]<cr>"zd$jyyP^v$h"zpJk:s/\v +$//<cr>:noh<cr>j^

  " Перемещение по обернутым линиям
    noremap j gj
    noremap k gk

  " ,ts Удаление лишних пробелов в конце строк
    nnoremap <leader>ts :<C-u>%s/\s\+$//e<CR>

  " ,mm -показать все метки     ,md -удалить метки
    nnoremap <leader>mm :<C-u>marks<CR>
    nnoremap <leader>md :<C-u>delmarks

  "Работа с буферами, табами и вкладками
  " ;b Показать буфера
    nnoremap <localleader>b :<C-u>BufExplorerVerticalSplit<CR>
    let g:bufExplorerShowNoName=1
    let g:bufExplorerSplitHorzSize=10
    let g:bufExplorerDefaultHelp=0
    let g:bufExplorerDetailedHelp=1
  " ;n перейти в следующий буфер
    nnoremap <localleader>n :<C-u>bn<cr>
  " ;p перейти в предыдущий
    nnoremap <localleader>p :<C-u>bp<cr>
    ";0-9 переход к буферам
    nnoremap <localleader>0 :<C-u>b0<CR>
    nnoremap <localleader>1 :<C-u>b1<CR>
    nnoremap <localleader>2 :<C-u>b2<CR>
    nnoremap <localleader>3 :<C-u>b3<CR>
    nnoremap <localleader>4 :<C-u>b4<CR>
    nnoremap <localleader>5 :<C-u>b5<CR>
    nnoremap <localleader>6 :<C-u>b6<CR>
    nnoremap <localleader>7 :<C-u>b7<CR>
    nnoremap <localleader>8 :<C-u>b8<CR>
    nnoremap <localleader>9 :<C-u>b9<CR>
  " ;dd Закрыть текущий сплит и удалить буфер
    nnoremap <localleader>dd :<C-u>bw<CR>
  " ;d0-9 Удалить буфер 0-9 и закрыть сплит
    nnoremap <localleader>d0 :<C-u>bw0<CR>
    nnoremap <localleader>d1 :<C-u>bw1<CR>
    nnoremap <localleader>d2 :<C-u>bw2<CR>
    nnoremap <localleader>d3 :<C-u>bw3<CR>
    nnoremap <localleader>d4 :<C-u>bw4<CR>
    nnoremap <localleader>d5 :<C-u>bw5<CR>
    nnoremap <localleader>d6 :<C-u>bw6<CR>
    nnoremap <localleader>d7 :<C-u>bw7<CR>
    nnoremap <localleader>d8 :<C-u>bw8<CR>
    nnoremap <localleader>d9 :<C-u>bw9<CR>
  " ;da Удалить все буфера
    nnoremap <localleader>da :<C-u>wall<CR>

  " ;w  ;W Быстрое сохранение
    nnoremap <localleader>W :<C-u>wa<CR>
    nnoremap <localleader>w :<C-u>w<CR>
  " ;s  Сохранить и закрыть сплит
    nnoremap <localleader>s :<C-u>wq<CR>
  " ;c  Закрыть без сохранения 
    nnoremap <localleader>c :<C-u>q!<CR>
  " <C-c>  Закрыть все без сохранения
    nnoremap <C-c> :<C-u>qa!<CR>
  " ;q Сохранить и закрыть все
    nnoremap <localleader>q :<C-u>wqa<CR>

  " <Tab>h, <Tab>l Переход по вкладкам
    nnoremap <Tab>l gt
    nnoremap <Tab>h gT 
  " <S-Tab> создать новый таб <Enter>
    nnoremap <S-Tab> :<C-u>tabnew 
  " <Tab>c Закрыть текущую вкладку
    nnoremap <Tab>c :<C-u>tabc<CR>
  " <Tab>o Закрыть все вкладки кроме текущей
    nnoremap <Tab>o :<C-u>tabo<CR>
  " <Tab>b Все буфера во вкладки
    nnoremap <Tab>b :<C-u>tab ball<CR>
  " <Tab>t Текущий буфер в новой вкладке
    nnoremap <Tab>t <C-w>T
  " <Tab>d  Выполнить команду во всех вкладках
    nnoremap <Tab>d :<C-u>tabdo 
  " <Tab>s  показать все вкладки
    nnoremap <Tab>s :<C-u>tabs<CR>

  " ,n Открыть новый файл в текущей директории в вертикальном сплите
    noremap <Leader>n :<C-u>vnew <C-R>=expand("%:p:h") . '/'<CR>

  "Работа с регистрами
  " ;r  показать все регистры
    nnoremap <localleader>r :<C-u>reg<CR>
  " ;m  вставить из буфера мыши
    nnoremap <localleader>m "*p
  " ;p  вставить из буфера обмена
    nnoremap <localleader>p "+p
  " ;y  скопировать в буфер обмена
    vnoremap <localleader>y "+y

  " gf Открыть файл под курсором в новом вертикальном сплите
    nnoremap gf :<C-u>vertical wincmd f<CR>

  " ,u Изменить регистр на верхний регистр
    nnoremap <Leader>u gUiw
    inoremap <Leader>u <esc>gUiwea

  " ,b In Visual mode exec git blame with selected text
    vnoremap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

  "Bind :Q to :q
    command! Q q

  " Ремапим русские символы
    set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

" Environment
  " Store lots of history entries: :cmdline and search patterns
    set history=1000
  " Save file with root permissions
    command! W exec 'w !sudo tee % > /dev/null' | e!

  " Backspacing settings
    " start     allow backspacing over the start of insert;
    "           CTRL-W and CTRL-U stop once at the start of insert.
    " indent    allow backspacing over autoindent
    " eol       allow backspacing over line breaks (join lines)
    set backspace=indent,eol,start

  " Backup и swp files
    " Don't create backups
    set nobackup
    " Don't create swap files
    set noswapfile

  " Загрузка последней сесси
    " Only available when compiled with the +viminfo feature
    set viminfo='10,\"100,:20,%,n~/.viminfo
    " Установить курсор в последнее его положение
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

  " Авто перезагрузка конфигов после сохранение
    if has("autocmd")
      autocmd! bufwritepost .vimrc source ~/.vimrc
    endif

  " Auto change the directory to the current file I'm working on
    autocmd BufEnter * lcd %:p:h

" File specific
  "Шаблоны
    autocmd BufNewFile *.cpp 0r ~/work/templates/template.cpp
    autocmd BufNewFile *.c 0r ~/work/templates/template.c

  " С/C++ файлы
    " Расставлять отступы в стиле С
    autocmd filetype c,cpp set cin

  " make-файлы
    " В make-файлах нам не нужно заменять табуляцию пробелами
    autocmd filetype make set noexpandtab
    autocmd filetype make set nocin

  " html-файлы
    " Не расставлять отступы в стиле С в html файлах
    autocmd filetype html set noexpandtab
    autocmd filetype html set nocin
    autocmd filetype html set textwidth=160

  " css-файлы
    " Не расставлять отступы в стиле C и не заменять табуляцию пробелами
    autocmd filetype css set nocin
    autocmd filetype css set noexpandtab

  " python-файлы
    " Не расставлять отступы в стиле С
    autocmd filetype python set nocin


" Plugins
  " YouCompleteMe
    let g:ycm_global_ycm_extra_conf = '/home/volgan/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'


  " NERDTree
    nnoremap <Bs> :<C-u>NERDTreeToggle<CR>
    let NERDTreeShowBookmarks=1
    let NERDTreeChDirMode=2
    let NERDTreeQuitOnOpen=1
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=0
    let NERDTreeBookmarksFile= $HOME . '/.vim/.NERDTreeBookmarks'
    " Disable display of the 'Bookmarks' label and 'Press ? for help' text
    let NERDTreeMinimalUI=1
    " Use arrows instead of + ~ chars when displaying directories
    let NERDTreeDirArrows=1
    let g:NERDTreeShowIgnoredStatus = 1
    
  "Tagbar
    let g:tagbar_sort = 0
    let g:tagbar_autofocus = 1
    let g:tagbar_indent = 1
    let g:tagbar_singleclick = 1
    let g:tagbar_autoshowtag = 1
    nnoremap <Leader><BS> :<C-u>TagbarToggle<CR>

  " Snippets
    " Раскрыть шаблон
    let g:UltiSnipsExpandTrigger="<c-a>"
    " Отобразить список шаблонов
    let g:UltiSnipsListSnippets="<c-d>"
    " Идти вперед по шиблонам
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    " Идти назад  
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    " Разделять окно вертикально при редактировании
    let g:UltiSnipsEditSplit="vertical"
    " Версия Python (Нужно указать используемую в системе по-умолчанию)
    let g:UltiSnipsUsePythonVersion=3

  " Ale
    let g:airline#extensions#ale#enabled = 1

  " Easymotion
    function! s:config_easyfuzzymotion(...) abort
      return extend(copy({
      \   'converters': [incsearch#config#fuzzyword#converter()],
      \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
      \   'keymap': {"\<CR>": '<Over>(easymotion)'},
      \   'is_expr': 0,
      \   'is_stay': 1
      \ }), get(a:, 1, {}))
    endfunction
    noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
    " You can use other keymappings like <C-l> instead of <CR> if you want to
    " use these mappings as default search and somtimes want to move cursor with
    " EasyMotion.
    function! s:incsearch_config(...) abort
      return incsearch#util#deepextend(deepcopy({
      \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
      \   'keymap': {
      \     "\<CR>": '<Over>(easymotion)'
      \   },
      \   'is_expr': 0
      \ }), get(a:, 1, {}))
    endfunction
    noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
    noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
    noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

  " Gundo
    let g:gundo_prefer_python3=1
    nnoremap <localleader><BS> :<C-u>GundoToggle<CR>

  " F7 F8  Компиляция и запуск
    let g:termdebug_wide = 210
    function! s:compilers()
      exec 'w'
      if &filetype == 'c'
        exec "term++hidden gcc -O0 -g % -o %<"
      elseif &filetype == 'cpp'
        exec "term++hidden g++ -std=c++11 % -o %<"
      elseif &filetype == 'java'
        exec "term++hidden javac %"
      endif
    endfunction
    nnoremap <F7> :call <SID>compilers()<CR>

    function! s:runners()
      exec 'w'
      if &filetype == 'c' || &filetype == 'cpp'
        exec "vertical term ./%<"
      elseif &filetype == 'python'
        exec "vertical term python %"
      elseif &filetype == 'java'
        exec "vertical term java %<"
      elseif &filetype == 'sh'
        exec "vertical term bash %"
      endif
    endfunction
    nnoremap <F8> :call <SID>runners()<CR>

    function! s:debugge()
      exec 'w'
      if &filetype == 'c' || &filetype == 'cpp'
        exec "packadd termdebug"
        exec "Termdebug %<"
      endif
    endfunction
    nnoremap <F9> :call <SID>debugge()<CR>
