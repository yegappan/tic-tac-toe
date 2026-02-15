vim9script

import './types.vim' as Types
import './game.vim' as GameMod
import './strategy.vim' as StrategyMod

export class RandomStrategy implements StrategyMod.Strategy
  def Move(game: GameMod.Game): Types.Position
    var moves = game.AvailableMoves()
    if moves->len() == 0
      return [0, 0]
    endif
    var idx = rand() % moves->len()
    return moves[idx]
  enddef
endclass
