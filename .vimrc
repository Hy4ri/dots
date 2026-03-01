" ---------------------------------------------------------------------------
"  Disable built-in plugins for performance
" ---------------------------------------------------------------------------
let g:loaded_gzip = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:loaded_logiPat = 1
let g:loaded_rrhelper = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_tutor_mode_plugin = 1

" ---------------------------------------------------------------------------
"  vim-plug: Auto-install if missing
" ---------------------------------------------------------------------------
let data_dir = has('vim') ? '~/.vim' : stdpath('data')
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" --- LSP, Linting, Formatting ---
Plug 'dense-analysis/ale'                    " Linting + formatting + LSP
Plug 'prabirshrestha/vim-lsp'                " LSP client
Plug 'mattn/vim-lsp-settings'                " Auto-install LSP servers
Plug 'rhysd/vim-lsp-ale'                     " Bridge ALE and vim-lsp

" --- Completion ---
Plug 'lifepillar/vim-mucomplete'             " Lightweight completion
Plug 'prabirshrestha/asyncomplete.vim'       " Async completion for vim-lsp
Plug 'prabirshrestha/asyncomplete-lsp.vim'   " LSP source for asyncomplete

" --- Snippets ---
Plug 'SirVer/ultisnips'                      " Snippet engine
Plug 'honza/vim-snippets'                    " Snippet collection

" --- Fuzzy finder ---
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" --- Git ---
Plug 'airblade/vim-gitgutter'                " Git signs in gutter
Plug 'tpope/vim-fugitive'                    " Git commands

" --- Editing ---
Plug 'tpope/vim-surround'                    " Surround operations (cs, ds, ys)
Plug 'tpope/vim-repeat'                      " Dot-repeat for plugins
Plug 'tpope/vim-commentary'                  " gcc / gc to comment
Plug 'justinmk/vim-sneak'                    " Enhanced f/t motions (s/S)

" --- Copilot ---
Plug 'github/copilot.vim'                    " GitHub Copilot

" --- Visual ---
Plug 'luochen1990/rainbow'                   " Rainbow brackets
Plug 'sakshamgupta05/vim-todo-highlight'     " TODO/FIXME highlighting

" --- File manager ---
Plug 'voldikss/vim-floaterm'                 " Float terminal (for yazi)

call plug#end()

" ---------------------------------------------------------------------------
"  OPTIONS (from options.lua)
" ---------------------------------------------------------------------------
set nocompatible
filetype plugin indent on
syntax enable

set arabicshape                " Correctly display Arabic character shapes
set autoread                   " Reload files changed outside Vim
set noautowrite                " Don't auto-save on buffer switch
set breakindent                " Indent wrapped lines to match code
set clipboard=unnamedplus      " System clipboard for all yank/paste
set colorcolumn=+1             " Draw column at textwidth+1
set copyindent                 " Copy indent structure from previous line
set cursorline                 " Highlight current line
set diffopt+=algorithm:patience,linematch:60,vertical
set noerrorbells               " No error bells
set expandtab                  " Spaces instead of tabs
set fillchars=eob:\ ,fold:\ ,foldclose:,foldopen:,foldsep:\ ,msgsep:─
set foldlevel=999              " Everything unfolded by default
set foldmethod=indent          " Use indent folding (treesitter not available)
set foldnestmax=10             " Limit fold levels
set formatlistpat=^\\s*[0-9\\-\\+\\*]\\+[\\.\\)]*\\s\\+
set formatoptions=rqnl1j       " Formatting options
set hlsearch                   " Highlight search matches
set ignorecase                 " Case-insensitive search
set incsearch                  " Incremental search
set infercase                  " Infer case in completion
set laststatus=2               " Always show statusline
set linebreak                  " Wrap at breakat characters
set listchars=tab:\ ↦,trail:·,nbsp:␣
set list                       " Show invisible characters
set mouse=a                    " Mouse support in all modes
set number                     " Absolute line numbers
set numberwidth=2              " Compact line number column
set pumheight=15               " Max completion popup height
set relativenumber             " Relative line numbers
set noruler                    " Hide cursor position in bottom-right
set scrolloff=8                " 8 lines context when scrolling
set shiftwidth=2               " 2-space indentation
set shortmess=loOstTWAcF       " Shorten messages
set showbreak=↪\               " Wrapped line indicator
set noshowmode                 " No -- INSERT -- indicator (statusline handles it)
set signcolumn=yes             " Always show sign column
set smartcase                  " Case-sensitive if uppercase in search
set smartindent                " Smart auto-indentation
set softtabstop=2              " Tab key inserts 2 spaces
set splitbelow                 " Horizontal splits open below
set splitright                 " Vertical splits open right
set tabstop=2                  " Tab width = 2 spaces
if has('termguicolors')
  set termguicolors            " 24-bit true color
endif
set timeoutlen=300             " Faster mapping timeout
set ttimeoutlen=50             " Faster key code timeout
set title                      " Set terminal title
set undofile                   " Persistent undo
set updatetime=300             " Faster CursorHold
set virtualedit=block          " Free cursor in visual block mode
set wildmenu                   " Enhanced command completion
set wildmode=longest:full,full
set nowrap                     " No line wrapping
set encoding=utf-8
set hidden                     " Allow unsaved buffers in background
set backspace=indent,eol,start " Sane backspace behavior

" ---------------------------------------------------------------------------
"  LEADER
" ---------------------------------------------------------------------------
let mapleader = ' '
let maplocalleader = ' '

" ---------------------------------------------------------------------------
"  KEYMAPS (from keymaps.lua)
" ---------------------------------------------------------------------------

" --- Disable arrow keys (training wheels) ---
nnoremap <left>  :echo "Use h to move!!"<CR>
nnoremap <right> :echo "Use l to move!!"<CR>
nnoremap <up>    :echo "Use k to move!!"<CR>
nnoremap <down>  :echo "Use j to move!!"<CR>
inoremap <left>  <C-o>:echo "Use h to move!!"<CR>
inoremap <right> <C-o>:echo "Use l to move!!"<CR>
inoremap <up>    <C-o>:echo "Use k to move!!"<CR>
inoremap <down>  <C-o>:echo "Use j to move!!"<CR>

" --- Navigate between splits (Alt+hjkl) ---
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" --- Splits ---
nnoremap <leader>sv <C-w>v
nnoremap <leader>sh <C-w>s

" --- Clean x and c (delete to black hole) ---
nnoremap x "_x
nnoremap c "_c

" --- Arabic toggle ---
nnoremap <leader>ar :if &keymap ==# 'arabic' <Bar> set noarabic <Bar> else <Bar> set arabic <Bar> endif<CR>

" --- Keep cursor centered ---
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" --- Powerful Escape ---
inoremap <Esc> <Esc>:nohlsearch<CR>
nnoremap <Esc> :nohlsearch<CR>
snoremap <Esc> <Esc>:nohlsearch<CR>

" --- Better j/k (respect display lines) ---
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
xnoremap <expr> j v:count == 0 ? 'gj' : 'j'
xnoremap <expr> k v:count == 0 ? 'gk' : 'k'

" --- Buffer navigation ---
nnoremap <S-h> :bprevious<CR>
nnoremap <S-l> :bnext<CR>
tnoremap <S-h> <C-\><C-n>:bprevious<CR>
tnoremap <S-l> <C-\><C-n>:bnext<CR>

" --- Copy/Paste improvements ---
xnoremap p "_dP
xnoremap P "_dP
nnoremap yY :%y+<CR>

" --- Move highlighted text ---
xnoremap J :move '>+1<CR>gv=gv
xnoremap K :move '<-2<CR>gv=gv
xnoremap > >gv
xnoremap < <gv

" --- Fix J cursor placement ---
nnoremap J mzJ`z

" --- Fuzzy finder (fzf.vim) ---
nnoremap <leader>sp :FZF<CR>
nnoremap <leader>sb :Buffers<CR>
nnoremap <leader>sf :Files<CR>
nnoremap <leader>sg :Rg<CR>

" --- Quick actions ---
nnoremap <leader>w :w<CR>
nnoremap <leader>q :bd<CR>
nnoremap <leader>r :%s/
xnoremap <leader>r :s/
nnoremap U <C-r>
nnoremap <silent> <leader>X :!chmod +x %<CR>

" --- Terminal ---
nnoremap <leader>t :enew<CR>:terminal<CR>

" --- Math on selection ---
xnoremap <leader>b c<C-r>=<C-r>"<CR><Esc>

" --- Toggle options ---
nnoremap <leader>uw :set invwrap<CR>

" --- File manager (yazi via floaterm) ---
nnoremap <silent> - :FloatermNew --height=0.9 --width=0.9 yazi<CR>

" --- Diagnostics (ALE) ---
nnoremap ]d :ALENextWrap<CR>
nnoremap [d :ALEPreviousWrap<CR>
nnoremap <leader>xX :lopen<CR>
nnoremap <leader>xx :lopen<CR>

" --- LSP-like keymaps (via vim-lsp) ---
nnoremap <leader>rn :LspRename<CR>
nnoremap <leader>ca :LspCodeAction<CR>
nnoremap K :LspHover<CR>
nnoremap gd :LspDefinition<CR>
nnoremap gr :LspReferences<CR>

" ---------------------------------------------------------------------------
"  AUTOCOMMANDS
" ---------------------------------------------------------------------------

" --- Highlight on yank (Vim 8.0.1394+) ---
if exists('##TextYankPost')
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! call timer_start(0,
      \ {-> execute("let v:hlsearch=1 | call matchadd('IncSearch', '\\%''\\[\\_.*\\%'']', 100, -1,
      \ {'window': win_getid()}) | call timer_start(200,
      \ {-> execute('call clearmatches()')}, {'repeat': 1})", '')}, {'repeat': 1})
  augroup END
endif

" Simpler yank highlight fallback
augroup highlight_yank
  autocmd!
  if has('patch-8.0.1394')
    autocmd TextYankPost * call s:YankHighlight()
  endif
augroup END

function! s:YankHighlight()
  let l:start = getpos("'[")
  let l:end_pos = getpos("']")
  if l:start[1] > 0 && l:end_pos[1] > 0
    let l:matchid = matchadd('IncSearch', '\%' . l:start[1] . 'l\%' . l:start[2] . 'c\_.*\%' . l:end_pos[1] . 'l\%' . (l:end_pos[2]+1) . 'c')
    call timer_start(200, {-> matchdelete(l:matchid)})
  endif
endfunction

" --- Close certain filetypes with q ---
augroup close_with_q
  autocmd!
  autocmd FileType gitcommit,gitrebase,gitconfig,help,man,qf,startuptime
    \ nnoremap <buffer> q :quit<CR>
augroup END

" --- Resize splits on terminal resize ---
augroup resize_splits
  autocmd!
  autocmd VimResized * tabdo wincmd = | tabnext
augroup END

" --- Restore last cursor position ---
augroup last_loc
  autocmd!
  autocmd BufReadPost *
    \ if &filetype !=# 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   execute 'normal! g`"' |
    \ endif
augroup END

" --- Reload files when gaining focus ---
augroup checktime
  autocmd!
  autocmd FocusGained,BufEnter * if &buftype !=# 'nofile' | checktime | endif
augroup END

" --- Disable comment continuation ---
augroup disable_comment_continuation
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" --- Open help in vertical split ---
augroup help_vertical_split
  autocmd!
  autocmd FileType help wincmd L
augroup END

" --- Auto create parent directories on save ---
augroup auto_create_dir
  autocmd!
  autocmd BufWritePre * call s:AutoMkdir(expand('<afile>:p:h'))
augroup END

function! s:AutoMkdir(dir)
  if a:dir =~# '^[a-z]\+://'
    return
  endif
  if !isdirectory(a:dir)
    call mkdir(a:dir, 'p')
  endif
endfunction

" --- Hide trailing spaces in insert mode ---
augroup HideTrailingSpaces
  autocmd!
  autocmd InsertEnter * setlocal listchars-=trail:·
  autocmd InsertLeave * setlocal listchars<
augroup END

" --- Smart relative line numbers ---
augroup toggle_line_numbers
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter *
    \ if &number && mode() !=# 'i' | set relativenumber | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave *
    \ if &number | set norelativenumber | endif
augroup END

" ---------------------------------------------------------------------------
"  COLORSCHEME
" ---------------------------------------------------------------------------
set background=dark

" Custom colorscheme inline (matches koda.nvim colors)
augroup KodaColors
  autocmd!
  autocmd ColorScheme * call s:SetKodaOverrides()
augroup END

function! s:SetKodaOverrides()
  " Core UI
  highlight Normal       guifg=#c2c2c2 guibg=#121212
  highlight NormalFloat  guifg=#c2c2c2 guibg=#1a1a1a
  highlight CursorLine   guibg=#1a1a1a cterm=NONE
  highlight CursorLineNr guifg=#e2e2e2 guibg=#1a1a1a gui=bold
  highlight LineNr       guifg=#555555 guibg=#121212
  highlight SignColumn   guibg=#121212
  highlight ColorColumn  guibg=#1a1a1a
  highlight Visual       guibg=#333333
  highlight Pmenu        guifg=#c2c2c2 guibg=#222222
  highlight PmenuSel     guifg=#121212 guibg=#990000 gui=bold
  highlight PmenuSbar    guibg=#333333
  highlight PmenuThumb   guibg=#990000
  highlight VertSplit    guifg=#333333 guibg=#121212
  highlight StatusLine   guifg=#c2c2c2 guibg=#222222
  highlight StatusLineNC guifg=#666666 guibg=#1a1a1a
  highlight WildMenu     guifg=#121212 guibg=#990000 gui=bold
  highlight MatchParen   guifg=#e2e2e2 guibg=#990000 gui=bold
  highlight Search       guifg=#121212 guibg=#EBCB8B
  highlight IncSearch    guifg=#121212 guibg=#990000 gui=bold
  highlight Directory    guifg=#990000

  " Syntax (matching koda style overrides)
  highlight Comment    guifg=#666666 gui=bold,italic
  highlight String     guifg=#e2e2e2 gui=bold
  highlight Constant   guifg=#990000 gui=bold
  highlight Function   guifg=#88C0D0 gui=bold,italic
  highlight Keyword    guifg=#81A1C1
  highlight Identifier guifg=#c2c2c2
  highlight Statement  guifg=#81A1C1
  highlight Type       guifg=#EBCB8B
  highlight PreProc    guifg=#990000
  highlight Special    guifg=#BF616A
  highlight Operator   guifg=#c2c2c2
  highlight Number     guifg=#B48EAD
  highlight Boolean    guifg=#990000 gui=bold
  highlight Float      guifg=#B48EAD
  highlight Error      guifg=#BF616A guibg=NONE gui=bold
  highlight Todo       guifg=#EBCB8B guibg=NONE gui=bold

  " Diff
  highlight DiffAdd    guifg=#A3BE8C guibg=#2a3a2a
  highlight DiffChange guifg=#EBCB8B guibg=#3a3520
  highlight DiffDelete guifg=#BF616A guibg=#3a2020
  highlight DiffText   guifg=#EBCB8B guibg=#4a4520 gui=bold

  " Diagnostics
  highlight ALEErrorSign   guifg=#BF616A guibg=#121212
  highlight ALEWarningSign guifg=#EBCB8B guibg=#121212
  highlight ALEInfoSign    guifg=#88C0D0 guibg=#121212
  highlight ALEError       guifg=#BF616A gui=underline
  highlight ALEWarning     guifg=#EBCB8B gui=underline
  highlight ALEInfo        guifg=#88C0D0 gui=underline

  " Git gutter
  highlight GitGutterAdd    guifg=#A3BE8C guibg=#121212
  highlight GitGutterChange guifg=#EBCB8B guibg=#121212
  highlight GitGutterDelete guifg=#BF616A guibg=#121212

  " Folding
  highlight Folded     guifg=#666666 guibg=#1a1a1a
  highlight FoldColumn guifg=#555555 guibg=#121212

  " Tab line
  highlight TabLine     guifg=#b2b2b2 guibg=#121212 gui=NONE
  highlight TabLineSel  guifg=#e2e2e2 guibg=#990000 gui=bold,italic
  highlight TabLineFill guibg=#121212

  " Misc
  highlight NonText    guifg=#333333
  highlight SpecialKey guifg=#333333
  highlight Title      guifg=#990000 gui=bold
  highlight ErrorMsg   guifg=#BF616A guibg=NONE gui=bold
  highlight WarningMsg guifg=#EBCB8B gui=bold
  highlight MoreMsg    guifg=#A3BE8C
  highlight Question   guifg=#88C0D0
endfunction

" Apply a dark colorscheme as base, then override
try
  colorscheme habamax
catch
  " habamax not available (pre Vim 9), use slate
  try
    colorscheme slate
  catch
  endtry
endtry

" Apply our koda-inspired overrides
call s:SetKodaOverrides()

" ---------------------------------------------------------------------------
"  STATUSLINE
" ---------------------------------------------------------------------------

" Statusline highlight groups
function! s:SetStatuslineHighlights()
  highlight StlModeNorm  guifg=#121212 guibg=#990000 gui=bold
  highlight StlModeIns   guifg=#e2e2e2 guibg=#990000 gui=bold
  highlight StlModeVis   guifg=#990000 guibg=#121212 gui=bold
  highlight StlModeRep   guifg=#121212 guibg=#990000 gui=bold

  highlight StlTimeNorm  guifg=#121212 guibg=#990000 gui=bold
  highlight StlTimeIns   guifg=#e2e2e2 guibg=#990000 gui=bold
  highlight StlTimeVis   guifg=#990000 guibg=#121212 gui=bold
  highlight StlTimeRep   guifg=#121212 guibg=#990000 gui=bold

  highlight StlSecB      guifg=#c2c2c2 guibg=#222222
  highlight StlSecC      guifg=#b2b2b2 guibg=#121212
  highlight StlSep       guifg=#990000 guibg=#121212

  highlight StlDiffAdd   guifg=#A3BE8C guibg=#121212
  highlight StlDiffMod   guifg=#EBCB8B guibg=#121212
  highlight StlDiffRem   guifg=#BF616A guibg=#121212

  highlight StlDiagErr   guifg=#BF616A guibg=#121212
  highlight StlDiagWarn  guifg=#EBCB8B guibg=#121212
  highlight StlDiagInfo  guifg=#88C0D0 guibg=#121212
  highlight StlDiagHint  guifg=#81A1C1 guibg=#121212

  highlight StlMacro     guifg=#BF616A guibg=#121212 gui=bold

  highlight StlLocNumber guifg=#e2e2e2 guibg=#222222 gui=bold,italic
  highlight StlLocTotal  guifg=#990000 guibg=#222222 gui=italic
  highlight StlLocLetter guifg=#b2b2b2 guibg=#222222 gui=italic
endfunction

augroup StatuslineColors
  autocmd!
  autocmd ColorScheme * call s:SetStatuslineHighlights()
augroup END

call s:SetStatuslineHighlights()

" --- Statusline Functions ---

function! StlMode() abort
  let l:mode = mode()
  let l:mode_map = {
    \ 'n':      'NORMAL',     'no':  'OP-PENDING',
    \ 'v':      'VISUAL',     'V':   'VISUAL',    "\<C-v>": 'VISUAL',
    \ 's':      'SELECT',     'S':   'SELECT',    "\<C-s>": 'SELECT',
    \ 'i':      'INSERT',     'ic':  'INSERT',    'ix':     'INSERT',
    \ 'R':      'REPLACE',    'Rc':  'REPLACE',   'Rv':     'VIRT REPLACE',
    \ 'c':      'COMMAND',    'cv':  'VIM EX',    'ce':     'EX',
    \ 'r':      'PROMPT',     'rm':  'MORE',      'r?':     'CONFIRM',
    \ '!':      'SHELL',      't':   'TERMINAL',
    \ }
  let l:txt = get(l:mode_map, l:mode, 'UNKNOWN')

  if l:mode =~# 'i'
    return '%#StlModeIns# ' . l:txt . ' '
  elseif l:mode =~# '[vV]' || l:mode ==# "\<C-v>"
    return '%#StlModeVis# ' . l:txt . ' '
  elseif l:mode =~# 'R'
    return '%#StlModeRep# ' . l:txt . ' '
  endif
  return '%#StlModeNorm# ' . l:txt . ' '
endfunction

function! StlFile() abort
  let l:file = expand('%:t')
  if l:file ==# ''
    let l:file = '[No Name]'
  endif
  if &modified
    let l:file .= ' ●'
  endif
  if &readonly || !&modifiable
    let l:file .= ' '
  endif
  return '%#StlSecB# ' . l:file . ' '
endfunction

function! StlSearch() abort
  if !v:hlsearch
    return ''
  endif
  let l:reg = getreg('/')
  if l:reg ==# ''
    return ''
  endif
  try
    let l:count = searchcount({'recompute': 1, 'maxcount': 0})
    if l:count.total == 0
      return ''
    endif
    return '%#StlSecB# ' . l:count.current . '/' . l:count.total . ' '
  catch
    return ''
  endtry
endfunction

function! StlBranch() abort
  " Try gitgutter first
  if exists('b:gitgutter') && has_key(b:gitgutter, 'summary')
    " gitgutter doesn't expose branch, use fugitive
  endif
  " Use fugitive for branch name
  if exists('*FugitiveHead')
    let l:head = FugitiveHead()
    if l:head !=# ''
      return '%#StlSecC#  ' . l:head . ' '
    endif
  endif
  return ''
endfunction

function! StlDiff() abort
  let l:ret = ''
  " Try gitgutter
  if exists('*GitGutterGetHunkSummary')
    let [l:a, l:m, l:r] = GitGutterGetHunkSummary()
    if l:a > 0
      let l:ret .= '%#StlDiffAdd#+' . l:a . ' '
    endif
    if l:m > 0
      let l:ret .= '%#StlDiffMod#~' . l:m . ' '
    endif
    if l:r > 0
      let l:ret .= '%#StlDiffRem#-' . l:r . ' '
    endif
  endif
  return l:ret
endfunction

function! StlDiag() abort
  let l:ret = ''
  if !exists('*ale#statusline#Count')
    return l:ret
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:errors = l:counts.error + l:counts.style_error
  let l:warnings = l:counts.warning + l:counts.style_warning
  let l:infos = l:counts.info

  if l:errors > 0
    let l:ret .= '%#StlDiagErr# ' . l:errors . ' '
  endif
  if l:warnings > 0
    let l:ret .= '%#StlDiagWarn# ' . l:warnings . ' '
  endif
  if l:infos > 0
    let l:ret .= '%#StlDiagInfo# ' . l:infos . ' '
  endif
  return l:ret
endfunction

function! StlLsp() abort
  " Show ALE linter/LSP info
  if exists('*lsp#get_server_status')
    let l:servers = lsp#get_allowed_servers()
    if !empty(l:servers)
      return '%#StlSecC#' . join(l:servers, ', ') . ' '
    endif
  endif
  return ''
endfunction

function! StlMacro() abort
  let l:reg = reg_recording()
  if l:reg ==# ''
    return ''
  endif
  return '%#StlMacro#/ @' . l:reg . ' '
endfunction

function! StlFileFmt() abort
  let l:fmt = &fileformat
  let l:icon = ''
  if l:fmt ==# 'unix'
    let l:icon = ' '
  elseif l:fmt ==# 'dos'
    let l:icon = ' '
  elseif l:fmt ==# 'mac'
    let l:icon = ' '
  endif
  return '%#StlSecC#' . l:icon . ' '
endfunction

function! StlBuf() abort
  let l:bufs = filter(range(1, bufnr('$')), 'buflisted(v:val)')
  let l:total = len(l:bufs)
  if l:total <= 1
    return ''
  endif
  let l:current = bufnr('%')
  let l:idx = index(l:bufs, l:current) + 1
  return '%#StlLocLetter# b:%#StlLocNumber#' . l:idx . '%#StlLocTotal#/' . l:total
endfunction

function! StlLoc() abort
  return StlBuf()
    \ . '%#StlLocLetter# l:%#StlLocNumber#%l%#StlLocTotal#/%L'
    \ . '%#StlLocLetter# c:%#StlLocNumber#%v '
endfunction

function! StlTime() abort
  let l:mode = mode()
  let l:hl = 'StlTimeNorm'
  if l:mode =~# 'i'
    let l:hl = 'StlTimeIns'
  elseif l:mode =~# '[vV]' || l:mode ==# "\<C-v>"
    let l:hl = 'StlTimeVis'
  elseif l:mode =~# 'R'
    let l:hl = 'StlTimeRep'
  endif
  return '%#' . l:hl . '# ' . strftime('%I:%M') . ' '
endfunction

function! ActiveStatusline() abort
  return StlMode()
    \ . StlFile()
    \ . StlSearch()
    \ . StlBranch()
    \ . StlDiff()
    \ . '%#StlSecC#%='
    \ . StlDiag()
    \ . StlLsp()
    \ . StlMacro()
    \ . '%#StlSep#/'
    \ . StlFileFmt()
    \ . StlLoc()
    \ . StlTime()
endfunction

set statusline=%!ActiveStatusline()

" ---------------------------------------------------------------------------
"  PLUGIN CONFIG: ALE (LSP + Linting + Formatting)
" ---------------------------------------------------------------------------

" Linters by filetype
let g:ale_linters = {
  \ 'lua':        ['lua_language_server'],
  \ 'python':     ['pyright', 'flake8'],
  \ 'javascript': ['eslint'],
  \ 'sh':         ['shellcheck'],
  \ 'go':         ['gopls'],
  \ 'nix':        ['nix'],
  \ 'css':        ['stylelint'],
  \ }

" Fixers by filetype
let g:ale_fixers = {
  \ '*':          ['remove_trailing_lines', 'trim_whitespace'],
  \ 'lua':        ['stylua'],
  \ 'sh':         ['shfmt'],
  \ 'python':     ['black'],
  \ 'javascript': ['prettier'],
  \ 'json':       ['prettier'],
  \ 'jsonc':      ['prettier'],
  \ 'css':        ['prettier'],
  \ 'scss':       ['prettier'],
  \ 'markdown':   ['prettier'],
  \ 'nix':        ['alejandra'],
  \ 'go':         ['gofumpt'],
  \ }

" Fix on save
let g:ale_fix_on_save = 1

" Disable fix on save for C/C++
augroup ALEFixDisable
  autocmd!
  autocmd FileType c,cpp let b:ale_fix_on_save = 0
augroup END

" Sign icons
let g:ale_sign_error = '󰅚'
let g:ale_sign_warning = '󰀪'
let g:ale_sign_info = '󰋽'
let g:ale_sign_style_error = '󰅚'
let g:ale_sign_style_warning = '󰀪'

" Virtual text (Vim 9.0+ / Neovim)
if has('patch-9.0.0297') || has('nvim')
  let g:ale_virtualtext_cursor = 'current'
endif

let g:ale_echo_msg_format = '%severity%: %s [%linter%]'
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_delay = 300
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_open_list = 0
let g:ale_floating_preview = 1

" ---------------------------------------------------------------------------
"  PLUGIN CONFIG: vim-lsp
" ---------------------------------------------------------------------------
let g:lsp_diagnostics_enabled = 0   " Let ALE handle diagnostics
let g:lsp_document_highlight_enabled = 1
let g:lsp_fold_enabled = 0

" Auto-detect and register LSP servers via vim-lsp-settings
if exists('*lsp#enable')
  " vim-lsp-settings handles server installation automatically
endif

" ---------------------------------------------------------------------------
"  PLUGIN CONFIG: Completion (mucomplete + asyncomplete)
" ---------------------------------------------------------------------------
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" MUcomplete settings
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 100
let g:mucomplete#chains = {
  \ 'default': ['omni', 'ulti', 'path', 'keyn', 'dict'],
  \ 'vim':     ['cmd',  'ulti', 'path', 'keyn'],
  \ }

" ---------------------------------------------------------------------------
"  PLUGIN CONFIG: UltiSnips
" ---------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

" ---------------------------------------------------------------------------
"  PLUGIN CONFIG: GitGutter
" ---------------------------------------------------------------------------
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_modified_removed = '~'
set updatetime=300

" ---------------------------------------------------------------------------
"  PLUGIN CONFIG: fzf.vim
" ---------------------------------------------------------------------------
let g:fzf_layout = { 'down': '40%' }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Use Rg for live grep equivalent
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>),
  \   1, fzf#vim#with_preview(), <bang>0)

" ---------------------------------------------------------------------------
"  PLUGIN CONFIG: Rainbow Brackets
" ---------------------------------------------------------------------------
let g:rainbow_active = 1

" ---------------------------------------------------------------------------
"  PLUGIN CONFIG: vim-sneak
" ---------------------------------------------------------------------------
let g:sneak#label = 1

" ---------------------------------------------------------------------------
"  PLUGIN CONFIG: floaterm (for yazi)
" ---------------------------------------------------------------------------
let g:floaterm_opener = 'edit'

" ---------------------------------------------------------------------------
"  TODO Comment Highlighting
" ---------------------------------------------------------------------------
" vim-todo-highlight config
let g:todo_highlight_config = {
  \ 'TODO':  { 'gui_fg_color': '#2563EB',  'gui_bg_color': 'NONE', 'gui': 'bold' },
  \ 'FIXME': { 'gui_fg_color': '#DC2626',  'gui_bg_color': 'NONE', 'gui': 'bold' },
  \ 'HACK':  { 'gui_fg_color': '#FBBF24',  'gui_bg_color': 'NONE', 'gui': 'bold' },
  \ 'WARN':  { 'gui_fg_color': '#FBBF24',  'gui_bg_color': 'NONE', 'gui': 'bold' },
  \ 'NOTE':  { 'gui_fg_color': '#10B981',  'gui_bg_color': 'NONE', 'gui': 'bold' },
  \ 'PERF':  { 'gui_fg_color': '#7C3AED',  'gui_bg_color': 'NONE', 'gui': 'bold' },
  \ 'TEST':  { 'gui_fg_color': '#FF00FF',  'gui_bg_color': 'NONE', 'gui': 'bold' },
  \ 'BUG':   { 'gui_fg_color': '#DC2626',  'gui_bg_color': 'NONE', 'gui': 'bold' },
  \ }

" ---------------------------------------------------------------------------
"  Misc
" ---------------------------------------------------------------------------

" Redraw statusline periodically (for clock)
if has('timers')
  call timer_start(30000, {-> execute('redrawstatus')}, {'repeat': -1})
endif
