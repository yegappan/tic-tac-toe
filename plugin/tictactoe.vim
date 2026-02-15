vim9script

if exists('g:loaded_tictactoe')
  finish
endif
g:loaded_tictactoe = 1

import autoload '../autoload/tictactoe.vim'

command! TicTacToe tictactoe.Start()
