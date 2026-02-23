vim9script
# Tic-Tac-Toe Game Plugin for Vim9
# Play against computer AI with adjustable difficulty levels
# Requires: Vim 9.0+

if exists('g:loaded_tictactoe')
  finish
endif
g:loaded_tictactoe = 1

import autoload '../autoload/tictactoe.vim' as TicTacToe

# Default configuration
if !exists('g:tictactoe_difficulty')
  g:tictactoe_difficulty = 'medium'
endif

# Command to start the game
command! TicTacToe call TicTacToe.Start()
