vim9script

import './types.vim' as Types
import './game.vim' as GameMod
import './strategy.vim' as StrategyMod

export class MediumStrategy implements StrategyMod.Strategy
  def Move(game: GameMod.Game): Types.Position
    var win = game.FindWinningMove(Types.Cell.O)
    if win[0] >= 0
      return win
    endif

    var block = game.FindWinningMove(Types.Cell.X)
    if block[0] >= 0
      return block
    endif

    var moves = game.AvailableMoves()
    if moves->len() == 0
      return [0, 0]
    endif
    return moves[rand() % moves->len()]
  enddef
endclass
