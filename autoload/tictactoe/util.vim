vim9script

import './types.vim' as Types

export def DefineHighlights(): void
  highlight default TicTacToeCursor cterm=reverse gui=reverse
  highlight default TicTacToeWinX ctermfg=Green gui=bold
  highlight default TicTacToeWinO ctermfg=Red gui=bold
enddef

export def DifficultyFromSetting(): Types.Difficulty
  var value = get(g:, 'tictactoe_difficulty', 'medium')
  if value ==# 'easy'
    return Types.Difficulty.Easy
  elseif value ==# 'hard'
    return Types.Difficulty.Hard
  endif
  return Types.Difficulty.Medium
enddef

export def DifficultyName(level: Types.Difficulty): string
  if level == Types.Difficulty.Easy
    return 'Easy'
  elseif level == Types.Difficulty.Hard
    return 'Hard'
  endif
  return 'Medium'
enddef

export def NextDifficulty(level: Types.Difficulty): Types.Difficulty
  if level == Types.Difficulty.Easy
    return Types.Difficulty.Medium
  elseif level == Types.Difficulty.Medium
    return Types.Difficulty.Hard
  endif
  return Types.Difficulty.Easy
enddef
